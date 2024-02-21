locals {
  tags = merge(var.subscription_tags, var.baseline_tags)
}

data "azurerm_virtual_hub" "vhub" {
  provider = azurerm.vhub

  name                = "${var.caf_prefix}-vhub-we"
  resource_group_name = "${var.caf_prefix}-rg-global_wan"
}

data "azurerm_virtual_hub_route_table" "cloudnet" {
  provider = azurerm.vhub

  name                = "cloudnet"
  resource_group_name = "${var.caf_prefix}-rg-global_wan"
  virtual_hub_name    = "${var.caf_prefix}-vhub-we"
}

resource "azurerm_virtual_network" "vnet" {
  # check if the cidr is filled in, if not, don't create the vnet
  count = var.vnet_cidr != "none" ? 1 : 0
  
  name                = "${var.caf_prefix}-vnet-${var.subscription_name}"
  resource_group_name = azurerm_resource_group.network_rg[0].name
  location            = "westeurope"
  address_space       = [var.vnet_cidr]
  dns_servers         = var.dns_servers

  tags = merge(local.tags, {
    "X-IPAM-RES-ID" = var.ipam_tag
  })

  # Ignore changes to the IPAM reservation tag, this should only be set once during initial creation of the vnet
  lifecycle {
    ignore_changes = [
      tags["X-IPAM-RES-ID"],
      address_space
    ]
  }

  depends_on = [ azurerm_resource_provider_registration.resource_provider ]
}

resource "azurerm_virtual_hub_connection" "vnet_to_hub" {
  count    = var.vnet_cidr != "none" ? 1 : 0
  provider = azurerm.vhub

  name                      = "vnet_${var.subscription_name}_${var.stage}_TO_vhub_we"
  virtual_hub_id            = data.azurerm_virtual_hub.vhub.id
  remote_virtual_network_id = azurerm_virtual_network.vnet[0].id
  internet_security_enabled = true
  routing {
    associated_route_table_id = data.azurerm_virtual_hub_route_table.cloudnet.id
    propagated_route_table {
      route_table_ids = ["/subscriptions/${var.vhub_subscription_id}/resourceGroups/${var.caf_prefix}-rg-global_wan/providers/Microsoft.Network/virtualHubs/${var.caf_prefix}-vhub-we/hubRouteTables/noneRouteTable"]
      labels          = ["none"]
    }
  }

  depends_on = [ azurerm_resource_provider_registration.resource_provider ]
}

resource "azurerm_subnet" "subnets" {
  for_each = { for s in var.subnets : s.name => s }

  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.network_rg[0].name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value.address_prefix]

  dynamic "delegation" {
    for_each = try(each.value.delegation, null) == null ? [] : [1]

    content {
      name = each.value.delegation.name

      service_delegation {
        name    = each.value.delegation.service_delegation.service_name
        actions = each.value.delegation.service_delegation.actions
      }
    }
  }
}