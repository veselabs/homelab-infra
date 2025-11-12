terraform {
  required_version = "~> 1.12"

  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.2-rc05"
    }

    tailscale = {
      source  = "tailscale/tailscale"
      version = "0.24.0"
    }
  }
}
