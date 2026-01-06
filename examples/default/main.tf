resource "random_string" "name" {
  length  = 6
  special = false
  upper   = false
}

resource "random_integer" "number" {
  max = 999999
  min = 100000
}

locals {
  vm_name = "rgvm${random_string.name.result}"
}

resource "azurerm_resource_group" "test" {
  location = "eastus"
  name     = "rgvm-${random_integer.number.result}"
}

resource "azurerm_virtual_network" "test" {
  location            = azurerm_resource_group.test.location
  name                = "nw-${random_integer.number.result}"
  resource_group_name = azurerm_resource_group.test.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "test" {
  address_prefixes     = ["10.0.2.0/24"]
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
}

resource "azurerm_network_interface" "test" {
  location            = azurerm_resource_group.test.location
  name                = "vmnic-${random_integer.number.result}"
  resource_group_name = azurerm_resource_group.test.name

  ip_configuration {
    name                          = "internal"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.test.id
  }
}

ephemeral random_password "pass" {
  length      = 20
  lower       = true
  min_lower   = 1
  min_numeric = 1
  min_special = 1
  min_upper   = 1
  numeric     = true
  special     = true
  upper       = true
}

module "replicator" {
  source = "../.."

  location = azurerm_resource_group.test.location
  name     = local.vm_name
  network_interface_ids = [
    azurerm_network_interface.test.id,
  ]
  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  resource_group_id      = azurerm_resource_group.test.id
  resource_group_name    = azurerm_resource_group.test.name
  size                   = "Standard_F2"
  admin_password         = ephemeral.random_password.pass.result
  admin_password_version = 1
  admin_username         = "adminuser"
  source_image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

resource "azapi_resource" "this" {
  location                         = module.replicator.azapi_header.location
  name                             = module.replicator.azapi_header.name
  parent_id                        = module.replicator.azapi_header.parent_id
  type                             = module.replicator.azapi_header.type
  body                             = module.replicator.body
  ignore_null_property             = module.replicator.azapi_header.ignore_null_property
  locks                            = module.replicator.locks
  replace_triggers_external_values = module.replicator.replace_triggers_external_values
  retry                            = module.replicator.retry
  sensitive_body                   = module.replicator.sensitive_body
  sensitive_body_version           = module.replicator.sensitive_body_version
  tags                             = module.replicator.azapi_header.tags

  dynamic "identity" {
    for_each = module.replicator.azapi_header.identity != null ? [module.replicator.azapi_header.identity] : []

    content {
      type         = identity.value.type
      identity_ids = try(identity.value.identity_ids, null)
    }
  }
  dynamic "timeouts" {
    for_each = module.replicator.timeouts != null ? [module.replicator.timeouts] : []

    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }
}
