# Script to extract all test cases from test_cases.md

$testCases = @(
    "authPassword",
    "diskOSBasic",
    "otherPatchModeManual",
    "otherPatchModeAutomaticByOS",
    "otherPatchModeAutomaticByPlatform",
    "otherPatchAssessmentModeDefault",
    "otherHotpatching",
    "otherRebootSetting",
    "otherAdditionalUnattendContent",
    "otherAllowExtensionOperationsDefault",
    "otherAllowExtensionOperationsDisabled",
    "otherAllowExtensionOperationsDisabledWithoutVmAgent",
    "otherAllowExtensionOperationsEnabledWithoutVmAgent",
    "otherExtensionsTimeBudget",
    "otherBootDiagnostics",
    "otherBootDiagnosticsManaged",
    "otherBootDiagnosticsDisabled",
    "otherComputerNameDefault",
    "otherComputerNameCustom",
    "otherCustomData",
    "otherEdgeZone",
    "otherGalleryApplication",
    "otherGalleryApplicationUpdated",
    "otherGalleryApplicationRemoved",
    "otherUserData",
    "otherEnableAutomaticUpdatesDefault",
    "otherSkipShutdownAndForceDelete",
    "otherLicenseTypeDefault",
    "otherLicenseType",
    "otherLicenseTypeWindowsClient",
    "otherPrioritySpot",
    "otherPrioritySpotMaxBidPrice",
    "otherProvisionVMAgentDefault",
    "otherProvisionVMAgentDisabled",
    "otherSecret",
    "otherSecretUpdated",
    "otherSecretRemoved",
    "otherTags",
    "otherTagsUpdated",
    "otherOsImageNotification",
    "otherTerminationNotification",
    "otherTerminationNotificationTimeout",
    "otherTimeZone",
    "otherHibernation",
    "otherWinRMHTTP",
    "otherWinRMHTTPS",
    "otherBypassPlatformSafetyChecksOnUserSchedule",
    "otherEncryptionAtHostEnabled",
    "otherSecureBootEnabled",
    "otherVTpmEnabled",
    "otherEncryptionAtHostEnabledWithCMK",
    "otherUltraSsd",
    "otherUltraSsdEmpty",
    "otherGracefulShutdown",
    "imageFromImage",
    "imageFromPlan",
    "imageFromCommunitySharedImageGallery",
    "imageFromSharedImageGallery",
    "imageFromSourceImageReference",
    "imageFromExistingMachinePrep",
    "scalingAdditionalCapabilitiesUltraSSD",
    "scalingAvailabilitySet",
    "scalingCapacityReservationGroupInitial",
    "scalingCapacityReservationGroup",
    "scalingCapacityReservationGroupUpdate",
    "scalingCapacityReservationGroupRemoved",
    "scalingDedicatedHostInitial",
    "scalingDedicatedHost",
    "scalingDedicatedHostUpdate",
    "scalingDedicatedHostRemoved",
    "scalingDedicatedHostGroupInitial",
    "scalingDedicatedHostGroup",
    "scalingDedicatedHostGroupUpdate",
    "scalingDedicatedHostGroupRemoved",
    "scalingMachineSize",
    "scalingZone",
    "scalingProximityPlacementGroup",
    "scalingProximityPlacementGroupUpdate",
    "scalingProximityPlacementGroupRemoved",
    "diskOSCachingType",
    "diskOSCustomName",
    "diskOSCustomSize",
    "diskOSDiskDiskEncryptionSetEncrypted",
    "diskOSDiskDiskEncryptionSetUnencrypted",
    "diskOSEphemeralDefault",
    "diskOSEphemeralSpot",
    "diskOSEphemeralResourceDisk",
    "diskOSEphemeralNVMeDisk",
    "diskOSStorageAccountType",
    "diskOSControllerTypeSCSI",
    "diskOSControllerTypeNVMe",
    "diskOSWriteAcceleratorEnabled",
    "diskOSConfidentialVmWithGuestStateOnly",
    "diskOSConfidentialVmWithDiskAndVMGuestStateCMK",
    "diskOSBasicNoDelete",
    "diskOSImportManagedDisk",
    "diskOSImportManagedDiskUpdate",
    "networkIPv6",
    "networkMultiple",
    "networkMultipleUpdated",
    "networkMultipleRemoved",
    "networkMultiplePublic",
    "networkMultiplePublicUpdated",
    "networkMultiplePublicRemoved",
    "networkPrivateDynamicIP",
    "networkPrivateStaticIP",
    "networkPublicDynamicPrivateDynamicIP",
    "networkPublicDynamicPrivateStaticIP",
    "networkPublicStaticPrivateDynamicIP",
    "networkPublicStaticPrivateStaticIP",
    "templatePrivateIP",
    "identityNone",
    "identitySystemAssigned",
    "identitySystemAssignedUserAssigned",
    "identityUserAssigned",
    "identityUserAssignedUpdated",
    "orchestratedZonal",
    "orchestratedIdUnAttached",
    "orchestratedIdAttached",
    "orchestratedWithPlatformFaultDomain",
    "orchestratedZonalWithProximityPlacementGroup",
    "orchestratedNonZonal",
    "orchestratedMultipleZonal",
    "orchestratedMultipleNonZonal",
    "templateBaseForOchestratedVMSS"
)

$completed = @()
$failed = @()

# Skip already completed ones
$startIndex = 2  # Start from index 2 (0=authPassword, 1=diskOSBasic already done)

Write-Host "Starting test case extraction from index $startIndex..."
Write-Host "Total test cases to process: $($testCases.Count - $startIndex)"
Write-Host ""

for ($i = $startIndex; $i -lt $testCases.Count; $i++) {
    $testCase = $testCases[$i]
    Write-Host "[$($i+1)/$($testCases.Count)] Processing test case: $testCase" -ForegroundColor Cyan
    
    try {
        $output = copilot -p "You are a Test Case Agent. Read 'expand_acc_test.md' and follow ALL instructions sequentially: First complete Part 1 (extract test case) then immediately complete Part 2 (convert to AzAPI module). Extract and convert test case method '$testCase' from the provider test file. The method_name is: $testCase" --allow-all-tools --model claude-sonnet-4.5 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  ✅ Successfully completed: $testCase" -ForegroundColor Green
            $completed += $testCase
        } else {
            Write-Host "  ❌ Failed: $testCase (exit code: $LASTEXITCODE)" -ForegroundColor Red
            $failed += $testCase
        }
    } catch {
        Write-Host "  ❌ Exception processing $testCase : $_" -ForegroundColor Red
        $failed += $testCase
    }
    
    Write-Host ""
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Yellow
Write-Host "Summary:" -ForegroundColor Yellow
Write-Host "  Total processed: $($completed.Count + $failed.Count)" -ForegroundColor White
Write-Host "  Completed: $($completed.Count)" -ForegroundColor Green
Write-Host "  Failed: $($failed.Count)" -ForegroundColor Red
Write-Host "============================================" -ForegroundColor Yellow

if ($failed.Count -gt 0) {
    Write-Host ""
    Write-Host "Failed test cases:" -ForegroundColor Red
    $failed | ForEach-Object { Write-Host "  - $_" -ForegroundColor Red }
}
