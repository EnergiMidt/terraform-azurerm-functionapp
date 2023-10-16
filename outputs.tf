locals {
  app = length(azurerm_linux_function_app.app) > 0 ? azurerm_linux_function_app.app : azurerm_windows_function_app.app
  storage_account = length(module.storageaccount) > 0 ? module.storageaccount[0].azurerm_storage_account : null
}

output "azurerm_function_app" {
  description = "The Azure Function app resource."
  value       = element(local.app, 0)
}

output "azurerm_storage_account" {
  description = "The Azure Storage Account used by the Azure Function app resource."
  value       = local.storage_account
}

output "identity" {
  description = "The managed identity of the app."
  value       = element(local.app, 0).identity
}
