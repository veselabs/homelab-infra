resource "proxmox_vm_qemu" "jumphost" {
  count       = 0
  clone_id    = 9001
  name        = "jumphost"
  target_node = "pve01"

  tags = "jumphost"

  vm_state = "running"

  cpu {
    cores = 1
  }
  memory = 512

  scsihw = "virtio-scsi-pci"

  disks {
    scsi {
      scsi0 {
        disk {
          size    = "5G"
          storage = "local-zfs"
        }
      }
    }

    ide {
      ide2 {
        cloudinit {
          storage = "local-zfs"
        }
      }
    }
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr0"
  }

  ipconfig0 = "ip=dhcp"
  agent     = 1

  ciupgrade = true
  sshkeys   = local.sshkeys
}

resource "tailscale_tailnet_key" "pve" {
  description         = "Homelab PVE"
  tags                = ["tag:homelab-pve"]
  reusable            = true
  ephemeral           = false
  preauthorized       = true
  expiry              = 900
  recreate_if_invalid = "never"
}

resource "onepassword_item" "pve_tailnet_key" {
  vault    = var.op_vault
  title    = "Homelab PVE Tailnet Key"
  password = tailscale_tailnet_key.pve.key
}

module "pve_node" {
  source = "./modules/pve-node"

  for_each = {
    pve01 = {
      ip_address = "10.42.1.11"
    }
    pve02 = {
      ip_address = "10.42.1.12"
    }
    pve03 = {
      ip_address = "10.42.1.13"
    }
    pve04 = {
      ip_address = "10.42.1.14"
    }
    pve05 = {
      ip_address = "10.42.1.15"
    }
  }

  hostname           = each.key
  ip_address         = each.value.ip_address
  cloudflare_zone_id = var.cloudflare_zone_id
}

resource "cloudflare_dns_record" "pve_homelab" {
  zone_id = var.cloudflare_zone_id
  name    = "pve.homelab"
  type    = "CNAME"
  content = "pve.tail2be24.ts.net"
  ttl     = 1
}
