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
    ip_gateway         = "10.42.1.1"
    api_ip_address     = "10.42.1.20"
    gateway_ip_address = "10.42.1.30"

    nodes = {
      master01 = {
        vm_id      = 111
        pve_node   = "pve01"
        ip_address = "10.42.1.21/24"
      }

      master02 = {
        vm_id      = 211
        pve_node   = "pve02"
        ip_address = "10.42.1.22/24"
      }

      master03 = {
        vm_id      = 311
        pve_node   = "pve03"
        ip_address = "10.42.1.23/24"
      }

      worker01 = {
        vm_id      = 421
        pve_node   = "pve04"
        ip_address = "10.42.1.24/24"
      }

      worker02 = {
        vm_id      = 521
        pve_node   = "pve05"
        ip_address = "10.42.1.25/24"
      }
    }
  }
}
