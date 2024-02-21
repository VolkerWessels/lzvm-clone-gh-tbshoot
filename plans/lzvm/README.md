<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >3.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >3.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_landingzone-management-groups"></a> [landingzone-management-groups](#module\_landingzone-management-groups) | git@github.com:VolkerWessels/cloud-platform-mgmtgrp-module.git | main |
| <a name="module_landingzone-vending-machine"></a> [landingzone-vending-machine](#module\_landingzone-vending-machine) | git@github.com:VolkerWessels/cloud-platform-lzvm-module.git | main |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acc_vnet_size"></a> [acc\_vnet\_size](#input\_acc\_vnet\_size) | n/a | `any` | `null` | no |
| <a name="input_azuread_client_id_entra"></a> [azuread\_client\_id\_entra](#input\_azuread\_client\_id\_entra) | n/a | `any` | n/a | yes |
| <a name="input_azuread_client_secret_entra"></a> [azuread\_client\_secret\_entra](#input\_azuread\_client\_secret\_entra) | n/a | `any` | n/a | yes |
| <a name="input_azurerm_client_id_eslz"></a> [azurerm\_client\_id\_eslz](#input\_azurerm\_client\_id\_eslz) | n/a | `any` | n/a | yes |
| <a name="input_azurerm_client_id_ipam"></a> [azurerm\_client\_id\_ipam](#input\_azurerm\_client\_id\_ipam) | n/a | `any` | n/a | yes |
| <a name="input_azurerm_client_id_scl"></a> [azurerm\_client\_id\_scl](#input\_azurerm\_client\_id\_scl) | n/a | `any` | n/a | yes |
| <a name="input_azurerm_client_secret_eslz"></a> [azurerm\_client\_secret\_eslz](#input\_azurerm\_client\_secret\_eslz) | n/a | `any` | n/a | yes |
| <a name="input_azurerm_client_secret_ipam"></a> [azurerm\_client\_secret\_ipam](#input\_azurerm\_client\_secret\_ipam) | n/a | `any` | n/a | yes |
| <a name="input_azurerm_client_secret_scl"></a> [azurerm\_client\_secret\_scl](#input\_azurerm\_client\_secret\_scl) | n/a | `any` | n/a | yes |
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | n/a | `any` | n/a | yes |
| <a name="input_caf_prefix"></a> [caf\_prefix](#input\_caf\_prefix) | n/a | `any` | n/a | yes |
| <a name="input_contributors"></a> [contributors](#input\_contributors) | n/a | `any` | `null` | no |
| <a name="input_dev_vnet_size"></a> [dev\_vnet\_size](#input\_dev\_vnet\_size) | n/a | `any` | `null` | no |
| <a name="input_enrollment_account"></a> [enrollment\_account](#input\_enrollment\_account) | n/a | `any` | n/a | yes |
| <a name="input_ipam_api_guid"></a> [ipam\_api\_guid](#input\_ipam\_api\_guid) | GUID for the Exposed API on the Engine App Registration. | `any` | n/a | yes |
| <a name="input_ipam_app_name"></a> [ipam\_app\_name](#input\_ipam\_app\_name) | Name of the App Service or Function running the IPAM Engine. | `any` | n/a | yes |
| <a name="input_ipam_block"></a> [ipam\_block](#input\_ipam\_block) | Block in which to create a new CIDR reservation. | `any` | n/a | yes |
| <a name="input_ipam_space"></a> [ipam\_space](#input\_ipam\_space) | Space in which to create a new CIDR reservation. | `any` | n/a | yes |
| <a name="input_management_group_name"></a> [management\_group\_name](#input\_management\_group\_name) | n/a | `any` | n/a | yes |
| <a name="input_mg_prefix"></a> [mg\_prefix](#input\_mg\_prefix) | n/a | `any` | n/a | yes |
| <a name="input_parent_management_group_exists"></a> [parent\_management\_group\_exists](#input\_parent\_management\_group\_exists) | n/a | `bool` | `false` | no |
| <a name="input_password_policy"></a> [password\_policy](#input\_password\_policy) | Default password policy applies when not set in tfvars. | `map` | <pre>{<br>  "expire_in_days": 180,<br>  "length": 250,<br>  "number": true,<br>  "rotation": {<br>    "months": 1<br>  },<br>  "special": false,<br>  "upper": true<br>}</pre> | no |
| <a name="input_prd_vnet_size"></a> [prd\_vnet\_size](#input\_prd\_vnet\_size) | n/a | `any` | `null` | no |
| <a name="input_readers"></a> [readers](#input\_readers) | n/a | `any` | `null` | no |
| <a name="input_stages"></a> [stages](#input\_stages) | n/a | `list(string)` | n/a | yes |
| <a name="input_subscription_name"></a> [subscription\_name](#input\_subscription\_name) | n/a | `any` | n/a | yes |
| <a name="input_subscription_tags"></a> [subscription\_tags](#input\_subscription\_tags) | n/a | `any` | n/a | yes |
| <a name="input_subscription_type"></a> [subscription\_type](#input\_subscription\_type) | n/a | `string` | n/a | yes |
| <a name="input_tenant_domain"></a> [tenant\_domain](#input\_tenant\_domain) | n/a | `any` | n/a | yes |
| <a name="input_tenant_prefix"></a> [tenant\_prefix](#input\_tenant\_prefix) | n/a | `any` | n/a | yes |
| <a name="input_tst_vnet_size"></a> [tst\_vnet\_size](#input\_tst\_vnet\_size) | n/a | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lzvm"></a> [lzvm](#output\_lzvm) | n/a |
| <a name="output_mgmtgrp"></a> [mgmtgrp](#output\_mgmtgrp) | n/a |
<!-- END_TF_DOCS -->