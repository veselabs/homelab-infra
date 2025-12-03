resource "proxmox_virtual_environment_vm" "kubernetes" {
  for_each = local.kubernetes.nodes

  name      = each.key
  node_name = each.value.pve_node
  vm_id     = each.value.vm_id
  tags      = ["kubernetes"]

  clone {
    vm_id = local.base_vm_id[each.value.pve_node]
  }

  cpu {
    cores = 6
  }

  memory {
    dedicated = 12288
    floating  = 12288
  }

  disk {
    interface    = "scsi0"
    datastore_id = "local-zfs"
    size         = 24
  }

  initialization {
    datastore_id = "local-zfs"

    dns {
      servers = local.dns.servers
    }

    ip_config {
      ipv4 {
        address = each.value.ip_address
        gateway = local.kubernetes.ip_gateway
      }
    }

    user_account {
      keys = [local.keys.ssh.master]
    }
  }
}

resource "cloudflare_dns_record" "kubernetes" {
  for_each = local.kubernetes.nodes

  zone_id = var.cloudflare_zone_id
  name    = "${each.key}.kubernetes.homelab"
  type    = "A"
  content = split("/", each.value.ip_address)[0]
  ttl     = 1
}
