output "primary_location" {
    value = azurerm_resource_group.myrg.location
    description = "Primary Location"
}

output "vnet_address_space" {
    value = azurerm_virtual_network.hub_vnet.address_space
    description = "VNET Address Space"
}
