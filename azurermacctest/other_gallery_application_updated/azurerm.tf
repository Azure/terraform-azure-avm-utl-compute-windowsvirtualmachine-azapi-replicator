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

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  gallery_application {
    version_id = azurerm_gallery_application_version.test.id
    order      = 1
  }

  gallery_application {
    version_id                                  = azurerm_gallery_application_version.test2.id
    automatic_upgrade_enabled                   = true
    order                                       = 2
    configuration_blob_uri                      = azurerm_storage_blob.test2.id
    tag                                         = "app2"
    treat_failure_as_deployment_failure_enabled = true
  }
}
