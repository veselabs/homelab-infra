terraform {
  required_version = "~> 1.12"

  required_providers {
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
