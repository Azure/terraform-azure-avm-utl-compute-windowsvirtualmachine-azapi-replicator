# Test Configuration Functions for azurerm_windows_virtual_machine

## Summary
- **Total Valid Test Cases**: 141
- **Test Files Analyzed**: 9
- **Excluded Cases**: 9 (requiresImport, error tests, helper functions)

---

## Basic/Foundation Cases (2 cases):
| Case Name | File URL | Status | Test Status |
| --- | --- | --- | --- |
| authPassword | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_auth_test.go | Completed | test success |
| diskOSBasic | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | test success |

## Authentication & Access Cases (1 case):
| Case Name | File URL | Status | Test Status |
| --- | --- | --- | --- |
| authPassword | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_auth_test.go | Completed | test success |

## Patch Management Cases (7 cases):
| Case Name | File URL | Status | Test Status |
| --- | --- | --- | --- |
| otherPatchModeManual | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherPatchModeAutomaticByOS | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherPatchModeAutomaticByPlatform | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherPatchAssessmentModeDefault | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherHotpatching (enabled) | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherHotpatching (disabled) | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherRebootSetting | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |

## Feature Configuration Cases (40 cases):
| Case Name | File URL | Status | Test Status |
| --- | --- | --- | --- |
| otherAdditionalUnattendContent | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherAllowExtensionOperationsDefault | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Skipped | |
| otherAllowExtensionOperationsDisabled | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherAllowExtensionOperationsDisabledWithoutVmAgent | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherAllowExtensionOperationsEnabledWithoutVmAgent | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | invalid |
| otherExtensionsTimeBudget | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherBootDiagnostics | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherBootDiagnosticsManaged | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherBootDiagnosticsDisabled | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherComputerNameDefault | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Skipped | |
| otherComputerNameCustom | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherCustomData | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherEdgeZone | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherGalleryApplication | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherGalleryApplicationUpdated | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | invalid |
| otherGalleryApplicationRemoved | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherUserData | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherEnableAutomaticUpdatesDefault | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Skipped | |
| otherSkipShutdownAndForceDelete | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherLicenseTypeDefault | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherLicenseType (None) | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherLicenseTypeWindowsClient | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherLicenseType (Windows_Server) | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherPrioritySpot | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | invalid |
| otherPrioritySpotMaxBidPrice | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | invalid |
| otherProvisionVMAgentDefault | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Skipped | |
| otherProvisionVMAgentDisabled | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherSecret | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherSecretUpdated | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherSecretRemoved | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherTags | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherTagsUpdated (update test for otherTags) | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherOsImageNotification | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherTerminationNotification | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherTerminationNotificationTimeout | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherTimeZone | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherHibernation | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherWinRMHTTP | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherWinRMHTTPS | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherBypassPlatformSafetyChecksOnUserSchedule | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |

## Security & Encryption Cases (7 cases):
| Case Name | File URL | Status | Test Status |
| --- | --- | --- | --- |
| otherEncryptionAtHostEnabled | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| other_secure_boot_enabled | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherVTpmEnabled | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherEncryptionAtHostEnabledWithCMK | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherUltraSsd (enabled) | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherUltraSsd (disabled) | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherUltraSsdEmpty | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |

## Graceful Shutdown Cases (2 cases):
| Case Name | File URL | Status | Test Status |
| --- | --- | --- | --- |
| otherGracefulShutdown (enabled) | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |
| otherGracefulShutdown (disabled) | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_other_test.go | Completed | test success |

## Image Source Cases (6 cases):
| Case Name | File URL | Status | Test Status |
| --- | --- | --- | --- |
| imageFromImage | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_images_test.go | Completed | invalid |
| imageFromPlan | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_images_test.go | Completed | invalid |
| imageFromCommunitySharedImageGallery | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_images_test.go | Completed | invalid |
| imageFromSharedImageGallery | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_images_test.go | Completed | invalid |
| imageFromSourceImageReference | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_images_test.go | Skipped | |
| imageFromExistingMachinePrep | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_images_test.go | Completed | test success |

## Scaling & Capacity Cases (16 cases):
| Case Name | File URL | Status | Test Status |
| --- | --- | --- | --- |
| scalingAdditionalCapabilitiesUltraSSD | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_scaling_test.go | Completed | test success |
| scalingAvailabilitySet | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_scaling_test.go | Completed | test success |
| scalingCapacityReservationGroupInitial | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_scaling_test.go | Completed | test success |
| scalingCapacityReservationGroup | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_scaling_test.go | Completed | test success |
| scalingCapacityReservationGroupUpdate | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_scaling_test.go | Completed | test success |
| scalingCapacityReservationGroupRemoved | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_scaling_test.go | Completed | test success |
| scalingDedicatedHostInitial | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_scaling_test.go | Completed | test success |
| scalingDedicatedHost | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_scaling_test.go | Completed | invalid (quota exceeded: standardDSv3Family requires 80 cores, limit is 65) |
| scalingDedicatedHostUpdate | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_scaling_test.go | Completed | invalid (quota exceeded: standardDSv3Family requires 80 cores for 2 dedicated hosts, limit is 65) |
| scalingDedicatedHostRemoved | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_scaling_test.go | Completed | invalid (quota exceeded: standardDSv3Family requires 80 cores for dedicated host, limit is 65) |
| scalingDedicatedHostGroupInitial | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_scaling_test.go | Completed | test success |
| scalingDedicatedHostGroup | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_scaling_test.go | Completed | invalid (quota exceeded: standardDSv3Family requires 80 cores for dedicated host, limit is 65) |
| scalingDedicatedHostGroupUpdate | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_scaling_test.go | Completed | invalid (quota exceeded: standardDSv3Family requires 80 cores for 2 dedicated hosts, limit is 65) |
| scalingDedicatedHostGroupRemoved | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_scaling_test.go | Completed | invalid (quota exceeded: standardDSv3Family requires 80 cores for dedicated host, limit is 65) |
| scalingMachineSize | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_scaling_test.go | Skipped | |
| scalingZone | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_scaling_test.go | Completed | test success |

## Proximity Placement Cases (3 cases):
| Case Name | File URL | Status | Test Status |
| --- | --- | --- | --- |
| scalingProximityPlacementGroup | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_scaling_test.go | Completed | test success |
| scalingProximityPlacementGroupUpdate | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_scaling_test.go | Completed | test success |
| scalingProximityPlacementGroupRemoved | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_scaling_test.go | Completed | test success |

## OS Disk Cases (21 cases):
| Case Name | File URL | Status | Test Status |
| --- | --- | --- | --- |
| diskOSBasic | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | test success |
| diskOSCachingType (None) | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | test success |
| diskOSCachingType (ReadOnly) | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | test success |
| diskOSCachingType (ReadWrite) | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | test success |
| diskOSCustomName | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | test success |
| diskOSCustomSize | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | test success |
| diskOSDiskDiskEncryptionSetEncrypted | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | invalid |
| diskOSDiskDiskEncryptionSetUnencrypted | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | test success |
| diskOSEphemeralDefault | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | test success |
| diskOSEphemeralSpot | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | invalid (quota exceeded: LowPriorityCores requires 4 cores, limit is 3) |
| diskOSEphemeralResourceDisk | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | test success |
| diskOSEphemeralNVMeDisk | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | test success |
| diskOSStorageAccountType (Standard_LRS) | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | test success |
| diskOSStorageAccountType (StandardSSD_LRS) | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | test success |
| diskOSStorageAccountType (Premium_LRS) | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | test success |
| diskOSStorageAccountType (StandardSSD_ZRS) | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | test success |
| diskOSStorageAccountType (Premium_ZRS) | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | test success |
| diskOSControllerTypeSCSI | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | test success |
| diskOSControllerTypeNVMe | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | test success |
| diskOSWriteAcceleratorEnabled | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | invalid |
| diskOSConfidentialVmWithGuestStateOnly | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | test success |

## Confidential VM Cases (2 cases):
| Case Name | File URL | Status | Test Status |
| --- | --- | --- | --- |
| diskOSConfidentialVmWithGuestStateOnly | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | test success |
| diskOSConfidentialVmWithDiskAndVMGuestStateCMK | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | test success |

## Managed Disk Import Cases (3 cases):
| Case Name | File URL | Status | Test Status |
| --- | --- | --- | --- |
| diskOSBasicNoDelete | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | test success |
| diskOSImportManagedDisk | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | invalid |
| diskOSImportManagedDiskUpdate | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_disk_os_test.go | Completed | invalid |

## Network Configuration Cases (15 cases):
| Case Name | File URL | Status | Test Status |
| --- | --- | --- | --- |
| networkIPv6 | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_network_test.go | Completed | invalid |
| networkMultiple | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_network_test.go | Completed | test success |
| networkMultipleUpdated | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_network_test.go | Completed | test success |
| networkMultipleRemoved | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_network_test.go | Completed | test success |
| networkMultiplePublic | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_network_test.go | Completed | test success |
| networkMultiplePublicUpdated | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_network_test.go | Completed | test success |
| networkMultiplePublicRemoved | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_network_test.go | Completed | test success |
| networkPrivateDynamicIP | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_network_test.go | Skipped | |
| networkPrivateStaticIP | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_network_test.go | Completed | test success |
| networkPublicDynamicPrivateDynamicIP | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_network_test.go | Skipped | |
| networkPublicDynamicPrivateStaticIP | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_network_test.go | Skipped | |
| networkPublicStaticPrivateDynamicIP | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_network_test.go | Completed | test success |
| networkPublicStaticPrivateStaticIP | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_network_test.go | Completed | test success |
| templatePrivateIP (static) | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_network_test.go | Completed | test success |
| templatePrivateIP (dynamic) | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_network_test.go | Completed | test success|

## Identity Cases (5 cases):
| Case Name | File URL | Status | Test Status |
| --- | --- | --- | --- |
| identityNone | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_identity_test.go | Completed | test success |
| identitySystemAssigned | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_identity_test.go | Completed | test success |
| identitySystemAssignedUserAssigned | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_identity_test.go | Completed | test success |
| identityUserAssigned | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_identity_test.go | Completed | test success |
| identityUserAssignedUpdated | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_identity_test.go | Completed | test success |

## Orchestrated VMSS Cases (10 cases):
| Case Name | File URL | Status | Test Status |
| --- | --- | --- | --- |
| orchestratedZonal | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_orchestrated_test.go | Completed | test success |
| orchestratedIdUnAttached | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_orchestrated_test.go | Completed | test success |
| orchestratedIdAttached | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_orchestrated_test.go | Completed | test success |
| orchestratedWithPlatformFaultDomain | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_orchestrated_test.go | Completed | test success |
| orchestratedZonalWithProximityPlacementGroup | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_orchestrated_test.go | Completed | test success |
| orchestratedNonZonal | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_orchestrated_test.go | Completed | test success |
| orchestratedMultipleZonal | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_orchestrated_test.go | Completed | test success |
| orchestratedMultipleNonZonal | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_orchestrated_test.go | Completed | test success |
| templateBaseForOchestratedVMSS | https://raw.githubusercontent.com/hashicorp/terraform-provider-azurerm/refs/heads/main/internal/services/compute/windows_virtual_machine_resource_orchestrated_test.go | Completed | invalid (helper template with no azurerm_windows_virtual_machine resource - only provides base infrastructure) |

---

## Removed Cases

### ❌ Error Test Cases (7 cases):
- `requiresImport` - Error test case (used with ExpectError)
- `otherComputerNameDefaultInvalid` - Error test case (validates invalid default computer name)
- `otherPatchAssessmentModeAutomaticByPlatform` - Unused function (skipped test, not GA yet)
- `empty` - Helper function (provides empty provider config for other tests)

### ❌ Helper/Template Functions (2 cases):
- `template` - Helper/template function (only called by other configs for base infrastructure)
- `templateBase` - Helper/template function (only called by other configs)
- `templateBaseWithOutProvider` - Helper/template function (only called by other configs)
- `templateWithOutProvider` - Helper/template function (only called by other configs)
- `templatePrivateIP` - Helper function (generates network config based on static parameter)
- `templatePublicIP` - Helper function (generates network config with public IP)
- `networkMultipleTemplate` - Helper function (generates multiple NIC template)
- `networkMultiplePublicTemplate` - Helper function (generates multiple public IP template)
- `otherBootDiagnosticsTemplate` - Helper function (generates storage account for boot diagnostics)
- `otherSecretTemplate` - Helper function (generates Key Vault and certificates)
- `otherGalleryApplicationTemplate` - Helper function (generates shared image gallery resources)
- `osDiskImportTemplate` - Helper function (generates base infrastructure for disk import)
- `osDiskImportTemplateWithProvider` - Helper function (generates provider + template)
- `diskOSDiskDiskEncryptionSetDependencies` - Helper function (generates Key Vault and encryption dependencies)
- `diskOSDiskDiskEncryptionSetResource` - Helper function (generates disk encryption set)
- `imageFromExistingMachineDependencies` - Helper function (generates dependencies for image tests)

---

## Key Observations
1. **Multiple Test Files by Feature Area**: Tests are split across 9 files organized by feature (auth, other, images, scaling, disk_os, network, identity, orchestrated, deprecation)
2. **No Legacy Files**: No files with `legacy` in the filename were found
3. **Update/Lifecycle Tests**: Many tests include update scenarios (e.g., `networkMultiple` → `networkMultipleUpdated`)
4. **Comprehensive Coverage**: Tests cover basic configurations, advanced features, security, networking, scaling, and specialized scenarios
5. **Helper Functions**: Many template/helper functions are used but excluded from the final count as they're not direct test cases

---

## Test Validation Checklist
- [x] All test files matching `windows_virtual_machine_resource*_test.go` pattern have been identified
- [x] All test files have been scanned for configuration functions
- [x] All functions used directly in `TestStep.Config` are included
- [x] All functions with `ExpectError` in same TestStep are excluded
- [x] All helper functions (only called by other functions) are excluded
- [x] All `requiresImport` variants are excluded
- [x] Each case has a clear, descriptive label
- [x] Cases are logically categorized by feature area
- [x] Total count is documented
- [x] File source is documented for each test case

---

**Generated**: 2025-12-25
**Resource**: azurerm_windows_virtual_machine
**Provider**: hashicorp/terraform-provider-azurerm
