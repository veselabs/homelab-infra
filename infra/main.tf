resource "tailscale_tailnet_key" "pve" {
  description         = "Homelab PVE"
  tags                = ["tag:homelab-pve"]
  reusable            = true
  ephemeral           = false
  preauthorized       = true
  expiry              = 900
  recreate_if_invalid = "never"
}

resource "onepassword_item" "pve_tailnet_key" {
  vault    = var.op_vault
  title    = "Homelab PVE Tailnet Key"
  password = tailscale_tailnet_key.pve.key
}

module "pve_node" {
  source = "./modules/pve-node"

  for_each = {
    pve01 = {
      ip_address = "10.42.1.11"
    }
    pve02 = {
      ip_address = "10.42.1.12"
    }
    pve03 = {
      ip_address = "10.42.1.13"
    }
    pve04 = {
      ip_address = "10.42.1.14"
    }
    pve05 = {
      ip_address = "10.42.1.15"
    }
  }

  hostname            = each.key
  ip_address          = each.value.ip_address
  advertise_routes    = try(each.value.advertise_routes, ["10.42.1.0/24"])
  advertise_exit_node = try(each.value.advertise_exit_node, true)
  cloudflare_zone_id  = var.cloudflare_zone_id
}

resource "cloudflare_dns_record" "pve_homelab" {
  zone_id = var.cloudflare_zone_id
  name    = "pve.homelab"
  type    = "CNAME"
  content = "pve.tail2be24.ts.net"
  ttl     = 1
}

resource "proxmox_virtual_environment_metrics_server" "opentelemetry_server" {
  type   = "opentelemetry"
  name   = "alloy"
  server = "alloy-otlp.homelab.veselabs.com"
  port   = 443
}
