locals {
  sshkeys = <<-EOF
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJBKvLCEwUG+hT5G0PFIHLPJK/rM8EiPngEkAkvLmo22
  EOF

  dns = {
    servers = ["1.1.1.1", "1.0.0.1"]
  }

  jumphost_ip_address = "10.42.1.10/24"
  jumphost_ip_gateway = "10.42.1.1"
}
