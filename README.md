# terraform-azurerm-functionapp

Terraform module for managing an Azure Function app.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.25.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.25.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_storageaccount_functionapp"></a> [storageaccount\_functionapp](#module\_storageaccount\_functionapp) | github.com/energimidt/terraform-azurerm-storageaccount.git | v0.0.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_function_app.app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app) | resource |
| [azurerm_windows_function_app.app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_function_app) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_insights"></a> [app\_insights](#input\_app\_insights) | (Optional) Application insights configuration for the function app. | <pre>object({<br>    connection_string = string<br>    key               = string<br>  })</pre> | `null` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | (Required) Name of this resource within the system it belongs to (see naming convention guidelines).<br>  Will be part of the final name of the deployed resource. | `string` | n/a | yes |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | (Optional) A mapping of app settings that should be set when creating the function app. | `map(string)` | `{}` | no |
| <a name="input_cors"></a> [cors](#input\_cors) | (Optional) CORS settings for the function app. | <pre>object({<br>    allowed_origins     = string<br>    support_credentials = bool<br>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) The name of the environment. | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) Identity configuration for the function app, i.e. if the identity is system assigned and/or user assigned. | <pre>object({<br>    type         = string<br>    identity_ids = list(string)<br>  })</pre> | `null` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | (Required) The resource group this function app should be created in. | `any` | `null` | no |
| <a name="input_service_plan"></a> [service\_plan](#input\_service\_plan) | (Required) The service plan where this function app should run. | `any` | `null` | no |
| <a name="input_storage_account"></a> [storage\_account](#input\_storage\_account) | (Required) The storage account associated with this function app OR a short name to use when a storage account should be created.<br>  The storage account name will be a concatenation of system\_short\_name, app\_short\_name, environment and "st".<br>  The total length of the storage account name cannot exceed 24 characters and can only contain numbers and  lowercase letters. | <pre>object({<br>    name           = optional(string)<br>    app_short_name = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_system_short_name"></a> [system\_short\_name](#input\_system\_short\_name) | (Required) Short abbreviation (to-three letters) of the system name that this resource belongs to (see naming convention guidelines).<br>  Will be part of the final name of the deployed resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_function_app"></a> [azurerm\_function\_app](#output\_azurerm\_function\_app) | The Azure Function app resource. |
<!-- END_TF_DOCS -->