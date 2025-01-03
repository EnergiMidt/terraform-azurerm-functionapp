variable "system_short_name" {
  description = <<EOT
  (Required) Short abbreviation (to-three letters) of the system name that this resource belongs to (see naming convention guidelines).
  Will be part of the final name of the deployed resource.
  EOT
  type        = string
}

variable "app_name" {
  description = <<EOT
  (Required) Name of this resource within the system it belongs to (see naming convention guidelines).
  Will be part of the final name of the deployed resource.
  EOT
  type        = string
}

variable "environment" {
  description = "(Required) The name of the environment."
  type        = string
  validation {
    condition = contains([
      "dev",
      "test",
      "prod",
    ], var.environment)
    error_message = "Possible values are dev, test, and prod."
  }
}

variable "resource_group" {
  description = "(Required) The resource group this function app should be created in."
  type        = any
  nullable    = false
}

variable "service_plan" {
  description = "(Required) The service plan where this function app should run."
  type        = any
  nullable    = false
}

variable "storage_account" {
  description = <<EOT
  (Required) The storage account associated with this function app OR a short name to use when a storage account should be created.
  The storage account name will be a concatenation of system_short_name, app_short_name, environment and "st".
  The total length of the storage account name cannot exceed 24 characters and can only contain numbers and  lowercase letters.
  EOT
  type = object({
    existing_account = optional(any)
    app_short_name   = optional(string)
  })
  default = {
    existing_account = null
    app_short_name   = null
  }
  validation {
    condition     = var.storage_account.existing_account != null || (var.storage_account.existing_account == null && var.storage_account.app_short_name != null)
    error_message = "Name of an existing storage account or a short name for the app must be provided."
  }
}

variable "inbound_ip_filtering" {
  description = "(Optional) A list of CIDR notated addresses that should be allowed to access the function."
  type = list(object({
    name       = string
    ip_address = string
    priority   = number
  }))
  default = []
}

variable "cors" {
  description = "(Optional) CORS settings for the function app."
  type = object({
    allowed_origins     = string
    support_credentials = bool
  })
  default = null
}

variable "identity" {
  description = "(Optional) Identity configuration for the function app, i.e. if the identity is system assigned and/or user assigned."
  type = object({
    type         = string
    identity_ids = list(string)
  })
  default = null
}

variable "app_insights" {
  description = "(Optional) Application insights configuration for the function app."
  type = object({
    connection_string   = string
    instrumentation_key = string
  })
  default   = null
  sensitive = true
}

variable "app_settings" {
  description = "(Optional) A mapping of app settings that should be set when creating the function app."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "runtime" {
  description = "The application runtime versions to use."
  type = object({
    dotnet_version = optional(string)
    java_version   = optional(string)
    node_version   = optional(string)
  })
  validation {
    condition     = var.runtime.dotnet_version != null || var.runtime.java_version != null || var.runtime.node_version != null
    error_message = "One and only one of runtime versions must be set."
  }
}

variable "always_on" {
  description = "(Optional) Whether or not this function app continue running when idle. Defaults to false."
  type        = bool
  default     = false
}

variable "health_check_path" {
  description = <<EOT
(Optional) The path to be checked for this function app health.
Relative path of the health check probe. A valid path starts with "/"."
EOT
  type        = string
  default     = "/health"
}

variable "health_check_eviction_time_in_min" {
  description = <<EOT
(Optional) The amount of time in minutes that a node can be unhealthy before being removed from the load balancer.
Possible values are between `2` and `10`. Only valid in conjunction with `health_check_path`.
EOT
  type        = number
  default     = 10
}

variable "public_network_access_enabled" {
  description = "(Optional) Should public network access be enabled for the Function App. Defaults to `true`."
  type        = bool
  default     = true
}

variable "vnet_route_all_enabled" {
  description = " (Optional) Should all outbound traffic have NAT Gateways, Network Security Groups and User Defined Routes applied? Defaults to `false`."
  type        = bool
  default     = false
}

variable "enabled" {
  description = "(Optional) Utilized to disable the function app. Defaults to `true`."
  type        = bool
  default     = true
}
