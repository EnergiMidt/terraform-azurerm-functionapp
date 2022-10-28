locals {
  tags = {
    "MaintainerName"  = "Lars Martin S. Pedersen"
    "MaintainerEmail" = "lmp@computas.com"
    "CreatedBy"       = "Terraform"
  }
}

module "resource_group" {
  source = "github.com/energimidt/terraform-azurerm-resourcegroup.git?ref=v0.0.1"

  location    = "norwayeast"
  environment = "test"
  name        = "tf-functionapp"
  tags        = local.tags
}

module "service_plan" {
  source = "github.com/energimidt/terraform-azurerm-serviceplan.git?ref=v0.0.1"

  resource_group = module.resource_group
  environment    = "test"
  system_name    = "tf-functionapp"
  os_type        = "Windows"
  sku_name       = "P1v3"
  tags           = local.tags
}

module "functionapp" {
  source = "../"

  resource_group    = module.resource_group
  service_plan      = module.service_plan
  environment       = "test"
  system_short_name = "tf"
  app_name          = "functionapp"
  storage_account = {
    app_short_name = "functionapp"
  }
  tags = local.tags
}
