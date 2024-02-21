variable "caf_prefix" {
  type = string
}

variable "tenant_prefix" {
}

variable "dns_servers" {
  type = list(string)
}

variable "subscription_name" {
  type = string
}

# from environment variable (IPAM Reservation)
variable "vnet_cidr" {
  type    = string
  default = "null"

}

# from environment variable (IPAM Reservation)
variable "ipam_tag" {
  default = null
}

variable "subscription_tags" {
  type = map(string)

}

variable "baseline_tags" {
  type = map(string)
  default = {
    "baseline" = "no baseline tags defined"
  }

}

# If there are new resources added to the baseline, add the specific provider here
variable "resource_providers" {
  type = list(string)
  default = [
    "Microsoft.Compute",
    "Microsoft.Network",
    "Microsoft.Storage",
    "Microsoft.KeyVault",
    "Microsoft.ManagedIdentity"
  ]
  
}

variable "stage" {}

# variable "vnet_exists" {
#   type    = bool
#   default = false
# }

# Not used, but declared because the tfvars is also used in the lzvm module
variable "stages" {}
variable "dev_vnet_size" { default = "none" }
variable "tst_vnet_size" { default = "none" }
variable "acc_vnet_size" { default = "none" }
variable "prd_vnet_size" { default = "none" }
variable "management_group_name" {}
variable "tenant_domain" {}
variable "contributors" {
  default = []
  type    = list(string)
}
variable "parent_management_group_exists" {}
variable "subscription_type" {}
variable "ipam_block" {}
variable "mg_prefix" {}
variable "ipam_app_name" {}
variable "ipam_api_guid" {}
variable "ipam_space" {}
variable "readers" {
  default = []
  type    = list(string)
}
variable "enrollment_account" {}
variable "billing_account" {}
variable "vhub_subscription_id" {}

variable "github_oidc" {
  default = {}
}

variable "subnets" {
  type = list(object({
    name            = string
    address_prefix  = string
    delegation      = optional(object({
      name              = string
      service_delegation = object({
        service_name = string
        actions     = list(string)
      })
    }))
    }))
  default = []
  }