resource "proxmox_virtual_environment_container" "jumphost" {
  node_name = "pve01"
  vm_id     = 100

  unprivileged = true
  features {
    nesting = true
  }

  initialization {
    hostname = "jumphost"

    dns {
      servers = local.dns.servers
    }

    ip_config {
      ipv4 {
        address = local.jumphost_ip_address
        gateway = local.jumphost_ip_gateway
      }
    }

    user_account {
      keys = [local.sshkeys]
    }
  }

  network_interface {
    name = "vmbr0"
  }

  disk {
    datastore_id = "local-zfs"
    size         = 4
  }

  operating_system {
    template_file_id = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
    type             = "debian"
  }
}

resource "cloudflare_dns_record" "jumphost_homelab" {
  zone_id = var.cloudflare_zone_id
  name    = "jumphost.homelab"
  type    = "A"
  content = split("/", local.jumphost_ip_address)[0]
  ttl     = 1
}
