<!-- prettier-ignore-start -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.12 |
| <a name="requirement_onepassword"></a> [onepassword](#requirement\_onepassword) | 2.2.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 3.0.2-rc05 |
| <a name="requirement_tailscale"></a> [tailscale](#requirement\_tailscale) | 0.24.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_onepassword"></a> [onepassword](#provider\_onepassword) | 2.2.0 |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 3.0.2-rc05 |
| <a name="provider_tailscale"></a> [tailscale](#provider\_tailscale) | 0.24.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [onepassword_item.pve_tailnet_key](https://registry.terraform.io/providers/1Password/onepassword/2.2.0/docs/resources/item) | resource |
| [proxmox_vm_qemu.jumphost](https://registry.terraform.io/providers/Telmate/proxmox/3.0.2-rc05/docs/resources/vm_qemu) | resource |
| [tailscale_tailnet_key.pve](https://registry.terraform.io/providers/tailscale/tailscale/0.24.0/docs/resources/tailnet_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_op_service_account_token"></a> [op\_service\_account\_token](#input\_op\_service\_account\_token) | n/a | `string` | n/a | yes |
| <a name="input_op_vault"></a> [op\_vault](#input\_op\_vault) | tflint-ignore: terraform\_unused\_declarations | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
<!-- prettier-ignore-end -->
