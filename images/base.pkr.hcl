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

variable "bootstrap_vm_id" {
  type = number
}

variable "base_vm_id" {
  type = number
}

source "proxmox-clone" "base" {
  node                     = var.node
  clone_vm_id              = var.bootstrap_vm_id
  insecure_skip_tls_verify = true

  vm_name = "base"
  vm_id   = var.base_vm_id

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
  cloud_init_storage_pool = "local-zfs"
}

build {
  sources = ["source.proxmox-clone.base"]

  provisioner "shell" {
    inline = ["cloud-init clean --logs --machine-id --seed --config all"]
  }
}
