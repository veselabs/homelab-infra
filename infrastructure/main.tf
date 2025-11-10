provider "proxmox" {
  pm_tls_insecure = true
}

locals {
  sshkeys = <<-EOF
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJBKvLCEwUG+hT5G0PFIHLPJK/rM8EiPngEkAkvLmo22
  EOF
}

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
          storage = "local-lvm"
        }
      }
    }

    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"
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
