resource "azurerm_windows_virtual_machine" "test" {
  name                = local.vm_name
  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location
  # Message="OS disk of Ephemeral VM with size greater than 32 GB is not allowed for VM size Standard_F2s_v2"
  size            = "Standard_DS3_v2"
  admin_username  = "adminuser"
  admin_password  = "P@$$w0rd1234!"
  priority        = "Spot"
  eviction_policy = "Delete"
  network_interface_ids = [
    azurerm_network_interface.test.id,
  ]

  os_disk {
    caching              = "ReadOnly"
    storage_account_type = "Standard_LRS"

    diff_disk_settings {
      option = "Local"
    }
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
