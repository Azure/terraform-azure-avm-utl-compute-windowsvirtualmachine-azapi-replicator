# Deferred Work Tracking

This file tracks work that has been deferred from one task to another.

| Deferred By | Deferred To | Type | Description | Status |
|-------------|-------------|------|-------------|--------|
| #6 | #7 | Validation | Cross-field validation: admin_password and admin_username must be specified together (RequiredWith) | ✅ Completed |
| #6 | #26 | Validation | Cross-field validation: admin_password cannot be used with os_managed_disk_id (ConflictsWith) | Pending |
| #7 | #26 | Validation | Cross-field validation: admin_username and os_managed_disk_id are mutually exclusive (ExactlyOneOf) | Pending |
| #11 | #26 | Validation | Cross-field validation: bypass_platform_safety_checks_on_user_schedule_enabled cannot be used with os_managed_disk_id (ConflictsWith) | Pending |
| #12 | #32 | Validation | Cross-field validation: proximity_placement_group_id cannot be used together with capacity_reservation_group_id (ConflictsWith) | ✅ Completed |
| #13 | #26 | Validation | Cross-field validation: computer_name cannot be used with os_managed_disk_id (ConflictsWith) | Pending |
| #19 | #26 | Validation | Cross-field validation: enable_automatic_updates cannot be used with os_managed_disk_id (ConflictsWith) | Pending |
| #21 | #30 | Validation | Cross-field validation: eviction_policy can only be set when priority is Spot, and if priority is Spot, eviction_policy must be set | Pending |
| #23 | #26 | Validation | Cross-field validation: hotpatching_enabled cannot be used with os_managed_disk_id (ConflictsWith) - validation code implemented in #23, depends on variable creation in #26 | Pending |
| #23 | #35 | Validation | Image SKU validation: hotpatching_enabled requires source_image_reference to use specific SKUs (2022/2025-datacenter-azure-edition variants) | ✅ Completed by Task #88 |
| #23 | #35 | Validation | Image SKU validation: hotpatching_enabled is not supported when using source_image_id | ✅ Completed |
| #31 | #26 | Validation | Cross-field validation: provision_vm_agent cannot be used together with os_managed_disk_id (ConflictsWith) | Pending |
| #35 | #26 | Validation | Cross-field validation: source_image_id, os_managed_disk_id, and source_image_reference are mutually exclusive (ExactlyOneOf - must specify exactly one) | Pending |
| #35 | #85 | Validation | Cross-field validation: source_image_id, os_managed_disk_id, and source_image_reference are mutually exclusive (ExactlyOneOf - must specify exactly one) | ✅ Deferred to #26 (os_managed_disk_id variable doesn't exist yet) |
| #85 | #26 | Validation | Cross-field validation: source_image_id, os_managed_disk_id, and source_image_reference are mutually exclusive (ExactlyOneOf - must specify exactly one) - deferred because os_managed_disk_id variable doesn't exist yet | Pending |
| #45 | #53 | Validation | Cross-field validation: diff_disk_settings can only be set when caching is set to ReadOnly | ✅ Completed |
| #47 | #50 | Validation | Cross-field validation: os_disk.secure_vm_disk_encryption_set_id cannot be used together with os_disk.disk_encryption_set_id (ConflictsWith - reciprocal validation) | ✅ Completed |
| #50 | #51 | Validation | Cross-field validation: os_disk.secure_vm_disk_encryption_set_id can only be specified when os_disk.security_encryption_type is set to 'DiskWithVMGuestState' | ✅ Completed |
| #64 | #26 | Validation | Cross-field validation: gallery_application cannot be used with os_managed_disk_id (ConflictsWith) | Pending |
| #72 | #73 | Validation | Cross-field validation: identity_ids can only be specified when type is UserAssigned or SystemAssigned, UserAssigned | ✅ Completed |
| #80 | #26 | Validation | Cross-field validation: secret cannot be used with os_managed_disk_id (ConflictsWith) | ✅ Completed |
| #93 | #26 | Validation | Cross-field validation: winrm_listener cannot be used with os_managed_disk_id (ConflictsWith) | Pending |
