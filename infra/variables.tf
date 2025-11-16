variable "op_service_account_token" {
  type      = string
  ephemeral = true
  sensitive = true
}

variable "op_vault" {
  type = string
}

variable "cloudflare_account_id" {
  type = string
}

variable "cloudflare_zone_id" {
  type = string
}
