data "tailscale_device" "this" {
  hostname = var.hostname
}

resource "tailscale_device_subnet_routes" "this" {
  device_id = data.tailscale_device.this.node_id
  routes = [
    "10.42.1.0/24",
    "0.0.0.0/0",
    "::/0",
  ]
}

resource "cloudflare_dns_record" "this" {
  zone_id = var.cloudflare_zone_id
  name    = "${var.hostname}.homelab"
  type    = "A"
  content = var.ip_address
  ttl     = 1
}
