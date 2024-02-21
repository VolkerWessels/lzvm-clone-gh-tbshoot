terraform {
  backend "azurerm" {
    # storage_account_name = from -backend-config, level4 storage account
    # container_name       = from -backend-config, tfstate container in the level4 storage account
    # key                  = from -backend-config, tfstate file name
    # resource_group_name  = from -backend-config, level4 resource group where the storage account is located
    # subscription_id      = from -backend-config, launchpad subscription id (which has the storage account)
  }
}