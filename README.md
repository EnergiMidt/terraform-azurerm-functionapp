# terraform-azurerm-functionapp

Terraform module for managing an Azure Function app.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.14.0, < 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.14.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_storageaccount"></a> [storageaccount](#module\_storageaccount) | github.com/energimidt/terraform-azurerm-storageaccount.git | 258f25147f1d11e6178857de40a826dc7b674c1b |

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_function_app.app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app) | resource |
| [azurerm_windows_function_app.app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_function_app) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_always_on"></a> [always\_on](#input\_always\_on) | (Optional) Whether or not this function app continue running when idle. Defaults to false. | `bool` | `false` | no |
| <a name="input_app_insights"></a> [app\_insights](#input\_app\_insights) | (Optional) Application insights configuration for the function app. | <pre>object({<br/>    connection_string   = string<br/>    instrumentation_key = string<br/>  })</pre> | `null` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | (Required) Name of this resource within the system it belongs to (see naming convention guidelines).<br/>  Will be part of the final name of the deployed resource. | `string` | n/a | yes |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | (Optional) A mapping of app settings that should be set when creating the function app. | `map(string)` | `{}` | no |
| <a name="input_cors"></a> [cors](#input\_cors) | (Optional) CORS settings for the function app. | <pre>object({<br/>    allowed_origins     = string<br/>    support_credentials = bool<br/>  })</pre> | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) Utilized to disable the function app. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) The name of the environment. | `string` | n/a | yes |
| <a name="input_health_check_eviction_time_in_min"></a> [health\_check\_eviction\_time\_in\_min](#input\_health\_check\_eviction\_time\_in\_min) | (Optional) The amount of time in minutes that a node can be unhealthy before being removed from the load balancer.<br/>Possible values are between `2` and `10`. Only valid in conjunction with `health_check_path`. | `number` | `10` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | (Optional) The path to be checked for this function app health.<br/>Relative path of the health check probe. A valid path starts with "/"." | `string` | `"/health"` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) Identity configuration for the function app, i.e. if the identity is system assigned and/or user assigned. | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | `null` | no |
| <a name="input_inbound_ip_filtering"></a> [inbound\_ip\_filtering](#input\_inbound\_ip\_filtering) | (Optional) A list of CIDR notated addresses that should be allowed to access the function. | <pre>list(object({<br/>    name       = string<br/>    ip_address = string<br/>    priority   = number<br/>  }))</pre> | `[]` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Should public network access be enabled for the Function App. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | (Required) The resource group this function app should be created in. | `any` | n/a | yes |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | The application runtime versions to use. | <pre>object({<br/>    dotnet_version = optional(string)<br/>    java_version   = optional(string)<br/>    node_version   = optional(string)<br/>  })</pre> | n/a | yes |
| <a name="input_service_plan"></a> [service\_plan](#input\_service\_plan) | (Required) The service plan where this function app should run. | `any` | n/a | yes |
| <a name="input_storage_account"></a> [storage\_account](#input\_storage\_account) | (Required) The storage account associated with this function app OR a short name to use when a storage account should be created.<br/>  The storage account name will be a concatenation of system\_short\_name, app\_short\_name, environment and "st".<br/>  The total length of the storage account name cannot exceed 24 characters and can only contain numbers and  lowercase letters. | <pre>object({<br/>    existing_account = optional(any)<br/>    app_short_name   = optional(string)<br/>  })</pre> | <pre>{<br/>  "app_short_name": null,<br/>  "existing_account": null<br/>}</pre> | no |
| <a name="input_system_short_name"></a> [system\_short\_name](#input\_system\_short\_name) | (Required) Short abbreviation (to-three letters) of the system name that this resource belongs to (see naming convention guidelines).<br/>  Will be part of the final name of the deployed resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_function_app"></a> [azurerm\_function\_app](#output\_azurerm\_function\_app) | The Azure Function app resource. |
| <a name="output_identity"></a> [identity](#output\_identity) | The managed identity of the app. |
<!-- END_TF_DOCS -->