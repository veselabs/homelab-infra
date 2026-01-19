terraform {
  required_version = "~> 1.12"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.93.0"
    }

    onepassword = {
      source  = "1Password/onepassword"
      version = "2.2.0"
    }

    tailscale = {
      source  = "tailscale/tailscale"
      version = "0.24.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.13.0"
    }
  }
}
