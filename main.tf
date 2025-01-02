locals {
  name                 = "${var.system_short_name}-${var.app_name}-${var.environment}"
  function_app_name    = "${local.name}-func"
  storage_account_name = var.storage_account.app_short_name != null ? "${var.system_short_name}${var.storage_account.app_short_name}${var.environment}st" : null

  existing_storage_account_name       = try(var.storage_account.existing_account.azurerm_storage_account.name, null)
  existing_storage_account_access_key = try(var.storage_account.existing_account.azurerm_storage_account.primary_access_key, null)
}

module "storageaccount" {
  source = "github.com/energimidt/terraform-azurerm-storageaccount.git?ref=258f25147f1d11e6178857de40a826dc7b674c1b"
  count  = var.storage_account.app_short_name != null ? 1 : 0

  environment              = var.environment
  system_name              = local.name
  override_name            = local.storage_account_name
  resource_group           = var.resource_group
  account_replication_type = "LRS"
  account_tier             = "Standard"
  account_kind             = "StorageV2"

  tags = var.tags
}

resource "azurerm_linux_function_app" "app" {
  count                         = var.service_plan.os_type == "Linux" ? 1 : 0
  name                          = local.function_app_name
  location                      = var.resource_group.location
  resource_group_name           = var.resource_group.name
  service_plan_id               = var.service_plan.id
  storage_account_name          = var.storage_account.existing_account != null ? local.existing_storage_account_name : local.storage_account_name
  storage_account_access_key    = var.storage_account.existing_account != null ? local.existing_storage_account_access_key : module.storageaccount[0].azurerm_storage_account.primary_access_key
  public_network_access_enabled = var.public_network_access_enabled

  https_only   = true
  app_settings = var.app_settings
  tags         = var.tags

  enabled = var.enabled != null ? var.enabled : true

  dynamic "identity" {
    for_each = var.identity[*]
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }
  site_config {
    health_check_path                 = var.health_check_path
    health_check_eviction_time_in_min = var.health_check_eviction_time_in_min
    application_stack {
      dotnet_version = var.runtime.dotnet_version
      java_version   = var.runtime.java_version
      node_version   = var.runtime.node_version
    }
    dynamic "cors" {
      for_each = var.cors[*]
      content {
        allowed_origins     = cors.value.allowed_origins
        support_credentials = cors.value.support_credentials
      }
    }
    dynamic "ip_restriction" {
      for_each = var.inbound_ip_filtering[*]
      content {
        ip_address = ip_restriction.value.ip_address
        name       = ip_restriction.value.name
        priority   = ip_restriction.value.priority
        action     = "Allow"
      }
    }
    always_on                              = var.always_on
    application_insights_connection_string = var.app_insights.connection_string
    application_insights_key               = var.app_insights.instrumentation_key
  }

}

resource "azurerm_windows_function_app" "app" {
  count                         = var.service_plan.os_type == "Windows" ? 1 : 0
  name                          = local.function_app_name
  location                      = var.resource_group.location
  resource_group_name           = var.resource_group.name
  service_plan_id               = var.service_plan.id
  storage_account_name          = var.storage_account.existing_account != null ? local.existing_storage_account_name : local.storage_account_name
  storage_account_access_key    = var.storage_account.existing_account != null ? local.existing_storage_account_access_key : module.storageaccount[0].azurerm_storage_account.primary_access_key
  public_network_access_enabled = var.public_network_access_enabled
  https_only                    = true
  app_settings                  = var.app_settings
  tags                          = var.tags

  dynamic "identity" {
    for_each = var.identity[*]
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }
  site_config {
    application_stack {
      dotnet_version = var.runtime.dotnet_version
      java_version   = var.runtime.java_version
      node_version   = var.runtime.node_version
    }
    dynamic "cors" {
      for_each = var.cors[*]
      content {
        allowed_origins     = cors.value.allowed_origins
        support_credentials = cors.value.support_credentials
      }
    }
    dynamic "ip_restriction" {
      for_each = var.inbound_ip_filtering[*]
      content {
        ip_address = ip_restriction.value.ip_address
        name       = ip_restriction.value.name
        priority   = ip_restriction.value.priority
        action     = "Allow"
      }
    }
    always_on                              = var.always_on
    application_insights_connection_string = var.app_insights.connection_string
    application_insights_key               = var.app_insights.instrumentation_key
  }
}
