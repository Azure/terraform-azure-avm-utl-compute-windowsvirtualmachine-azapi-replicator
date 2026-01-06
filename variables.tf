# New variables only

variable "location" {
  type        = string
  description = "(Required) The Azure location where the Windows Virtual Machine should exist. Changing this forces a new resource to be created."
  nullable    = false
}

variable "name" {
  type        = string
  description = "(Required) The name of the Windows Virtual Machine. Changing this forces a new resource to be created."
  nullable    = false

  validation {
    condition     = length(var.name) <= 80
    error_message = "The name can be at most 80 characters."
  }
  validation {
    condition     = can(regex("^[a-zA-Z0-9._-]+$", var.name))
    error_message = "The name may only contain alphanumeric characters, dots, dashes and underscores."
  }
  validation {
    condition     = can(regex("^[a-zA-Z0-9]", var.name))
    error_message = "The name must begin with an alphanumeric character."
  }
  validation {
    condition     = can(regex("\\w$", var.name))
    error_message = "The name must end with an alphanumeric character or underscore."
  }
  validation {
    condition     = !can(regex("^\\d+$", var.name))
    error_message = "The name cannot contain only numbers."
  }
}

variable "network_interface_ids" {
  type        = list(string)
  description = "(Required). A list of Network Interface IDs which should be attached to this Virtual Machine. The first Network Interface ID in this list will be the Primary Network Interface on the Virtual Machine."
  nullable    = false

  validation {
    condition     = length(var.network_interface_ids) >= 1
    error_message = "At least one Network Interface ID must be provided."
  }
}

variable "os_disk" {
  type = object({
    caching                          = string
    disk_encryption_set_id           = optional(string)
    disk_size_gb                     = optional(number)
    name                             = optional(string)
    secure_vm_disk_encryption_set_id = optional(string)
    security_encryption_type         = optional(string)
    storage_account_type             = string
    write_accelerator_enabled        = optional(bool, false)
    diff_disk_settings = optional(object({
      option    = string
      placement = optional(string, "CacheDisk")
    }))
  })
  description = <<-EOT
 - `caching` - (Required) The Type of Caching which should be used for the Internal OS Disk. Possible values are `None`, `ReadOnly` and `ReadWrite`.
 - `disk_encryption_set_id` - (Optional) The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk. Conflicts with `secure_vm_disk_encryption_set_id`.
 - `disk_size_gb` - (Optional) The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from.
 - `name` - (Optional) The name which should be used for the Internal OS Disk. Changing this forces a new resource to be created.
 - `secure_vm_disk_encryption_set_id` - (Optional) The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk when the Virtual Machine is a Confidential VM. Conflicts with `disk_encryption_set_id`. Changing this forces a new resource to be created.
 - `security_encryption_type` - (Optional) Encryption Type when the Virtual Machine is a Confidential VM. Possible values are `VMGuestStateOnly` and `DiskWithVMGuestState`. Changing this forces a new resource to be created.
 - `storage_account_type` - (Optional) The Type of Storage Account which should back this the Internal OS Disk. Possible values are `Standard_LRS`, `StandardSSD_LRS`, `Premium_LRS`, `StandardSSD_ZRS` and `Premium_ZRS`. Changing this forces a new resource to be created.
 - `write_accelerator_enabled` - (Optional) Should Write Accelerator be Enabled for this OS Disk? Defaults to `false`.

 ---
 `diff_disk_settings` block supports the following:
 - `option` - (Required) Specifies the Ephemeral Disk Settings for the OS Disk. At this time the only possible value is `Local`. Changing this forces a new resource to be created.
 - `placement` - (Optional) Specifies where to store the Ephemeral Disk. Possible values are `CacheDisk`, `ResourceDisk` and `NvmeDisk`. Defaults to `CacheDisk`. Changing this forces a new resource to be created.
EOT
  nullable    = false

  validation {
    condition     = var.os_disk.disk_encryption_set_id == null || var.os_disk.secure_vm_disk_encryption_set_id == null
    error_message = "os_disk.disk_encryption_set_id cannot be used together with os_disk.secure_vm_disk_encryption_set_id (ConflictsWith)."
  }
  validation {
    condition     = var.os_disk.secure_vm_disk_encryption_set_id == null || var.os_disk.security_encryption_type == "DiskWithVMGuestState"
    error_message = "os_disk.secure_vm_disk_encryption_set_id can only be specified when os_disk.security_encryption_type is set to 'DiskWithVMGuestState'."
  }
  validation {
    condition = contains([
      "None",
      "ReadOnly",
      "ReadWrite"
    ], var.os_disk.caching)
    error_message = "The os_disk.caching must be one of: None, ReadOnly, ReadWrite."
  }
  validation {
    condition = contains([
      "Standard_LRS",
      "StandardSSD_LRS",
      "Premium_LRS",
      "StandardSSD_ZRS",
      "Premium_ZRS"
    ], var.os_disk.storage_account_type)
    error_message = "The os_disk.storage_account_type must be one of: Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS, Premium_ZRS."
  }
  validation {
    condition     = var.os_disk.disk_size_gb == null || (var.os_disk.disk_size_gb >= 0 && var.os_disk.disk_size_gb <= 4095)
    error_message = "The os_disk.disk_size_gb must be between 0 and 4095."
  }
  validation {
    condition = var.os_disk.security_encryption_type == null || contains([
      "VMGuestStateOnly",
      "DiskWithVMGuestState"
    ], var.os_disk.security_encryption_type)
    error_message = "The os_disk.security_encryption_type must be one of: VMGuestStateOnly, DiskWithVMGuestState."
  }
  validation {
    condition     = var.os_disk.security_encryption_type != "DiskWithVMGuestState" || var.secure_boot_enabled == true
    error_message = "secure_boot_enabled must be set to true when os_disk.security_encryption_type is set to 'DiskWithVMGuestState'."
  }
  validation {
    condition     = var.os_disk.security_encryption_type == null || var.vtpm_enabled == true
    error_message = "vtpm_enabled must be set to true when os_disk.security_encryption_type is set."
  }
  validation {
    condition     = var.os_disk.diff_disk_settings == null || var.os_disk.caching == "ReadOnly"
    error_message = "os_disk.diff_disk_settings can only be set when os_disk.caching is set to 'ReadOnly'."
  }
  validation {
    condition     = var.os_disk.diff_disk_settings == null || contains(["Local"], var.os_disk.diff_disk_settings.option)
    error_message = "os_disk.diff_disk_settings.option must be 'Local'."
  }
  validation {
    condition = var.os_disk.diff_disk_settings == null || contains([
      "CacheDisk",
      "ResourceDisk",
      "NvmeDisk"
    ], var.os_disk.diff_disk_settings.placement)
    error_message = "os_disk.diff_disk_settings.placement must be one of: CacheDisk, ResourceDisk, NvmeDisk."
  }
}

variable "resource_group_id" {
  type        = string
  description = "The ID of the Resource Group in which the Windows Virtual Machine should exist."
  nullable    = false
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which the Windows Virtual Machine should be exist. Changing this forces a new resource to be created."
  nullable    = false

  validation {
    condition     = length(var.resource_group_name) <= 90
    error_message = "The resource_group_name may not exceed 90 characters in length."
  }
  validation {
    condition     = !can(regex("\\.$", var.resource_group_name))
    error_message = "The resource_group_name may not end with a period."
  }
  validation {
    condition     = can(regex("^[-\\w._()]+$", var.resource_group_name))
    error_message = "The resource_group_name may only contain alphanumeric characters, dash, underscores, parentheses and periods."
  }
}

variable "size" {
  type        = string
  description = "(Required) The SKU which should be used for this Virtual Machine, such as `Standard_F2`."
  nullable    = false

  validation {
    condition     = var.size != ""
    error_message = "The size must not be empty."
  }
}

variable "additional_capabilities" {
  type = object({
    hibernation_enabled = optional(bool, false)
    ultra_ssd_enabled   = optional(bool, false)
  })
  default     = null
  description = <<-EOT
 - `hibernation_enabled` - (Optional) Whether to enable the hibernation capability or not.
 - `ultra_ssd_enabled` - (Optional) Should the capacity to enable Data Disks of the `UltraSSD_LRS` storage account type be supported on this Virtual Machine? Defaults to `false`.
EOT
}

variable "additional_unattend_content" {
  type = list(object({
    content = string
    setting = string
  }))
  default     = null
  description = <<-EOT
 - `content` - (Required) The XML formatted content that is added to the unattend.xml file for the specified path and component. Changing this forces a new resource to be created.
 - `setting` - (Required) The name of the setting to which the content applies. Possible values are `AutoLogon` and `FirstLogonCommands`. Changing this forces a new resource to be created.
EOT

  validation {
    condition = var.additional_unattend_content == null || alltrue([
      for item in var.additional_unattend_content : contains(["AutoLogon", "FirstLogonCommands"], item.setting)
    ])
    error_message = "Each setting value must be either 'AutoLogon' or 'FirstLogonCommands'."
  }
}

variable "additional_unattend_content_version" {
  type        = number
  default     = null
  description = "Version number for additional_unattend_content to trigger replacement when changed. Must be set when additional_unattend_content is provided."

  validation {
    condition     = var.additional_unattend_content == null || length(var.additional_unattend_content) == 0 || var.additional_unattend_content_version != null
    error_message = "When additional_unattend_content is set with items, additional_unattend_content_version must also be set."
  }
}

variable "admin_password" {
  type        = string
  ephemeral   = true
  default     = null
  description = "(Optional) The Password which should be used for the local-administrator on this Virtual Machine. Changing this forces a new resource to be created."

  validation {
    condition     = var.admin_password == null || can(regex("^.{8,123}$", var.admin_password))
    error_message = "The admin_password must be between 8 and 123 characters."
  }
  validation {
    condition = var.admin_password == null || !contains([
      "abc@123", "P@$$w0rd", "P@ssw0rd", "P@ssword123", "Pa$$word",
      "pass@word1", "Password!", "Password1", "Password22", "iloveyou!"
    ], var.admin_password)
    error_message = "The admin_password cannot be one of the following disallowed values: abc@123, P@$$w0rd, P@ssw0rd, P@ssword123, Pa$$word, pass@word1, Password!, Password1, Password22, iloveyou!"
  }
  validation {
    condition = var.admin_password == null || (
      length(regexall("[a-z]", var.admin_password)) > 0 ? 1 : 0
      ) + (length(regexall("[A-Z]", var.admin_password)) > 0 ? 1 : 0
      ) + (length(regexall("[0-9]", var.admin_password)) > 0 ? 1 : 0
      ) + (length(regexall("[^\\w]", var.admin_password)) > 0 ? 1 : 0
    ) >= 3
    error_message = "The admin_password must fulfill 3 out of these 4 conditions: Has lower characters, Has upper characters, Has a digit, Has a special character (Regex match [\\W_])."
  }
}

variable "admin_password_version" {
  type        = number
  default     = null
  description = "Version number for admin_password to trigger replacement when changed. Must be set when admin_password is provided."

  validation {
    condition     = var.admin_password == null || var.admin_password_version != null
    error_message = "When admin_password is set, admin_password_version must also be set."
  }
}

variable "admin_username" {
  type        = string
  default     = null
  description = "(Optional) The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."

  validation {
    condition     = var.admin_username == null || length(var.admin_username) <= 20
    error_message = "The admin_username must be between 1 and 20 characters."
  }
  validation {
    condition     = var.admin_username == null || !can(regex("\\.$", var.admin_username))
    error_message = "The admin_username cannot end with a dot."
  }
  validation {
    condition = var.admin_username == null || !contains([
      "administrator", "admin", "user", "user1", "test", "user2", "test1", "user3",
      "admin1", "1", "123", "a", "actuser", "adm", "admin2", "aspnet", "backup",
      "console", "david", "guest", "john", "owner", "root", "server", "sql",
      "support", "support_388945a0", "sys", "test2", "test3", "user4", "user5"
    ], var.admin_username)
    error_message = "The admin_username cannot be one of the following disallowed values: administrator, admin, user, user1, test, user2, test1, user3, admin1, 1, 123, a, actuser, adm, admin2, aspnet, backup, console, david, guest, john, owner, root, server, sql, support, support_388945a0, sys, test2, test3, user4, user5."
  }
  validation {
    condition     = var.admin_password == null || var.admin_username != null
    error_message = "When admin_password is set, admin_username must also be set (RequiredWith)."
  }
  validation {
    condition     = var.admin_username == null || var.admin_password != null
    error_message = "When admin_username is set, admin_password must also be set (RequiredWith)."
  }
}

variable "allow_extension_operations" {
  type        = bool
  default     = true
  description = "(Optional) Should Extension Operations be allowed on this Virtual Machine? Defaults to `true`."
  nullable    = false

  validation {
    condition     = var.provision_vm_agent != false || var.allow_extension_operations == false
    error_message = "`allow_extension_operations` cannot be set to `true` when `provision_vm_agent` is set to `false`."
  }
}

variable "automatic_updates_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Specifies if Automatic Updates are Enabled for the Windows Virtual Machine. Changing this forces a new resource to be created. Defaults to `true`."
  nullable    = false
}

variable "availability_set_id" {
  type        = string
  default     = null
  description = "(Optional) Specifies the ID of the Availability Set in which the Virtual Machine should exist. Changing this forces a new resource to be created."

  validation {
    condition     = var.capacity_reservation_group_id == null || var.availability_set_id == null
    error_message = "availability_set_id cannot be used together with capacity_reservation_group_id (ConflictsWith)."
  }
  validation {
    condition     = var.virtual_machine_scale_set_id == null || var.availability_set_id == null
    error_message = "availability_set_id cannot be used together with virtual_machine_scale_set_id (ConflictsWith)."
  }
  validation {
    condition     = var.zone == null || var.availability_set_id == null
    error_message = "availability_set_id cannot be used together with zone (ConflictsWith)."
  }
}

variable "boot_diagnostics" {
  type = object({
    storage_account_uri = optional(string)
  })
  default     = null
  description = <<-EOT
 - `storage_account_uri` - (Optional) The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor.
EOT
}

variable "bypass_platform_safety_checks_on_user_schedule_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Specifies whether to skip platform scheduled patching when a user schedule is associated with the VM. Defaults to `false`."
  nullable    = false

  validation {
    condition     = !var.bypass_platform_safety_checks_on_user_schedule_enabled || var.patch_mode == "AutomaticByPlatform"
    error_message = "`patch_mode` must be set to `AutomaticByPlatform` when `bypass_platform_safety_checks_on_user_schedule_enabled` is set to `true`."
  }
}

variable "capacity_reservation_group_id" {
  type        = string
  default     = null
  description = "(Optional) Specifies the ID of the Capacity Reservation Group which the Virtual Machine should be allocated to."

  validation {
    condition     = var.capacity_reservation_group_id == null || can(regex("^/subscriptions/[^/]+/resourceGroups/[^/]+/providers/Microsoft\\.Compute/capacityReservationGroups/[^/]+$", var.capacity_reservation_group_id))
    error_message = "The capacity_reservation_group_id must be a valid Capacity Reservation Group ID."
  }
}

variable "computer_name" {
  type        = string
  default     = null
  description = "(Optional) Specifies the Hostname which should be used for this Virtual Machine. If unspecified this defaults to the value for the `name` field. If the value of the `name` field is not a valid `computer_name`, then you must specify `computer_name`. Changing this forces a new resource to be created."

  validation {
    condition     = var.computer_name == null || var.computer_name != ""
    error_message = "The computer_name must not be empty."
  }
  validation {
    condition     = var.computer_name == null || length(var.computer_name) <= 15
    error_message = "The computer_name can be at most 15 characters."
  }
  validation {
    condition     = var.computer_name == null || !can(regex("-$", var.computer_name))
    error_message = "The computer_name cannot end with dash."
  }
  validation {
    condition     = var.computer_name == null || can(regex("^[a-zA-Z0-9-]+$", var.computer_name))
    error_message = "The computer_name may only contain alphanumeric characters and dashes."
  }
  validation {
    condition     = var.computer_name == null || !can(regex("^\\d+$", var.computer_name))
    error_message = "The computer_name cannot contain only numbers."
  }
  validation {
    condition = var.computer_name != null || (
      var.name != "" &&
      length(var.name) <= 15 &&
      !can(regex("-$", var.name)) &&
      can(regex("^[a-zA-Z0-9-]+$", var.name)) &&
      !can(regex("^\\d+$", var.name))
    )
    error_message = "When computer_name is not specified, the VM name must be a valid computer name (max 15 characters, alphanumeric and dashes only, cannot end with dash, cannot contain only numbers). Please provide an explicit computer_name."
  }
}

variable "custom_data" {
  type        = string
  ephemeral   = true
  default     = null
  description = "(Optional) The Base64-Encoded Custom Data which should be used for this Virtual Machine. Changing this forces a new resource to be created."

  validation {
    condition     = var.custom_data == null || can(base64decode(var.custom_data))
    error_message = "The custom_data must be a valid Base64 encoded string."
  }
}

variable "custom_data_version" {
  type        = number
  default     = null
  description = "Version number for custom_data to trigger replacement when changed. Must be set when custom_data is provided."

  validation {
    condition     = var.custom_data == null || var.custom_data_version != null
    error_message = "When custom_data is set, custom_data_version must also be set."
  }
}

variable "dedicated_host_group_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of a Dedicated Host Group that this Windows Virtual Machine should be run within. Conflicts with `dedicated_host_id`."
}

variable "dedicated_host_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of a Dedicated Host where this machine should be run on. Conflicts with `dedicated_host_group_id`."

  validation {
    condition     = var.dedicated_host_group_id == null || var.dedicated_host_id == null
    error_message = "dedicated_host_id cannot be used together with dedicated_host_group_id (ConflictsWith)."
  }
}

variable "disk_controller_type" {
  type        = string
  default     = null
  description = "(Optional) Specifies the Disk Controller Type used for this Virtual Machine. Possible values are `SCSI` and `NVMe`."

  validation {
    condition = var.disk_controller_type == null || contains([
      "NVMe",
      "SCSI"
    ], var.disk_controller_type)
    error_message = "The disk_controller_type must be either 'NVMe' or 'SCSI'."
  }
}

variable "edge_zone" {
  type        = string
  default     = null
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Windows Virtual Machine should exist. Changing this forces a new Windows Virtual Machine to be created."

  validation {
    condition     = var.edge_zone == null || var.edge_zone != ""
    error_message = "The edge_zone must not be empty."
  }
}

variable "enable_automatic_updates" {
  type        = bool
  default     = null
  description = "(Optional) **DEPRECATED in favor of `automatic_updates_enabled`** - Specifies if Automatic Updates are Enabled for the Windows Virtual Machine. Changing this forces a new resource to be created. This property has been deprecated in favour of `automatic_updates_enabled` and will be removed in 5.0 of the provider. Note: This field maps to the same API property as `automatic_updates_enabled`. If set, it must have the same value as `automatic_updates_enabled` (which defaults to `true`)."
}

variable "enable_telemetry" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see <https://aka.ms/avm/telemetryinfo>.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
  nullable    = false
}

variable "encryption_at_host_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?"

  validation {
    condition = (
      var.encryption_at_host_enabled != true ||
      try(var.os_disk.security_encryption_type, null) != "DiskWithVMGuestState"
    )
    error_message = "`encryption_at_host_enabled` cannot be set to `true` when `os_disk.0.security_encryption_type` is set to `DiskWithVMGuestState`."
  }
}

variable "eviction_policy" {
  type        = string
  default     = null
  description = "(Optional) Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance. Possible values are `Deallocate` and `Delete`. Changing this forces a new resource to be created."

  validation {
    condition = var.eviction_policy == null || contains([
      "Deallocate",
      "Delete"
    ], var.eviction_policy)
    error_message = "The eviction_policy must be either 'Deallocate' or 'Delete'."
  }
}

variable "extensions_time_budget" {
  type        = string
  default     = "PT1H30M"
  description = "(Optional) Specifies the duration allocated for all extensions to start. The time duration should be between 15 minutes and 120 minutes (inclusive) and should be specified in ISO 8601 format. Defaults to `PT1H30M`."
  nullable    = false

  validation {
    condition     = can(regex("^PT([0-1]?[0-9]|2[0-3])H([0-5]?[0-9]M)?$", var.extensions_time_budget)) || can(regex("^PT([0-9]|[1-9][0-9]|1[0-1][0-9]|120)M$", var.extensions_time_budget))
    error_message = "The extensions_time_budget must be a valid ISO 8601 duration format."
  }
  validation {
    condition = (
      can(regex("^PT([0-9]+)M$", var.extensions_time_budget)) ?
      tonumber(regex("^PT([0-9]+)M$", var.extensions_time_budget)[0]) >= 15 && tonumber(regex("^PT([0-9]+)M$", var.extensions_time_budget)[0]) <= 120 :
      can(regex("^PT([0-9]+)H([0-9]+)M$", var.extensions_time_budget)) ?
      (tonumber(regex("^PT([0-9]+)H([0-9]+)M$", var.extensions_time_budget)[0]) * 60 + tonumber(regex("^PT([0-9]+)H([0-9]+)M$", var.extensions_time_budget)[1])) >= 15 &&
      (tonumber(regex("^PT([0-9]+)H([0-9]+)M$", var.extensions_time_budget)[0]) * 60 + tonumber(regex("^PT([0-9]+)H([0-9]+)M$", var.extensions_time_budget)[1])) <= 120 :
      can(regex("^PT([0-9]+)H$", var.extensions_time_budget)) ?
      tonumber(regex("^PT([0-9]+)H$", var.extensions_time_budget)[0]) * 60 >= 15 && tonumber(regex("^PT([0-9]+)H$", var.extensions_time_budget)[0]) * 60 <= 120 :
      false
    )
    error_message = "The extensions_time_budget must be between PT15M (15 minutes) and PT2H (120 minutes)."
  }
}

variable "gallery_application" {
  type = list(object({
    automatic_upgrade_enabled                   = optional(bool, false)
    configuration_blob_uri                      = optional(string)
    order                                       = optional(number, 0)
    tag                                         = optional(string)
    treat_failure_as_deployment_failure_enabled = optional(bool, false)
    version_id                                  = string
  }))
  default     = null
  description = <<-EOT
 - `automatic_upgrade_enabled` - (Optional) Specifies whether the version will be automatically updated for the VM when a new Gallery Application version is available in PIR/SIG. Defaults to `false`.
 - `configuration_blob_uri` - (Optional) Specifies the URI to an Azure Blob that will replace the default configuration for the package if provided.
 - `order` - (Optional) Specifies the order in which the packages have to be installed. Possible values are between `0` and `2147483647`. Defaults to `0`.
 - `tag` - (Optional) Specifies a passthrough value for more generic context. This field can be any valid `string` value.
 - `treat_failure_as_deployment_failure_enabled` - (Optional) Specifies whether any failure for any operation in the VmApplication will fail the deployment of the VM. Defaults to `false`.
 - `version_id` - (Required) Specifies the Gallery Application Version resource ID.
EOT

  validation {
    condition = var.gallery_application == null || alltrue([
      for app in var.gallery_application : app.configuration_blob_uri == null || (
        can(regex("^https?://", app.configuration_blob_uri))
      )
    ])
    error_message = "Each gallery_application.configuration_blob_uri must be a valid URL with HTTP or HTTPS protocol."
  }
  validation {
    condition = var.gallery_application == null || alltrue([
      for app in var.gallery_application : app.order >= 0 && app.order <= 2147483647
    ])
    error_message = "Each gallery_application.order must be between 0 and 2147483647."
  }
  validation {
    condition = var.gallery_application == null || alltrue([
      for app in var.gallery_application : app.tag == null || length(app.tag) > 0
    ])
    error_message = "Each gallery_application.tag must not be an empty string."
  }
}

variable "hotpatching_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Should the VM be patched without requiring a reboot? Possible values are `true` or `false`. Defaults to `false`. For more information about hot patching please see the [product documentation](https://docs.microsoft.com/azure/automanage/automanage-hotpatch)."

  validation {
    condition     = var.hotpatching_enabled != true || var.patch_mode == "AutomaticByPlatform"
    error_message = "`hotpatching_enabled` cannot be set to `true` when `patch_mode` is not set to `AutomaticByPlatform`."
  }
  validation {
    condition     = var.hotpatching_enabled != true || var.provision_vm_agent != false
    error_message = "`hotpatching_enabled` cannot be set to `true` when `provision_vm_agent` is set to `false`."
  }
  validation {
    condition = var.hotpatching_enabled != true || var.source_image_reference == null || (
      var.source_image_reference.publisher == "MicrosoftWindowsServer" &&
      var.source_image_reference.offer == "WindowsServer" &&
      contains([
        "2022-datacenter-azure-edition-core",
        "2022-datacenter-azure-edition-core-smalldisk",
        "2022-datacenter-azure-edition-hotpatch",
        "2022-datacenter-azure-edition-hotpatch-smalldisk",
        "2025-datacenter-azure-edition",
        "2025-datacenter-azure-edition-smalldisk",
        "2025-datacenter-azure-edition-core",
        "2025-datacenter-azure-edition-core-smalldisk"
      ], var.source_image_reference.sku)
    )
    error_message = "`hotpatching_enabled` is currently only supported on `2022-datacenter-azure-edition-core`, `2022-datacenter-azure-edition-core-smalldisk`, `2022-datacenter-azure-edition-hotpatch`, `2022-datacenter-azure-edition-hotpatch-smalldisk`, `2025-datacenter-azure-edition`, `2025-datacenter-azure-edition-smalldisk`, `2025-datacenter-azure-edition-core` or `2025-datacenter-azure-edition-core-smalldisk` image reference SKUs."
  }
}

variable "identity" {
  type = object({
    identity_ids = optional(set(string))
    type         = string
  })
  default     = null
  description = <<-EOT
 - `identity_ids` - (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Windows Virtual Machine.
 - `type` - (Required) Specifies the type of Managed Service Identity that should be configured on this Windows Virtual Machine. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both).
EOT

  validation {
    condition     = var.identity == null || var.identity.type != null
    error_message = "When identity is set, the type field is required."
  }
  validation {
    condition     = var.identity == null || contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity.type)
    error_message = "The identity type must be one of: SystemAssigned, UserAssigned, or SystemAssigned, UserAssigned."
  }
  validation {
    condition = var.identity == null || var.identity.identity_ids == null || (
      var.identity.type == "UserAssigned" || var.identity.type == "SystemAssigned, UserAssigned"
    )
    error_message = "`identity_ids` can only be specified when `type` is set to \"UserAssigned\" or \"SystemAssigned, UserAssigned\"."
  }
}

variable "license_type" {
  type        = string
  default     = null
  description = "(Optional) Specifies the type of on-premise license (also known as [Azure Hybrid Use Benefit](https://docs.microsoft.com/windows-server/get-started/azure-hybrid-benefit)) which should be used for this Virtual Machine. Possible values are `None`, `Windows_Client` and `Windows_Server`."

  validation {
    condition = var.license_type == null || contains([
      "None",
      "Windows_Client",
      "Windows_Server"
    ], var.license_type)
    error_message = "The license_type must be one of: None, Windows_Client, Windows_Server."
  }
}

variable "max_bid_price" {
  type        = number
  default     = null
  description = "(Optional) The maximum price you're willing to pay for this Virtual Machine, in US Dollars; which must be greater than the current spot price. If this bid price falls below the current spot price the Virtual Machine will be evicted using the `eviction_policy`. Defaults to `-1`, which means that the Virtual Machine should not be evicted for price reasons."
}

variable "os_image_notification" {
  type = object({
    timeout = optional(string, "PT15M")
  })
  default     = null
  description = <<-EOT
 - `timeout` - (Optional) Length of time a notification to be sent to the VM on the instance metadata server till the VM gets OS upgraded. The only possible value is `PT15M`. Defaults to `PT15M`.
EOT

  validation {
    condition = var.os_image_notification == null || (
      var.os_image_notification.timeout == "PT15M"
    )
    error_message = "The timeout must be 'PT15M' (the only allowed value)."
  }
}

variable "patch_assessment_mode" {
  type        = string
  default     = null
  description = "(Optional) Specifies the mode of VM Guest Patching for the Virtual Machine. Possible values are `AutomaticByPlatform` or `ImageDefault`. Defaults to `ImageDefault`."
}

variable "patch_mode" {
  type        = string
  default     = null
  description = "(Optional) Specifies the mode of in-guest patching to this Windows Virtual Machine. Possible values are `Manual`, `AutomaticByOS` and `AutomaticByPlatform`. Defaults to `AutomaticByOS`. For more information on patch modes please see the [product documentation](https://docs.microsoft.com/azure/virtual-machines/automatic-vm-guest-patching#patch-orchestration-modes)."
}

variable "plan" {
  type = object({
    name      = string
    product   = string
    publisher = string
  })
  default     = null
  description = <<-EOT
 - `name` - (Required) Specifies the Name of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
 - `product` - (Required) Specifies the Product of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
 - `publisher` - (Required) Specifies the Publisher of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
EOT
}

variable "platform_fault_domain" {
  type        = number
  default     = null
  description = "(Optional) Specifies the Platform Fault Domain in which this Windows Virtual Machine should be created. Defaults to `-1`, which means this will be automatically assigned to a fault domain that best maintains balance across the available fault domains. Changing this forces a new Windows Virtual Machine to be created."
}

variable "priority" {
  type        = string
  default     = null
  description = "(Optional) Specifies the priority of this Virtual Machine. Possible values are `Regular` and `Spot`. Defaults to `Regular`. Changing this forces a new resource to be created."
}

variable "provision_vm_agent" {
  type        = bool
  default     = true
  description = "(Optional) Should the Azure VM Agent be provisioned on this Virtual Machine? Defaults to `true`. Changing this forces a new resource to be created."
  nullable    = false
}

variable "proximity_placement_group_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of the Proximity Placement Group which the Virtual Machine should be assigned to."

  validation {
    condition = (
      var.proximity_placement_group_id == null ||
      can(regex("^/subscriptions/[^/]+/resourceGroups/[^/]+/providers/Microsoft\\.Compute/proximityPlacementGroups/[^/]+$", var.proximity_placement_group_id))
    )
    error_message = "The proximity_placement_group_id must be a valid Proximity Placement Group ID."
  }
  validation {
    condition     = var.proximity_placement_group_id == null || var.capacity_reservation_group_id == null
    error_message = "proximity_placement_group_id cannot be used together with capacity_reservation_group_id (ConflictsWith)."
  }
}

variable "reboot_setting" {
  type        = string
  default     = null
  description = "(Optional) Specifies the reboot setting for platform scheduled patching. Possible values are `Always`, `IfRequired` and `Never`."

  validation {
    condition = var.reboot_setting == null || contains([
      "Always",
      "IfRequired",
      "Never"
    ], var.reboot_setting)
    error_message = "The reboot_setting must be one of: Always, IfRequired, Never."
  }
  validation {
    condition     = var.reboot_setting == null || var.patch_mode == "AutomaticByPlatform"
    error_message = "`patch_mode` must be set to `AutomaticByPlatform` when `reboot_setting` is specified."
  }
}

variable "secret" {
  type = list(object({
    key_vault_id = string
    certificate = set(object({
      store = string
      url   = string
    }))
  }))
  default     = null
  description = <<-EOT
 - `key_vault_id` - (Required) The ID of the Key Vault from which all Secrets should be sourced.

 ---
 `certificate` block supports the following:
 - `store` - (Required) The certificate store on the Virtual Machine where the certificate should be added.
 - `url` - (Required) The Secret URL of a Key Vault Certificate.
EOT

  validation {
    condition = var.secret == null || alltrue([
      for secret_item in var.secret : alltrue([
        for cert in secret_item.certificate : can(regex("^https://[a-zA-Z0-9-]+\\.vault\\.(usgovcloudapi|azure\\.cn|microsoftonline\\.de|azure)\\.net/(secrets|certificates)/[^/]+(/[^/]+)?$", cert.url))
      ])
    ])
    error_message = "Each certificate url must be a valid Key Vault certificate or secret URL in the format: https://{vault}.vault.azure.net/{secrets|certificates}/{name} or https://{vault}.vault.azure.net/{secrets|certificates}/{name}/{version}"
  }
}

variable "secure_boot_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Specifies if Secure Boot and Trusted Launch is enabled for the Virtual Machine. Changing this forces a new resource to be created."
}

variable "source_image_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of the Image which this Virtual Machine should be created from. Changing this forces a new resource to be created. Possible Image ID types include `Image ID`s, `Shared Image ID`s, `Shared Image Version ID`s, `Community Gallery Image ID`s, `Community Gallery Image Version ID`s, `Shared Gallery Image ID`s and `Shared Gallery Image Version ID`s."

  validation {
    condition     = var.source_image_id == null || var.hotpatching_enabled != true
    error_message = "The hotpatching_enabled field is not supported if referencing the image via the source_image_id field."
  }
}

variable "source_image_reference" {
  type = object({
    offer     = string
    publisher = string
    sku       = string
    version   = string
  })
  default     = null
  description = <<-EOT
 - `offer` - (Required) Specifies the offer of the image used to create the virtual machines. Changing this forces a new resource to be created.
 - `publisher` - (Required) Specifies the publisher of the image used to create the virtual machines. Changing this forces a new resource to be created.
 - `sku` - (Required) Specifies the SKU of the image used to create the virtual machines. Changing this forces a new resource to be created.
 - `version` - (Required) Specifies the version of the image used to create the virtual machines. Changing this forces a new resource to be created.
EOT
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "(Optional) A mapping of tags which should be assigned to this Virtual Machine."

  validation {
    condition     = var.tags == null || length(var.tags) <= 50
    error_message = "A maximum of 50 tags can be applied to each resource."
  }
  validation {
    condition = var.tags == null || alltrue([
      for k, v in var.tags : length(k) <= 512
    ])
    error_message = "The maximum length for a tag key is 512 characters."
  }
  validation {
    condition = var.tags == null || alltrue([
      for k, v in var.tags : length(v) <= 256
    ])
    error_message = "The maximum length for a tag value is 256 characters."
  }
}

variable "termination_notification" {
  type = object({
    enabled = bool
    timeout = optional(string, "PT5M")
  })
  default     = null
  description = <<-EOT
 - `enabled` - (Required) Should the termination notification be enabled on this Virtual Machine?
 - `timeout` - (Optional) Length of time (in minutes, between `5` and `15`) a notification to be sent to the VM on the instance metadata server till the VM gets deleted. The time duration should be specified in ISO 8601 format. Defaults to `PT5M`.
EOT

  validation {
    condition     = var.termination_notification == null || var.termination_notification.timeout == null || can(regex("^PT([5-9]|1[0-5])M$", var.termination_notification.timeout))
    error_message = "The timeout must be an ISO 8601 duration between PT5M and PT15M."
  }
}

variable "timeouts" {
  type = object({
    create = optional(string)
    delete = optional(string)
    read   = optional(string)
    update = optional(string)
  })
  default     = null
  description = <<-EOT
 - `create` - 
 - `delete` - 
 - `read` - 
 - `update` - 
EOT
}

variable "timezone" {
  type        = string
  default     = null
  description = "(Optional) Specifies the Time Zone which should be used by the Virtual Machine, [the possible values are defined here](https://jackstromberg.com/2017/01/list-of-time-zones-consumed-by-azure/). Changing this forces a new resource to be created."

  validation {
    condition = var.timezone == null || contains([
      "",
      "Afghanistan Standard Time",
      "Alaskan Standard Time",
      "Arab Standard Time",
      "Arabian Standard Time",
      "Arabic Standard Time",
      "Argentina Standard Time",
      "Atlantic Standard Time",
      "AUS Central Standard Time",
      "AUS Eastern Standard Time",
      "Azerbaijan Standard Time",
      "Azores Standard Time",
      "Bahia Standard Time",
      "Bangladesh Standard Time",
      "Belarus Standard Time",
      "Canada Central Standard Time",
      "Cape Verde Standard Time",
      "Caucasus Standard Time",
      "Cen. Australia Standard Time",
      "Central America Standard Time",
      "Central Asia Standard Time",
      "Central Brazilian Standard Time",
      "Central Europe Standard Time",
      "Central European Standard Time",
      "Central Pacific Standard Time",
      "Central Standard Time (Mexico)",
      "Central Standard Time",
      "China Standard Time",
      "Dateline Standard Time",
      "E. Africa Standard Time",
      "E. Australia Standard Time",
      "E. Europe Standard Time",
      "E. South America Standard Time",
      "Eastern Standard Time (Mexico)",
      "Eastern Standard Time",
      "Egypt Standard Time",
      "Ekaterinburg Standard Time",
      "Fiji Standard Time",
      "FLE Standard Time",
      "Georgian Standard Time",
      "GMT Standard Time",
      "Greenland Standard Time",
      "Greenwich Standard Time",
      "GTB Standard Time",
      "Hawaiian Standard Time",
      "India Standard Time",
      "Iran Standard Time",
      "Israel Standard Time",
      "Jordan Standard Time",
      "Kaliningrad Standard Time",
      "Korea Standard Time",
      "Libya Standard Time",
      "Line Islands Standard Time",
      "Magadan Standard Time",
      "Mauritius Standard Time",
      "Middle East Standard Time",
      "Montevideo Standard Time",
      "Morocco Standard Time",
      "Mountain Standard Time (Mexico)",
      "Mountain Standard Time",
      "Myanmar Standard Time",
      "N. Central Asia Standard Time",
      "Namibia Standard Time",
      "Nepal Standard Time",
      "New Zealand Standard Time",
      "Newfoundland Standard Time",
      "North Asia East Standard Time",
      "North Asia Standard Time",
      "Pacific SA Standard Time",
      "Pacific Standard Time (Mexico)",
      "Pacific Standard Time",
      "Pakistan Standard Time",
      "Paraguay Standard Time",
      "Romance Standard Time",
      "Russia Time Zone 10",
      "Russia Time Zone 11",
      "Russia Time Zone 3",
      "Russian Standard Time",
      "SA Eastern Standard Time",
      "SA Pacific Standard Time",
      "SA Western Standard Time",
      "Samoa Standard Time",
      "SE Asia Standard Time",
      "Singapore Standard Time",
      "South Africa Standard Time",
      "Sri Lanka Standard Time",
      "Syria Standard Time",
      "Taipei Standard Time",
      "Tasmania Standard Time",
      "Tokyo Standard Time",
      "Tonga Standard Time",
      "Turkey Standard Time",
      "Ulaanbaatar Standard Time",
      "US Eastern Standard Time",
      "US Mountain Standard Time",
      "UTC",
      "UTC+12",
      "UTC-02",
      "UTC-11",
      "Venezuela Standard Time",
      "Vladivostok Standard Time",
      "W. Australia Standard Time",
      "W. Central Africa Standard Time",
      "W. Europe Standard Time",
      "West Asia Standard Time",
      "West Pacific Standard Time",
      "Yakutsk Standard Time",
    ], var.timezone)
    error_message = "The timezone must be a valid Windows timezone string. See https://jackstromberg.com/2017/01/list-of-time-zones-consumed-by-azure/ for valid values."
  }
}

variable "user_data" {
  type        = string
  default     = null
  description = "(Optional) The Base64-Encoded User Data which should be used for this Virtual Machine."

  validation {
    condition     = var.user_data == null || can(base64decode(var.user_data))
    error_message = "The user_data must be Base64-encoded."
  }
}

variable "virtual_machine_scale_set_id" {
  type        = string
  default     = null
  description = "(Optional) Specifies the Orchestrated Virtual Machine Scale Set that this Virtual Machine should be created within."
}

variable "vm_agent_platform_updates_enabled" {
  type    = bool
  default = null
}

variable "vtpm_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Specifies if vTPM (virtual Trusted Platform Module) and Trusted Launch is enabled for the Virtual Machine. Changing this forces a new resource to be created."
}

variable "winrm_listener" {
  type = set(object({
    certificate_url = optional(string)
    protocol        = string
  }))
  default     = null
  description = <<-EOT
 - `certificate_url` - (Optional) The Secret URL of a Key Vault Certificate, which must be specified when `protocol` is set to `Https`. Changing this forces a new resource to be created.
 - `protocol` - (Required) Specifies the protocol of listener. Possible values are `Http` or `Https`. Changing this forces a new resource to be created.
EOT

  validation {
    condition = var.winrm_listener == null || alltrue([
      for listener in var.winrm_listener : contains(["Http", "Https"], listener.protocol)
    ])
    error_message = "The protocol must be either 'Http' or 'Https'."
  }
  validation {
    condition = var.winrm_listener == null || alltrue([
      for listener in var.winrm_listener : (
        listener.certificate_url == null ||
        can(regex("^https://[a-zA-Z0-9-]+\\.vault(?:\\.azure\\.net|\\.azure\\.cn|\\.azure\\.us|\\.microsoftazure\\.de)/(?:secrets|certificates)/[^/]+(?:/[^/]+)?$", listener.certificate_url))
      )
    ])
    error_message = "The certificate_url must be a valid Key Vault secret or certificate URL (e.g., https://<vault-name>.vault.azure.net/secrets/<secret-name> or https://<vault-name>.vault.azure.net/certificates/<cert-name>)."
  }
}

variable "zone" {
  type        = string
  default     = null
  description = "* `zones`"
}
