module "landingzone-management-groups" {
  source = "git@github.com:VolkerWessels/cloud-platform-mgmtgrp-module.git?ref=main"
  providers = {
    azurerm.eslz = azurerm.eslz
  }
  # Management group that will be created under the "Landingzones" management group
  # If parent_management_group_exists is set to true, the value for management_group_name will have to match the name of an existing management group
  # Naming conventions are: mg-${tenant}-landingzones / mg-${tenant}-lz-${management_group_name}-prd / mg-${tenant}-lz-${management_group_name}-non-prd
  parent_management_group_exists = var.parent_management_group_exists
  management_group_name          = var.management_group_name

  # Globals
  tenant_prefix = var.tenant_prefix
  mg_prefix     = var.mg_prefix

  # Credentials used by the vending machine
  # ESZL = Enterprise Scale Landingzones to create managementgroups
  azurerm_client_id_eslz     = var.azurerm_client_id_eslz
  azurerm_client_secret_eslz = var.azurerm_client_secret_eslz
}

module "landingzone-vending-machine" {
  source = "git@github.com:VolkerWessels/cloud-platform-lzvm-module.git?ref=main"
  providers = {
    azuread.entra = azuread.entra
    azurerm.scl   = azurerm.scl
    azurerm.eslz  = azurerm.eslz
    azurerm.ipam  = azurerm.ipam
    azuread.scl   = azuread.scl
  }
  for_each = toset(var.stages)
  stage    = each.value

  # Management groups under the "Landingzones" management group where the subscriptions will be associated with
  prd_management_group_name    = module.landingzone-management-groups.prd_management_group_id
  nonprd_management_group_name = module.landingzone-management-groups.non_prd_management_group_id

  # subscription details for the naming convention and tagging
  subscription_type = var.subscription_type
  subscription_name = var.subscription_name
  subscription_tags = var.subscription_tags

  # VNET sizes for each stage, these are optional, if you do not define them, no network resources will be created
  dev_vnet_size = var.dev_vnet_size
  tst_vnet_size = var.tst_vnet_size
  acc_vnet_size = var.acc_vnet_size
  prd_vnet_size = var.prd_vnet_size

  # IPAM
  ipam_api_guid = var.ipam_api_guid
  ipam_app_name = var.ipam_app_name
  ipam_space    = var.ipam_space
  ipam_block    = var.ipam_block

  # list of user_principals to add to the contributer group and/or readers group (Optional)
  contributors = var.contributors
  readers      = var.readers

  # Globals
  tenant_domain      = var.tenant_domain
  tenant_prefix      = var.tenant_prefix
  mg_prefix          = var.mg_prefix
  billing_account    = var.billing_account
  enrollment_account = var.enrollment_account
  caf_prefix         = var.caf_prefix

  # Credentials used by the vending machine
  # SCL = Subscription Creation Landingzones to create subscriptions and resources
  # ESZL = Enterprise Scale Landingzones to create managementgroups
  # IPAM = IP Address Management to generate a vnet address spaces
  # ENTRA = Entra to create AAD objects for the landingzone
  azurerm_client_id_scl       = var.azurerm_client_id_scl
  azurerm_client_secret_scl   = var.azurerm_client_secret_scl
  azurerm_client_id_eslz      = var.azurerm_client_id_eslz
  azurerm_client_secret_eslz  = var.azurerm_client_secret_eslz
  azuread_client_id_entra     = var.azuread_client_id_entra
  azuread_client_secret_entra = var.azuread_client_secret_entra
  azurerm_client_id_ipam      = var.azurerm_client_id_ipam
  azurerm_client_secret_ipam  = var.azurerm_client_secret_ipam

  # GitHub OIDC configuration of SP (Optional)
  github_oidc = var.github_oidc # see README.md for example, default is an empty map
  

  depends_on = [
    module.landingzone-management-groups
  ]
}
