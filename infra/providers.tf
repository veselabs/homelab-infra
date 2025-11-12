provider "proxmox" {
  pm_tls_insecure = true
}

provider "onepassword" {
  service_account_token = var.op_service_account_token
}
