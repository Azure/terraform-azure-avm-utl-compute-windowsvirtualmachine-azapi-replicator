resource "azurerm_windows_virtual_machine" "test" {
  name                = local.vm_name
  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.test.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  plan {
    publisher = "plesk"
    product   = "plesk-onyx-windows"
    name      = "plsk-win-hst-azr-m"
  }

  source_image_reference {
    publisher = "plesk"
    offer     = "plesk-onyx-windows"
    sku       = "plsk-win-hst-azr-m"
    version   = "latest"
  }

  depends_on = [azurerm_marketplace_agreement.test]
}
