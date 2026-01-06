# Migration Track: azurerm_windows_virtual_machine to azapi_resource

## Resource Information

### Source Resource
- **Type**: `azurerm_windows_virtual_machine`
- **Provider**: azurerm (HashiCorp)

### Target Resource
- **Type**: `azapi_resource`
- **Azure Resource Type**: `Microsoft.Compute/virtualMachines`
- **API Version**: `2024-03-01` (as used in azurerm provider source code)

### Evidence of Resource Type

**Source Code Reference**: From `resourceWindowsVirtualMachineCreate` function in the azurerm provider:

```go
import (
	"github.com/hashicorp/go-azure-sdk/resource-manager/compute/2024-03-01/virtualmachines"
)

func resourceWindowsVirtualMachineCreate(d *pluginsdk.ResourceData, meta interface{}) error {
	client := meta.(*clients.Client).Compute.VirtualMachinesClient
	subscriptionId := meta.(*clients.Client).Account.SubscriptionId
	ctx, cancel := timeouts.ForCreate(meta.(*clients.Client).StopContext, d)
	defer cancel()

	id := virtualmachines.NewVirtualMachineID(subscriptionId, d.Get("resource_group_name").(string), d.Get("name").(string))
	
	// ... creates params as virtualmachines.VirtualMachine
	
	if err := client.CreateOrUpdateThenPoll(ctx, id, params, virtualmachines.DefaultCreateOrUpdateOperationOptions()); err != nil {
		return fmt.Errorf("creating Windows %s: %+v", id, err)
	}
}
```

**Proof**: The create function uses the `virtualmachines` SDK package from path `resource-manager/compute/2024-03-01/virtualmachines`, which corresponds to Azure resource type `Microsoft.Compute/virtualMachines` with API version `2024-03-01`.

## Planning Task List

| No. | Path | Type | Required | Status | Proof Doc Markdown Link |
|-----|------|------|----------|--------|-------------------------|
| 1 | name | Argument | Yes | ✅ Completed | [1.name.md](1.name.md) |
| 2 | resource_group_name | Argument | Yes | ✅ Completed | [2.resource_group_name.md](2.resource_group_name.md) |
| 3 | location | Argument | Yes | ✅ Completed | [3.location.md](3.location.md) |
| 4 | network_interface_ids | Argument | Yes | ✅ Completed | [4.network_interface_ids.md](4.network_interface_ids.md) |
| 5 | size | Argument | Yes | ✅ Completed | [5.size.md](5.size.md) |
| 6 | admin_password | Argument | No | ✅ Completed | [6.admin_password.md](6.admin_password.md) |
| 7 | admin_username | Argument | No | ✅ Completed | [7.admin_username.md](7.admin_username.md) |
| 8 | allow_extension_operations | Argument | No | ✅ Completed | [8.allow_extension_operations.md](8.allow_extension_operations.md) |
| 9 | automatic_updates_enabled | Argument | No | ✅ Completed | [9.automatic_updates_enabled.md](9.automatic_updates_enabled.md) |
| 10 | availability_set_id | Argument | No | ✅ Completed | [10.availability_set_id.md](10.availability_set_id.md) |
| 11 | bypass_platform_safety_checks_on_user_schedule_enabled | Argument | No | ✅ Completed | [11.bypass_platform_safety_checks_on_user_schedule_enabled.md](11.bypass_platform_safety_checks_on_user_schedule_enabled.md) |
| 12 | capacity_reservation_group_id | Argument | No | ✅ Completed | [12.capacity_reservation_group_id.md](12.capacity_reservation_group_id.md) |
| 13 | computer_name | Argument | No | ✅ Completed | [13.computer_name.md](13.computer_name.md) |
| 14 | custom_data | Argument | No | ✅ Completed | [14.custom_data.md](14.custom_data.md) |
| 15 | dedicated_host_group_id | Argument | No | ✅ Completed | [15.dedicated_host_group_id.md](15.dedicated_host_group_id.md) |
| 16 | dedicated_host_id | Argument | No | ✅ Completed | [16.dedicated_host_id.md](16.dedicated_host_id.md) |
| 17 | disk_controller_type | Argument | No | ✅ Completed | [17.disk_controller_type.md](17.disk_controller_type.md) |
| 18 | edge_zone | Argument | No | ✅ Completed | [18.edge_zone.md](18.edge_zone.md) |
| 19 | enable_automatic_updates | Argument | No | ✅ Completed | [19.enable_automatic_updates.md](19.enable_automatic_updates.md) |
| 20 | encryption_at_host_enabled | Argument | No | ✅ Completed | [20.encryption_at_host_enabled.md](20.encryption_at_host_enabled.md) |
| 21 | eviction_policy | Argument | No | ✅ Completed | [21.eviction_policy.md](21.eviction_policy.md) |
| 22 | extensions_time_budget | Argument | No | ✅ Completed | [22.extensions_time_budget.md](22.extensions_time_budget.md) |
| 23 | hotpatching_enabled | Argument | No | ✅ Completed | [23.hotpatching_enabled.md](23.hotpatching_enabled.md) |
| 24 | license_type | Argument | No | ✅ Completed | [24.license_type.md](24.license_type.md) |
| 25 | max_bid_price | Argument | No | Failed | |
| 26 | os_managed_disk_id | Argument | No | Failed | |
| 27 | patch_assessment_mode | Argument | No | Failed | |
| 28 | patch_mode | Argument | No | Failed | |
| 29 | platform_fault_domain | Argument | No | Failed | |
| 30 | priority | Argument | No | Pending | |
| 31 | provision_vm_agent | Argument | No | ✅ Completed | [31.provision_vm_agent.md](31.provision_vm_agent.md) |
| 32 | proximity_placement_group_id | Argument | No | ✅ Completed | [32.proximity_placement_group_id.md](32.proximity_placement_group_id.md) |
| 33 | reboot_setting | Argument | No | ✅ Completed | [33.reboot_setting.md](33.reboot_setting.md) |
| 34 | secure_boot_enabled | Argument | No | ✅ Completed | [34.secure_boot_enabled.md](34.secure_boot_enabled.md) |
| 35 | source_image_id | Argument | No | ✅ Completed | [35.source_image_id.md](35.source_image_id.md) |
| 36 | tags | Argument | No | ✅ Completed | [36.tags.md](36.tags.md) |
| 37 | timezone | Argument | No | ✅ Completed | [37.timezone.md](37.timezone.md) |
| 38 | user_data | Argument | No | ✅ Completed | [38.user_data.md](38.user_data.md) |
| 39 | virtual_machine_scale_set_id | Argument | No | ✅ Completed | [39.virtual_machine_scale_set_id.md](39.virtual_machine_scale_set_id.md) |
| 40 | vm_agent_platform_updates_enabled | Argument | No | ✅ Completed | [40.vm_agent_platform_updates_enabled.md](40.vm_agent_platform_updates_enabled.md) |
| 41 | vtpm_enabled | Argument | No | ✅ Completed | [41.vtpm_enabled.md](41.vtpm_enabled.md) |
| 42 | zone | Argument | No | ✅ Completed | [42.zone.md](42.zone.md) |
| 43 | __check_root_hidden_fields__ | HiddenFieldsCheck | Yes | ✅ Completed | [43.__check_root_hidden_fields__.md](43.__check_root_hidden_fields__.md) |
| 44 | os_disk | Block | Yes | ✅ Completed | [44.os_disk.md](44.os_disk.md) |
| 45 | os_disk.caching | Argument | Yes | ✅ Completed | [45.os_disk.caching.md](45.os_disk.caching.md) |
| 46 | os_disk.storage_account_type | Argument | No | ✅ Completed | [46.os_disk.storage_account_type.md](46.os_disk.storage_account_type.md) |
| 47 | os_disk.disk_encryption_set_id | Argument | No | ✅ Completed | [47.os_disk.disk_encryption_set_id.md](47.os_disk.disk_encryption_set_id.md) |
| 48 | os_disk.disk_size_gb | Argument | No | ✅ Completed | [48.os_disk.disk_size_gb.md](48.os_disk.disk_size_gb.md) |
| 49 | os_disk.name | Argument | No | ✅ Completed | [49.os_disk.name.md](49.os_disk.name.md) |
| 50 | os_disk.secure_vm_disk_encryption_set_id | Argument | No | ✅ Completed | [50.os_disk.secure_vm_disk_encryption_set_id.md](50.os_disk.secure_vm_disk_encryption_set_id.md) |
| 51 | os_disk.security_encryption_type | Argument | No | ✅ Completed | [51.os_disk.security_encryption_type.md](51.os_disk.security_encryption_type.md) |
| 52 | os_disk.write_accelerator_enabled | Argument | No | ✅ Completed | [52.os_disk.write_accelerator_enabled.md](52.os_disk.write_accelerator_enabled.md) |
| 53 | os_disk.diff_disk_settings | Block | No | ✅ Completed | [53.os_disk.diff_disk_settings.md](53.os_disk.diff_disk_settings.md) |
| 54 | os_disk.diff_disk_settings.option | Argument | Yes | ✅ Completed | [54.os_disk.diff_disk_settings.option.md](54.os_disk.diff_disk_settings.option.md) |
| 55 | os_disk.diff_disk_settings.placement | Argument | No | ✅ Completed | [55.os_disk.diff_disk_settings.placement.md](55.os_disk.diff_disk_settings.placement.md) |
| 56 | additional_capabilities | Block | No | ✅ Completed | [56.additional_capabilities.md](56.additional_capabilities.md) |
| 57 | additional_capabilities.hibernation_enabled | Argument | No | ✅ Completed | [57.additional_capabilities.hibernation_enabled.md](57.additional_capabilities.hibernation_enabled.md) |
| 58 | additional_capabilities.ultra_ssd_enabled | Argument | No | ✅ Completed | [58.additional_capabilities.ultra_ssd_enabled.md](58.additional_capabilities.ultra_ssd_enabled.md) |
| 59 | additional_unattend_content | Block | No | ✅ Completed | [59.additional_unattend_content.md](59.additional_unattend_content.md) |
| 60 | additional_unattend_content.content | Argument | Yes | ✅ Completed | [60.additional_unattend_content.content.md](60.additional_unattend_content.content.md) |
| 61 | additional_unattend_content.setting | Argument | Yes | ✅ Completed | [61.additional_unattend_content.setting.md](61.additional_unattend_content.setting.md) |
| 62 | boot_diagnostics | Block | No | ✅ Completed | [62.boot_diagnostics.md](62.boot_diagnostics.md) |
| 63 | boot_diagnostics.storage_account_uri | Argument | No | ✅ Completed | [63.boot_diagnostics.storage_account_uri.md](63.boot_diagnostics.storage_account_uri.md) |
| 64 | gallery_application | Block | No | ✅ Completed | [64.gallery_application.md](64.gallery_application.md) |
| 65 | gallery_application.version_id | Argument | Yes | ✅ Completed | [65.gallery_application.version_id.md](65.gallery_application.version_id.md) |
| 66 | gallery_application.automatic_upgrade_enabled | Argument | No | ✅ Completed | [66.gallery_application.automatic_upgrade_enabled.md](66.gallery_application.automatic_upgrade_enabled.md) |
| 67 | gallery_application.configuration_blob_uri | Argument | No | ✅ Completed | [67.gallery_application.configuration_blob_uri.md](67.gallery_application.configuration_blob_uri.md) |
| 68 | gallery_application.order | Argument | No | ✅ Completed | [68.gallery_application.order.md](68.gallery_application.order.md) |
| 69 | gallery_application.tag | Argument | No | ✅ Completed | [69.gallery_application.tag.md](69.gallery_application.tag.md) |
| 70 | gallery_application.treat_failure_as_deployment_failure_enabled | Argument | No | ✅ Completed | [70.gallery_application.treat_failure_as_deployment_failure_enabled.md](70.gallery_application.treat_failure_as_deployment_failure_enabled.md) |
| 71 | identity | Block | No | ✅ Completed | [71.identity.md](71.identity.md) |
| 72 | identity.type | Argument | Yes | ✅ Completed | [72.identity.type.md](72.identity.type.md) |
| 73 | identity.identity_ids | Argument | No | ✅ Completed | [73.identity.identity_ids.md](73.identity.identity_ids.md) |
| 74 | os_image_notification | Block | No | ✅ Completed | [74.os_image_notification.md](74.os_image_notification.md) |
| 75 | os_image_notification.timeout | Argument | No | ✅ Completed | [75.os_image_notification.timeout.md](75.os_image_notification.timeout.md) |
| 76 | plan | Block | No | ✅ Completed | [76.plan.md](76.plan.md) |
| 77 | plan.name | Argument | Yes | ✅ Completed | [77.plan.name.md](77.plan.name.md) |
| 78 | plan.product | Argument | Yes | ✅ Completed | [78.plan.product.md](78.plan.product.md) |
| 79 | plan.publisher | Argument | Yes | ✅ Completed | [79.plan.publisher.md](79.plan.publisher.md) |
| 80 | secret | Block | No | ✅ Completed | [80.secret.md](80.secret.md) |
| 81 | secret.key_vault_id | Argument | Yes | ✅ Completed | [81.secret.key_vault_id.md](81.secret.key_vault_id.md) |
| 82 | secret.certificate | Block | Yes | ✅ Completed | [82.secret.certificate.md](82.secret.certificate.md) |
| 83 | secret.certificate.store | Argument | Yes | ✅ Completed | [83.secret.certificate.store.md](83.secret.certificate.store.md) |
| 84 | secret.certificate.url | Argument | Yes | ✅ Completed | [84.secret.certificate.url.md](84.secret.certificate.url.md) |
| 85 | source_image_reference | Block | No | ✅ Completed | [85.source_image_reference.md](85.source_image_reference.md) |
| 86 | source_image_reference.offer | Argument | Yes | ✅ Completed | [86.source_image_reference.offer.md](86.source_image_reference.offer.md) |
| 87 | source_image_reference.publisher | Argument | Yes | ✅ Completed | [87.source_image_reference.publisher.md](87.source_image_reference.publisher.md) |
| 88 | source_image_reference.sku | Argument | Yes | ✅ Completed | [88.source_image_reference.sku.md](88.source_image_reference.sku.md) |
| 89 | source_image_reference.version | Argument | Yes | ✅ Completed | [89.source_image_reference.version.md](89.source_image_reference.version.md) |
| 90 | termination_notification | Block | No | ✅ Completed | [90.termination_notification.md](90.termination_notification.md) |
| 91 | termination_notification.enabled | Argument | Yes | ✅ Completed | [91.termination_notification.enabled.md](91.termination_notification.enabled.md) |
| 92 | termination_notification.timeout | Argument | No | ✅ Completed | [92.termination_notification.timeout.md](92.termination_notification.timeout.md) |
| 93 | winrm_listener | Block | No | ✅ Completed | [93.winrm_listener.md](93.winrm_listener.md) |
| 94 | winrm_listener.protocol | Argument | Yes | ✅ Completed | [94.winrm_listener.protocol.md](94.winrm_listener.protocol.md) |
| 95 | winrm_listener.certificate_url | Argument | No | ✅ Completed | [95.winrm_listener.certificate_url.md](95.winrm_listener.certificate_url.md) |
| 96 | timeouts | Block | No | ✅ NOT APPLICABLE | [96.timeouts.md](96.timeouts.md) |
| 97 | timeouts.create | Argument | No | ✅ NOT APPLICABLE | [error_task97.md](error_task97.md) |
| 98 | timeouts.delete | Argument | No | ✅ NOT APPLICABLE | Meta-arguments not replicated |
| 99 | timeouts.read | Argument | No | ✅ NOT APPLICABLE | Meta-arguments not replicated |
| 100 | timeouts.update | Argument | No | ✅ NOT APPLICABLE | Meta-arguments not replicated |

## Timeout Configuration

**Evidence from Source Code**: From `resourceWindowsVirtualMachine()` schema definition:

```go
Timeouts: &pluginsdk.ResourceTimeout{
	Create: pluginsdk.DefaultTimeout(45 * time.Minute),
	Read:   pluginsdk.DefaultTimeout(5 * time.Minute),
	Update: pluginsdk.DefaultTimeout(45 * time.Minute),
	Delete: pluginsdk.DefaultTimeout(45 * time.Minute),
},
```

**Proof**: The resource supports all four timeout operations (create, read, update, delete) as defined in the schema function. Default values are 45 minutes for create/update/delete and 5 minutes for read.

## Notes

1. The resource uses API version `2024-03-01` based on the SDK import in the create function
2. All available API versions: 2015-06-15, 2016-03-30, 2016-04-30-preview, 2017-03-30, 2017-12-01, 2018-04-01, 2018-06-01, 2018-10-01, 2019-03-01, 2019-07-01, 2019-12-01, 2020-06-01, 2020-12-01, 2021-03-01, 2021-04-01, 2021-07-01, 2021-11-01, 2022-03-01, 2022-08-01, 2022-11-01, 2023-03-01, 2023-07-01, 2023-09-01, 2024-03-01, 2024-07-01, 2024-11-01
3. The `os_disk` block is required (min_items: 1, max_items: 1)
4. The `secret.certificate` block is required when `secret` is defined (min_items: 1)
5. Some fields are deprecated: `enable_automatic_updates` (replaced by `automatic_updates_enabled`), `vm_agent_platform_updates_enabled`
6. Total tasks: 100 items (5 required arguments, 37 optional arguments, 1 hidden fields check, 1 required block with nested items, 10 optional blocks with nested items, 1 timeouts block)
