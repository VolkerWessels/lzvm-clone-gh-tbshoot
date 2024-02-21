resource "azurerm_resource_provider_registration" "resource_provider" {
    for_each = toset(var.resource_providers)

    name = each.value
}