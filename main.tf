data "azapi_resource" "existing" {
  name                   = var.name
  parent_id              = var.resource_group_id
  type                   = "Microsoft.Compute/virtualMachines@2024-03-01"
  ignore_not_found       = true
  response_export_values = ["*"]
}

locals {
  admin_password_should_suppress = (
    (local.existing_admin_password == "ignored-as-imported" || var.admin_password == "ignored-as-imported")
  )
  availability_set_id_should_suppress = (
    local.existing_availability_set_id != null &&
    local.desired_availability_set_id != null &&
    lower(local.existing_availability_set_id) == lower(local.desired_availability_set_id)
  )
  azapi_header = {
    type                 = "Microsoft.Compute/virtualMachines@2024-03-01"
    name                 = var.name
    location             = local.location_normalized
    parent_id            = var.resource_group_id
    tags                 = var.tags
    ignore_null_property = true
    retry                = null
    identity = var.identity != null ? {
      type         = var.identity.type
      identity_ids = var.identity.identity_ids != null ? tolist(var.identity.identity_ids) : null
    } : null
  }
  body = merge(
    {
      properties = merge(
        {
          hardwareProfile = {
            vmSize = var.size
          }
        },
        {
          networkProfile = {
            networkInterfaces = [
              for i, nic_id in var.network_interface_ids : {
                id = nic_id
                properties = {
                  primary = i == 0
                }
              }
            ]
          }
        },
        {
          storageProfile = merge(
            {
              dataDisks = []
            },
            {
              osDisk = merge(
                {
                  caching = var.os_disk.caching
                  managedDisk = merge(
                    {
                      storageAccountType = local.effective_os_disk_storage_account_type
                    },
                    local.effective_os_disk_disk_encryption_set_id != null ? {
                      diskEncryptionSet = {
                        id = local.effective_os_disk_disk_encryption_set_id
                      }
                    } : {},
                    (var.os_disk.security_encryption_type != null || var.os_disk.secure_vm_disk_encryption_set_id != null) ? {
                      securityProfile = merge(
                        var.os_disk.security_encryption_type != null ? {
                          securityEncryptionType = var.os_disk.security_encryption_type
                        } : {},
                        var.os_disk.secure_vm_disk_encryption_set_id != null ? {
                          diskEncryptionSet = {
                            id = var.os_disk.secure_vm_disk_encryption_set_id
                          }
                        } : {}
                      )
                    } : {}
                  )
                },
                var.os_disk.disk_size_gb != null && var.os_disk.disk_size_gb > 0 ? {
                  diskSizeGB = var.os_disk.disk_size_gb
                } : {},
                var.os_disk.name != null ? {
                  name = var.os_disk.name
                } : {},
                var.os_disk.diff_disk_settings != null ? {
                  diffDiskSettings = {
                    option    = var.os_disk.diff_disk_settings.option
                    placement = var.os_disk.diff_disk_settings.placement
                  }
                } : {},
                {
                  writeAcceleratorEnabled = var.os_disk.write_accelerator_enabled

                  createOption = "FromImage"
                  osType       = "Windows"
                }
              )
            },
            var.disk_controller_type != null ? {
              diskControllerType = var.disk_controller_type
            } : {},
            var.source_image_id != null ? {
              imageReference = local.source_image_id_reference
            } : {},
            var.source_image_reference != null ? {
              imageReference = {
                publisher = var.source_image_reference.publisher
                offer     = var.source_image_reference.offer
                sku       = var.source_image_reference.sku
                version   = var.source_image_reference.version
              }
            } : {}
          )
        },
        var.additional_capabilities != null ? {
          additionalCapabilities = {
            hibernationEnabled = var.additional_capabilities.hibernation_enabled
            ultraSSDEnabled    = var.additional_capabilities.ultra_ssd_enabled
          }
        } : {},
        {
          extensionsTimeBudget = var.extensions_time_budget
        },
        var.admin_username != null ? {
          osProfile = merge(
            {
              adminUsername = var.admin_username
            },
            {
              computerName = var.computer_name != null ? var.computer_name : var.name
            },
            {
              allowExtensionOperations = var.allow_extension_operations
            },
            {
              windowsConfiguration = merge(
                {
                  enableAutomaticUpdates = local.effective_automatic_updates
                },
                {
                  provisionVMAgent = var.provision_vm_agent
                },
                var.bypass_platform_safety_checks_on_user_schedule_enabled || var.hotpatching_enabled != null || var.reboot_setting != null ? {
                  patchSettings = merge(
                    var.bypass_platform_safety_checks_on_user_schedule_enabled || var.reboot_setting != null ? {
                      automaticByPlatformSettings = merge(
                        var.bypass_platform_safety_checks_on_user_schedule_enabled ? {
                          bypassPlatformSafetyChecksOnUserSchedule = true
                        } : {},
                        var.reboot_setting != null ? {
                          rebootSetting = var.reboot_setting
                        } : {}
                      )
                    } : {},
                    var.hotpatching_enabled != null ? {
                      enableHotpatching = var.hotpatching_enabled
                    } : {},
                    var.patch_mode != null ? {
                      patchMode = var.patch_mode
                    } : {}
                  )
                } : {},

                var.timezone != null ? {
                  timeZone = var.timezone
                } : {},
                var.winrm_listener != null && length(var.winrm_listener) > 0 ? {
                  winRM = {
                    listeners = [
                      for listener in var.winrm_listener : merge(
                        {
                          protocol = listener.protocol
                        },
                        listener.certificate_url != null ? {
                          certificateUrl = listener.certificate_url
                        } : {}
                      )
                    ]
                  }
                } : {}
              )
            },
            (var.secret != null && length(var.secret) > 0) ? {
              secrets = [
                for secret_item in var.secret : {
                  sourceVault = {
                    id = secret_item.key_vault_id
                  }
                  vaultCertificates = [
                    for cert in secret_item.certificate : {
                      certificateStore = cert.store
                      certificateUrl   = cert.url
                    }
                  ]
                }
              ]
            } : {}
          )
        } : {},
        local.effective_availability_set_id != null ? {
          availabilitySet = {
            id = local.effective_availability_set_id
          }
        } : {},
        local.effective_capacity_reservation_group_id != null ? {
          capacityReservation = {
            capacityReservationGroup = {
              id = local.effective_capacity_reservation_group_id
            }
          }
        } : {},
        local.effective_dedicated_host_group_id != null ? {
          hostGroup = {
            id = local.effective_dedicated_host_group_id
          }
        } : {},
        local.effective_dedicated_host_id != null ? {
          host = {
            id = local.effective_dedicated_host_id
          }
        } : {},
        var.encryption_at_host_enabled != null || var.secure_boot_enabled == true || var.vtpm_enabled == true ? {
          securityProfile = {
            for k, v in {
              encryptionAtHost = var.encryption_at_host_enabled
              securityType     = (var.os_disk.security_encryption_type != null && (var.os_disk.security_encryption_type == "VMGuestStateOnly" || var.os_disk.security_encryption_type == "DiskWithVMGuestState")) ? "ConfidentialVM" : (var.secure_boot_enabled == true || var.vtpm_enabled == true) ? "TrustedLaunch" : null
              uefiSettings = (var.secure_boot_enabled == true || var.vtpm_enabled == true) ? {
                for k2, v2 in {
                  secureBootEnabled = var.secure_boot_enabled == true ? true : null
                  vTpmEnabled       = var.vtpm_enabled == true ? true : null
                } : k2 => v2 if v2 != null
              } : null
            } : k => v if v != null
          }
        } : {},
        var.eviction_policy != null ? {
          evictionPolicy = var.eviction_policy
        } : {},
        {
          licenseType = local.effective_license_type
        },
        local.effective_proximity_placement_group_id != null ? {
          proximityPlacementGroup = {
            id = local.effective_proximity_placement_group_id
          }
        } : {},
        var.user_data != null ? {
          userData = var.user_data
        } : {},
        var.virtual_machine_scale_set_id != null ? {
          virtualMachineScaleSet = {
            id = var.virtual_machine_scale_set_id
          }
        } : {},
        {
          diagnosticsProfile = {
            bootDiagnostics = var.boot_diagnostics != null ? {
              enabled    = true
              storageUri = var.boot_diagnostics.storage_account_uri
              } : {
              enabled    = false
              storageUri = ""
            }
          }
        },
        var.gallery_application != null && length(var.gallery_application) > 0 ? {
          applicationProfile = {
            galleryApplications = [
              for app in var.gallery_application : {
                packageReferenceId              = app.version_id
                enableAutomaticUpgrade          = app.automatic_upgrade_enabled
                configurationReference          = app.configuration_blob_uri
                order                           = app.order
                tags                            = app.tag
                treatFailureAsDeploymentFailure = app.treat_failure_as_deployment_failure_enabled
              }
            ]
          }
        } : {},
        var.os_image_notification != null || var.termination_notification != null ? {
          scheduledEventsProfile = merge(
            var.os_image_notification != null ? {
              osImageNotificationProfile = {
                enable           = true
                notBeforeTimeout = var.os_image_notification.timeout
              }
            } : {},
            var.termination_notification != null ? {
              terminateNotificationProfile = {
                enable           = var.termination_notification.enabled
                notBeforeTimeout = var.termination_notification.timeout
              }
            } : {}
          )
        } : {}
      )
    },
    local.effective_edge_zone != null ? {
      extendedLocation = {
        name = local.effective_edge_zone
        type = "EdgeZone"
      }
    } : {},
    var.zone != null ? {
      zones = [var.zone]
    } : {},
    var.plan != null ? {
      plan = {
        name      = var.plan.name
        product   = var.plan.product
        publisher = var.plan.publisher
      }
    } : {}
  )
  capacity_reservation_group_id_should_suppress = (
    local.existing_capacity_reservation_group_id != null &&
    local.desired_capacity_reservation_group_id != null &&
    lower(local.existing_capacity_reservation_group_id) == lower(local.desired_capacity_reservation_group_id)
  )
  dedicated_host_group_id_should_suppress = (
    local.existing_dedicated_host_group_id != null &&
    local.desired_dedicated_host_group_id != null &&
    lower(local.existing_dedicated_host_group_id) == lower(local.desired_dedicated_host_group_id)
  )
  dedicated_host_id_should_suppress = (
    local.existing_dedicated_host_id != null &&
    local.desired_dedicated_host_id != null &&
    lower(local.existing_dedicated_host_id) == lower(local.desired_dedicated_host_id)
  )
  desired_availability_set_id            = var.availability_set_id
  desired_capacity_reservation_group_id  = var.capacity_reservation_group_id
  desired_dedicated_host_group_id        = var.dedicated_host_group_id
  desired_dedicated_host_id              = var.dedicated_host_id
  desired_edge_zone                      = local.edge_zone_normalized
  desired_license_type                   = var.license_type
  desired_os_disk_disk_encryption_set_id = var.os_disk.disk_encryption_set_id
  desired_os_disk_storage_account_type   = var.os_disk.storage_account_type
  desired_proximity_placement_group_id   = var.proximity_placement_group_id
  edge_zone_normalized                   = var.edge_zone != null ? replace(lower(var.edge_zone), " ", "") : null
  edge_zone_should_suppress = (
    local.existing_edge_zone != null &&
    local.desired_edge_zone != null &&
    replace(lower(local.existing_edge_zone), " ", "") == local.desired_edge_zone
  )
  effective_admin_password = local.admin_password_should_suppress ? coalesce(local.existing_admin_password, var.admin_password) : var.admin_password
  # enable_automatic_updates reconciliation logic - deprecated field overrides if set
  effective_automatic_updates              = var.enable_automatic_updates != null ? var.enable_automatic_updates : var.automatic_updates_enabled
  effective_availability_set_id            = local.availability_set_id_should_suppress ? coalesce(local.existing_availability_set_id, local.desired_availability_set_id) : local.desired_availability_set_id
  effective_capacity_reservation_group_id  = local.capacity_reservation_group_id_should_suppress ? coalesce(local.existing_capacity_reservation_group_id, local.desired_capacity_reservation_group_id) : local.desired_capacity_reservation_group_id
  effective_dedicated_host_group_id        = local.dedicated_host_group_id_should_suppress ? coalesce(local.existing_dedicated_host_group_id, local.desired_dedicated_host_group_id) : local.desired_dedicated_host_group_id
  effective_dedicated_host_id              = local.dedicated_host_id_should_suppress ? coalesce(local.existing_dedicated_host_id, local.desired_dedicated_host_id) : local.desired_dedicated_host_id
  effective_edge_zone                      = local.edge_zone_should_suppress ? coalesce(local.existing_edge_zone, local.desired_edge_zone) : local.desired_edge_zone
  effective_license_type                   = local.license_type_should_suppress ? coalesce(local.existing_license_type, local.desired_license_type) : (local.desired_license_type != null ? local.desired_license_type : "None")
  effective_os_disk_disk_encryption_set_id = local.os_disk_disk_encryption_set_id_should_suppress ? coalesce(local.existing_os_disk_disk_encryption_set_id, local.desired_os_disk_disk_encryption_set_id) : local.desired_os_disk_disk_encryption_set_id
  effective_os_disk_storage_account_type   = local.os_disk_storage_account_type_should_suppress ? coalesce(local.existing_os_disk_storage_account_type, local.desired_os_disk_storage_account_type) : local.desired_os_disk_storage_account_type
  effective_proximity_placement_group_id   = local.proximity_placement_group_id_should_suppress ? coalesce(local.existing_proximity_placement_group_id, local.desired_proximity_placement_group_id) : local.desired_proximity_placement_group_id
  existing_admin_password                  = local.should_read_existing_admin_password && data.azapi_resource.existing.exists ? try(data.azapi_resource.existing.output.properties.osProfile.adminPassword, null) : null
  existing_availability_set_id             = local.should_read_existing_availability_set_id && data.azapi_resource.existing.exists ? try(data.azapi_resource.existing.output.properties.availabilitySet.id, null) : null
  existing_capacity_reservation_group_id   = local.should_read_existing_capacity_reservation_group_id && data.azapi_resource.existing.exists ? try(data.azapi_resource.existing.output.properties.capacityReservation.capacityReservationGroup.id, null) : null
  existing_dedicated_host_group_id         = local.should_read_existing_dedicated_host_group_id && data.azapi_resource.existing.exists ? try(data.azapi_resource.existing.output.properties.hostGroup.id, null) : null
  existing_dedicated_host_id               = local.should_read_existing_dedicated_host_id && data.azapi_resource.existing.exists ? try(data.azapi_resource.existing.output.properties.host.id, null) : null
  existing_edge_zone                       = local.should_read_existing_edge_zone && data.azapi_resource.existing.exists ? try(data.azapi_resource.existing.output.extendedLocation.name, null) : null
  existing_license_type                    = data.azapi_resource.existing.exists ? try(data.azapi_resource.existing.output.properties.licenseType, null) : null
  existing_os_disk_disk_encryption_set_id  = local.should_read_existing_os_disk_disk_encryption_set_id && data.azapi_resource.existing.exists ? try(data.azapi_resource.existing.output.properties.storageProfile.osDisk.managedDisk.diskEncryptionSet.id, null) : null
  existing_os_disk_storage_account_type    = local.should_read_existing_os_disk_storage_account_type && data.azapi_resource.existing.exists ? try(data.azapi_resource.existing.output.properties.storageProfile.osDisk.managedDisk.storageAccountType, null) : null
  existing_proximity_placement_group_id    = local.should_read_existing_proximity_placement_group_id && data.azapi_resource.existing.exists ? try(data.azapi_resource.existing.output.properties.proximityPlacementGroup.id, null) : null
  license_type_should_suppress = (
    (local.existing_license_type == "None" && local.desired_license_type == null) ||
    (local.existing_license_type == null && local.desired_license_type == "None")
  )
  location_normalized = replace(lower(var.location), " ", "")
  locks = [
    "virtualMachine.${var.name}"
  ]
  os_disk_disk_encryption_set_id_should_suppress = (
    local.existing_os_disk_disk_encryption_set_id != null &&
    local.desired_os_disk_disk_encryption_set_id != null &&
    lower(local.existing_os_disk_disk_encryption_set_id) == lower(local.desired_os_disk_disk_encryption_set_id)
  )
  os_disk_storage_account_type_should_suppress = false
  proximity_placement_group_id_should_suppress = (
    local.existing_proximity_placement_group_id != null &&
    local.desired_proximity_placement_group_id != null &&
    lower(local.existing_proximity_placement_group_id) == lower(local.desired_proximity_placement_group_id)
  )
  replace_triggers_external_values = {
    name                                     = { value = var.name }
    location                                 = { value = local.location_normalized }
    admin_password_version                   = { value = var.admin_password_version }
    admin_username                           = { value = var.admin_username }
    automatic_updates_enabled                = { value = local.effective_automatic_updates }
    availability_set_id                      = { value = var.availability_set_id }
    capacity_reservation_group_id            = { value = var.capacity_reservation_group_id }
    computer_name                            = { value = var.computer_name != null ? var.computer_name : var.name }
    custom_data_version                      = { value = var.custom_data_version }
    dedicated_host_group_id                  = { value = var.dedicated_host_group_id }
    edge_zone                                = { value = local.edge_zone_normalized }
    eviction_policy                          = { value = var.eviction_policy }
    provision_vm_agent                       = { value = var.provision_vm_agent }
    proximity_placement_group_id             = { value = var.proximity_placement_group_id }
    secure_boot_enabled                      = { value = var.secure_boot_enabled }
    source_image_id                          = { value = var.source_image_id }
    source_image_reference                   = { value = var.source_image_reference }
    timezone                                 = { value = var.timezone }
    vtpm_enabled                             = { value = var.vtpm_enabled }
    winrm_listener                           = { value = var.winrm_listener }
    zone                                     = { value = var.zone }
    os_disk_storage_account_type             = { value = var.os_disk.storage_account_type }
    os_disk_name                             = { value = var.os_disk.name }
    os_disk_secure_vm_disk_encryption_set_id = { value = var.os_disk.secure_vm_disk_encryption_set_id }
    os_disk_security_encryption_type         = { value = var.os_disk.security_encryption_type }
    os_disk_diff_disk_settings_option        = { value = var.os_disk.diff_disk_settings != null ? var.os_disk.diff_disk_settings.option : null }
    os_disk_diff_disk_settings_placement     = { value = var.os_disk.diff_disk_settings != null ? var.os_disk.diff_disk_settings.placement : null }
    additional_unattend_content_version      = { value = var.additional_unattend_content_version }
    plan_name                                = { value = var.plan != null ? var.plan.name : null }
    plan_product                             = { value = var.plan != null ? var.plan.product : null }
    plan_publisher                           = { value = var.plan != null ? var.plan.publisher : null }
  }
  sensitive_body = {
    properties = (var.admin_password != null || var.custom_data != null || (var.additional_unattend_content != null && length(var.additional_unattend_content) > 0)) ? {
      osProfile = merge(
        var.admin_password != null ? {
          adminPassword = local.effective_admin_password
        } : {},
        var.custom_data != null ? {
          customData = var.custom_data
        } : {},
        (var.additional_unattend_content != null && length(var.additional_unattend_content) > 0) ? {
          windowsConfiguration = {
            additionalUnattendContent = [
              for item in var.additional_unattend_content : {
                content       = item.content
                settingName   = item.setting
                passName      = "OobeSystem"
                componentName = "Microsoft-Windows-Shell-Setup"
              }
            ]
          }
        } : {}
      )
    } : {}
  }
  sensitive_body_version = {
    "properties.osProfile.adminPassword"                                  = try(tostring(var.admin_password_version), "null")
    "properties.osProfile.customData"                                     = try(tostring(var.custom_data_version), "null")
    "properties.osProfile.windowsConfiguration.additionalUnattendContent" = try(tostring(var.additional_unattend_content_version), "null")
  }
  should_read_existing_admin_password                 = var.admin_password != null
  should_read_existing_availability_set_id            = var.availability_set_id != null
  should_read_existing_capacity_reservation_group_id  = var.capacity_reservation_group_id != null
  should_read_existing_dedicated_host_group_id        = var.dedicated_host_group_id != null
  should_read_existing_dedicated_host_id              = var.dedicated_host_id != null
  should_read_existing_edge_zone                      = var.edge_zone != null
  should_read_existing_os_disk_disk_encryption_set_id = var.os_disk.disk_encryption_set_id != null
  should_read_existing_os_disk_storage_account_type   = var.os_disk.storage_account_type != null
  should_read_existing_proximity_placement_group_id   = var.proximity_placement_group_id != null
  source_image_id_is_community_gallery = var.source_image_id != null ? (
    can(regex("^/communityGalleries/[^/]+/images/[^/]+(/versions/[^/]+)?$", var.source_image_id))
  ) : false
  source_image_id_is_shared_gallery = var.source_image_id != null && !local.source_image_id_is_community_gallery ? (
    can(regex("^/sharedGalleries/[^/]+/images/[^/]+(/versions/[^/]+)?$", var.source_image_id))
  ) : false
  source_image_id_reference = var.source_image_id != null ? (
    local.source_image_id_is_community_gallery ? {
      communityGalleryImageId = var.source_image_id
      } : (
      local.source_image_id_is_shared_gallery ? {
        sharedGalleryImageId = var.source_image_id
        } : {
        id = var.source_image_id
      }
    )
  ) : null
}
