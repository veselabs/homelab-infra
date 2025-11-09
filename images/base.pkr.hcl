packer {
  required_plugins {
    name = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

variable "node" {
  type = string
}

source "proxmox-clone" "base" {
  node                     = var.node
  clone_vm_id              = 9000
  insecure_skip_tls_verify = true

  vm_name = "base"
  vm_id   = 9001

  scsi_controller = "virtio-scsi-pci"

  ssh_username = "root"

  network_adapters {
    model  = "virtio"
    bridge = "vmbr0"
  }

  ipconfig {
    ip = "dhcp"
  }

  cloud_init              = true
  cloud_init_storage_pool = "local-lvm"
}

build {
  sources = ["source.proxmox-clone.base"]
}
