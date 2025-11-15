terraform {
  required_version = "~> 1.12"

  required_providers {
    tailscale = {
      source  = "tailscale/tailscale"
      version = "0.24.0"
    }
  }
}
