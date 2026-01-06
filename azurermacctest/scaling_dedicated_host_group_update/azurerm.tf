resource "azurerm_windows_virtual_machine" "test" {
  name                    = local.vm_name
  resource_group_name     = azurerm_resource_group.test.name
  location                = azurerm_resource_group.test.location
  size                    = "Standard_D2s_v3" # NOTE: SKU's are limited by the Dedicated Host
  admin_username          = "adminuser"
  admin_password          = "P@$$w0rd1234!"
  dedicated_host_group_id = azurerm_dedicated_host_group.second.id
  network_interface_ids = [
    azurerm_network_interface.test.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  depends_on = [
    azurerm_dedicated_host.second
  ]
}
