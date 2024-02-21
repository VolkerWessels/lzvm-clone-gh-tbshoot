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

# Configure the Microsoft Azure Provider
provider "azuread" {
  alias         = "entra"
  client_id     = var.azuread_client_id_entra
  client_secret = var.azuread_client_secret_entra
}

provider "azuread" {
  alias         = "scl"
  client_id     = var.azurerm_client_id_scl
  client_secret = var.azurerm_client_secret_scl
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  alias                      = "scl"
  client_id                  = var.azurerm_client_id_scl
  client_secret              = var.azurerm_client_secret_scl
  skip_provider_registration = true
  features {}
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  alias         = "eslz"
  client_id     = var.azurerm_client_id_eslz
  client_secret = var.azurerm_client_secret_eslz
  features {}
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  alias         = "ipam"
  client_id     = var.azurerm_client_id_ipam
  client_secret = var.azurerm_client_secret_ipam
  features {}
}