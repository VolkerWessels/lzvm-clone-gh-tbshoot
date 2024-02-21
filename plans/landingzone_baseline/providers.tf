# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">3.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">3.0.0"
    }
  }
}

# created Dev Subscription
provider "azurerm" {
  features {}
  skip_provider_registration = true
}

provider "azurerm" {
  alias = "vhub"
  features {}
  skip_provider_registration = true
  subscription_id            = var.vhub_subscription_id # from output of lzvm
}