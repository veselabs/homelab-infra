data "tailscale_device" "this" {
  hostname = var.hostname
}

resource "tailscale_device_subnet_routes" "routes" {
  device_id = data.tailscale_device.this.node_id
  routes = [
    "10.42.1.0/24",
    "0.0.0.0/0",
    "::/0",
  ]
}
