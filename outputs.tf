locals {
  app = length(azurerm_linux_function_app.app) > 0 ? azurerm_linux_function_app.app : azurerm_windows_function_app.app
}

output "azurerm_function_app" {
  description = "The Azure Function app resource."
  value       = local.app
}

output "identity" {
  description = "The managed identity of the app."
  value       = local.app.identity
}
