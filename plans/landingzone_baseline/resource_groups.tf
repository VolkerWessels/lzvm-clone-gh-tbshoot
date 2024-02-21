# module "network" {
#     source = "../modules/network"
#     for_each = toset(var.stages)

#     subscripion_id = azuread_subscription.subscription[each.key].subscription_id
#     caf_prefix = var.caf_prefix
#     subscription_name = var.subscription_name
# }

resource "azurerm_resource_group" "baseline" {
  name     = "${var.caf_prefix}-rg-baseline"
  location = "westeurope"

  tags = local.tags
}

resource "azurerm_resource_group" "network_rg" {
  count = var.vnet_cidr != "none" ? 1 : 0

  name     = "${var.caf_prefix}-rg-network"
  location = "westeurope"

  tags = local.tags
}