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
    name           = optional(string)
    app_short_name = optional(string)
  })
  default = {}
  validation {
    condition     = var.storage_account.name != null || (var.storage_account.name == null && var.storage_account.app_short_name != null)
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
