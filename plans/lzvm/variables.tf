variable "tenant_prefix" {

}


variable "mg_prefix" {

}

variable "billing_account" {

}

variable "enrollment_account" {

}

variable "management_group_name" {

}

variable "subscription_type" {
  type = string

  validation {
    condition     = contains(["shared", "oa"], var.subscription_type)
    error_message = "Valid values for the subscription type variable are shared, oa"
  }
}

variable "subscription_name" {

}

variable "subscription_tags" {

}

variable "stages" {
  type = list(string)

  validation {
    condition     = can([for s in var.stages : regex("^(dev|tst|acc|prd)$", s)])
    error_message = "Allowed values are dev, tst, acc, and prd."
  }
}
variable "stage" {}

variable "azurerm_client_id_scl" {}
variable "azurerm_client_secret_scl" {}
variable "azurerm_client_id_eslz" {}
variable "azurerm_client_secret_eslz" {}
variable "azuread_client_id_entra" {}
variable "azuread_client_secret_entra" {}
variable "azurerm_client_id_ipam" {}
variable "azurerm_client_secret_ipam" {}
variable "caf_prefix" {}
variable "tenant_domain" {}

variable "password_policy" {
  description = "Default password policy applies when not set in tfvars."
  default = {
    # Length of the password
    length  = 250
    special = false
    upper   = true
    number  = true

    # Define the number of days the password is valid. It must be more than the rotation frequency
    expire_in_days = 180
    rotation = {
      #
      # Set how often the password must be rotated. When passed the renewal time, running the terraform plan / apply will change to a new password
      # Only set one of the value
      #

      # mins   = 10     # only recommended for CI and demo
      # days   = 7
      months = 1
    }
  }
}

variable "contributors" {
  default = []
  type    = list(string)
}

variable "readers" {
  default = []
  type    = list(string)
}

variable "dev_vnet_size" {
  default = "none"
}
variable "tst_vnet_size" {
  default = "none"
}
variable "acc_vnet_size" {
  default = "none"
}
variable "prd_vnet_size" {
  default = "none"
}

variable "ipam_space" {
  description = "Space in which to create a new CIDR reservation."
}

variable "ipam_block" {
  description = "Block in which to create a new CIDR reservation."
}

variable "ipam_api_guid" {
  description = "GUID for the Exposed API on the Engine App Registration."
}

variable "ipam_app_name" {
  description = "Name of the App Service or Function running the IPAM Engine."
}

variable "parent_management_group_exists" {
  type    = bool
  default = false
}

variable "dns_servers" {
  type = list(string)
}

# used only in landingzone_baseline
variable "baseline_tags" {
  type = map(string)
  default = {
    "baseline" = "no baseline tags defined"
  }

}
# OIDC setup in Github
variable "github_oidc" {
  description = "Map of repositories and branches to create OIDC credentials for"
  type = map(object({
    branches    = optional(list(string))
    environments = optional(list(string))
  }))
  default = {}
}