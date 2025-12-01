locals {
  keys = {
    ssh = {
      master = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJBKvLCEwUG+hT5G0PFIHLPJK/rM8EiPngEkAkvLmo22"
    }
  }

  base_vm_id = {
    pve01 = 9100
    pve02 = 9200
    pve03 = 9300
    pve04 = 9400
    pve05 = 9500
  }

  dns = {
    servers = ["1.1.1.1", "1.0.0.1"]
  }

  kubernetes = {
    ip_gateway = "10.42.1.1"

    nodes = {
      master01 = {
        vm_id      = 101
        pve_node   = "pve01"
        ip_address = "10.42.1.21/24"
      }

      worker01 = {
        vm_id      = 401
        pve_node   = "pve04"
        ip_address = "10.42.1.31/24"
      }
    }
  }
}
