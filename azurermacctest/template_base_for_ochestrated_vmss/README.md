# Test Case: templateBaseForOchestratedVMSS

## Status: Part 1 Complete, Part 2 Not Applicable

### Part 1: Test Case Extraction ✅ COMPLETE

Successfully extracted the `templateBaseForOchestratedVMSS` method from `windows_virtual_machine_resource_orchestrated_test.go` and created a complete, runnable Terraform configuration in `main.tf`.

**Transformation Details:**
- Converted `data.RandomString` → `random_string.name.result`
- Converted `data.RandomInteger` → `random_integer.number.result`
- Converted `data.Locations.Primary` → `"eastus"`
- Created single `random_string` and `random_integer` resources as per instructions
- Added all required provider blocks
- Preserved the `locals` block with the vm_name variable

**Resources in main.tf:**
1. `random_string.name` - for all string placeholders
2. `random_integer.number` - for all integer placeholders
3. `azurerm_resource_group.test` - resource group
4. `azurerm_virtual_network.test` - virtual network
5. `azurerm_subnet.test` - subnet

### Part 2: AzAPI Conversion ❌ NOT APPLICABLE

This test case is a **base template/helper method** that only provides supporting infrastructure resources. It does not contain an `azurerm_windows_virtual_machine` resource to convert to AzAPI.

**Reason:** The `templateBaseForOchestratedVMSS` method is used as a base template that other test methods build upon by appending additional resources (network interfaces, orchestrated VMSS, and the actual Windows VM). This specific method only contains:
- Resource group
- Virtual network
- Subnet

Since there is no target `azurerm_windows_virtual_machine` resource in this template, Part 2 conversion steps cannot be performed.

### Usage

This template serves as infrastructure setup for tests involving Windows VMs in orchestrated Virtual Machine Scale Sets. Other test methods call this template and append the actual VM resources on top of this base infrastructure.
