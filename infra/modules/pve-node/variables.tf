variable "hostname" {
  type = string
}

variable "ip_address" {
  type = string
}

variable "advertise_routes" {
  type    = set(string)
  default = []
}

variable "advertise_exit_node" {
  type    = bool
  default = false
}

variable "cloudflare_zone_id" {
  type = string
}
