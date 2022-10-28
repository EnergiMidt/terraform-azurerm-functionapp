output "name" {
  value = module.functionapp.azurerm_function_app.name
}

output "storage_account_name" {
  value = module.functionapp.azurerm_function_app.storage_account_name
}
