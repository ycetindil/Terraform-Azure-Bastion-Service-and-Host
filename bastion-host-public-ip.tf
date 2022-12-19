resource "azurerm_public_ip" "bastion_host_publicip" {
  name                = "${local.resource_name_prefix}-bastion-host-publicip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku = "Standard"
}