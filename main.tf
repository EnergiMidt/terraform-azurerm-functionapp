locals {
  name                 = "${var.system_short_name}-${var.app_name}-${var.environment}"
  function_app_name    = "${local.name}-func"
  storage_account_name = var.storage_account.name != null ? var.storage_account.name : "${var.system_short_name}${var.storage_account.app_short_name}${var.environment}st"
}

module "storageaccount_functionapp" {
  source = "github.com/energimidt/terraform-azurerm-storageaccount.git?ref=v0.0.1"
  count  = var.storage_account.name == null ? 0 : 1

  environment              = var.environment
  system_name              = local.name
  override_name            = local.storage_account_name
  resource_group           = var.resource_group
  account_replication_type = "LRS"
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  network_rules = [
    {
      default_action = "Deny"
      bypass         = ["AzureServices"]
    }
  ]
}

resource "azurerm_linux_function_app" "app" {
  count                = var.service_plan.os_type == "Linux" ? 1 : 0
  name                 = local.function_app_name
  location             = var.resource_group.location
  resource_group_name  = var.resource_group.name
  service_plan_id      = var.service_plan.id
  storage_account_name = local.storage_account_name
  https_only           = true
  app_settings         = var.app_settings
  tags                 = var.tags
  dynamic "identity" {
    for_each = var.identity[*]
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }
  site_config {
    dynamic "cors" {
      for_each = var.cors[*]
      content {
        allowed_origins     = cors.value.allowed_origins
        support_credentials = cors.value.support_credentials
      }
    }
    dynamic "ip_restriction" {
      for_each = var.inbound_ip_filtering
      content {
        ip_address = ip_restriction.value
        action     = "ALLOW"
      }
    }
    application_insights_connection_string = var.app_insights.connection_string
    application_insights_key               = var.app_insights.instrumentation_key
  }
}

resource "azurerm_windows_function_app" "app" {
  count                = var.service_plan.os_type == "Windows" ? 1 : 0
  name                 = local.function_app_name
  location             = var.resource_group.location
  resource_group_name  = var.resource_group.name
  service_plan_id      = var.service_plan.id
  storage_account_name = local.storage_account_name
  https_only           = true
  app_settings         = var.app_settings
  tags                 = var.tags
  dynamic "identity" {
    for_each = var.identity[*]
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }
  site_config {
    dynamic "cors" {
      for_each = var.cors[*]
      content {
        allowed_origins     = cors.value.allowed_origins
        support_credentials = cors.value.support_credentials
      }
    }
    dynamic "ip_restriction" {
      for_each = var.inbound_ip_filtering
      content {
        ip_address = ip_restriction.value
        action     = "ALLOW"
      }
    }
    application_insights_connection_string = var.app_insights.connection_string
    application_insights_key               = var.app_insights.instrumentation_key
  }
}
