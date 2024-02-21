resource "azurerm_user_assigned_identity" "ama_managed_identity" {
  location            = azurerm_resource_group.baseline.location
  name                = "${var.caf_prefix}-msi-azure_monitor_agent"
  resource_group_name = azurerm_resource_group.baseline.name

  tags = local.tags

  depends_on = [ azurerm_resource_provider_registration.resource_provider ]
}