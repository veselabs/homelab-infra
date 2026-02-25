<!-- prettier-ignore-start -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.12 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | 5.13.0 |
| <a name="requirement_onepassword"></a> [onepassword](#requirement\_onepassword) | 2.2.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 0.93.0 |
| <a name="requirement_tailscale"></a> [tailscale](#requirement\_tailscale) | 0.24.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | 5.13.0 |
| <a name="provider_onepassword"></a> [onepassword](#provider\_onepassword) | 2.2.0 |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.93.0 |
| <a name="provider_tailscale"></a> [tailscale](#provider\_tailscale) | 0.24.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_pve_node"></a> [pve\_node](#module\_pve\_node) | ./modules/pve-node | n/a |

## Resources

| Name | Type |
|------|------|
| [cloudflare_dns_record.kubernetes](https://registry.terraform.io/providers/cloudflare/cloudflare/5.13.0/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.kubernetes_api](https://registry.terraform.io/providers/cloudflare/cloudflare/5.13.0/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.kubernetes_gateway_apex](https://registry.terraform.io/providers/cloudflare/cloudflare/5.13.0/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.kubernetes_gateway_wildcard](https://registry.terraform.io/providers/cloudflare/cloudflare/5.13.0/docs/resources/dns_record) | resource |
| [cloudflare_dns_record.pve_homelab](https://registry.terraform.io/providers/cloudflare/cloudflare/5.13.0/docs/resources/dns_record) | resource |
| [onepassword_item.grafana_admin_user](https://registry.terraform.io/providers/1Password/onepassword/2.2.0/docs/resources/item) | resource |
| [onepassword_item.pve_tailnet_key](https://registry.terraform.io/providers/1Password/onepassword/2.2.0/docs/resources/item) | resource |
| [proxmox_virtual_environment_metrics_server.opentelemetry_server](https://registry.terraform.io/providers/bpg/proxmox/0.93.0/docs/resources/virtual_environment_metrics_server) | resource |
| [proxmox_virtual_environment_storage_zfspool.slow](https://registry.terraform.io/providers/bpg/proxmox/0.93.0/docs/resources/virtual_environment_storage_zfspool) | resource |
| [proxmox_virtual_environment_vm.kubernetes](https://registry.terraform.io/providers/bpg/proxmox/0.93.0/docs/resources/virtual_environment_vm) | resource |
| [tailscale_tailnet_key.pve](https://registry.terraform.io/providers/tailscale/tailscale/0.24.0/docs/resources/tailnet_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudflare_account_id"></a> [cloudflare\_account\_id](#input\_cloudflare\_account\_id) | tflint-ignore: terraform\_unused\_declarations | `string` | n/a | yes |
| <a name="input_cloudflare_zone_id"></a> [cloudflare\_zone\_id](#input\_cloudflare\_zone\_id) | n/a | `string` | n/a | yes |
| <a name="input_op_service_account_token"></a> [op\_service\_account\_token](#input\_op\_service\_account\_token) | n/a | `string` | n/a | yes |
| <a name="input_op_vault"></a> [op\_vault](#input\_op\_vault) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
<!-- prettier-ignore-end -->
