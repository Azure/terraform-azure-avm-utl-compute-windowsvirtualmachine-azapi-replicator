# Task #97 - timeouts.create - NOT APPLICABLE

## Summary

Task #97 (timeouts.create) and all related timeouts tasks (#96-100) are **NOT APPLICABLE** for the shadow/replicator module. Timeouts are Terraform provider meta-arguments, not Azure resource properties, and should not be replicated in the migrate_* files.

## Reason for Non-Applicability

According to executor.md line 38 in the "SPECIAL RULES - BLOCKING CONDITIONS" section:

> | Condition | When to Apply | Override Document | 
> |-----------|---------------|-------------------|
> | **Timeouts Block** | Task is for `timeouts`, `timeouts.create`, `timeouts.delete`, `timeouts.read`, or `timeouts.update` | `timeouts.md` |

The rule states:
> **Process:** If condition matches → ❌ **STOP** → ✅ **READ override document COMPLETELY** → ✅ **FOLLOW rules in that document** → ✅ Return here after implementation

Task #97 is for `timeouts.create`, which matches the condition. However, the override document `timeouts.md` does not exist, and further investigation reveals this is intentional.

## Checker Validation from Task #96

The checker agent validated Task #96 (parent timeouts block) and made the following determinations:

1. **Fundamental Nature of Timeouts:** "The `timeouts` block in azapi_resource is NOT a data container - it's a special mechanism used with `dynamic` blocks to force resource recreation when sensitive fields change"

2. **Meta-Arguments vs Resource Properties:** "Timeouts are Terraform meta-arguments, not Azure resource properties" and "should NOT be part of the shadow module's output"

3. **Corrective Action:** The checker removed:
   - `local.timeouts` from `migrate_main.tf`
   - `output "timeouts"` from `migrate_outputs.tf`

4. **Recommendation:** "Mark tasks #96-100 as 'NOT APPLICABLE - Meta-arguments not replicated' in track.md"

## Architectural Understanding

### Main Module vs Shadow Module

1. **Main Module (main.tf):** 
   - Uses `azurerm_windows_virtual_machine` resource
   - Supports native timeouts via `var.timeouts` (lines 159-166)
   - This is correct for the main module

2. **Shadow/Replicator Module (migrate_* files):**
   - Builds configuration for `azapi_resource`
   - Should NOT replicate Terraform meta-arguments
   - Should ONLY replicate Azure API resource properties

### azapi_resource Timeouts Mechanism

From executor.md line 694:
```hcl
resource "azapi_resource" "this" {
  # ... other properties ...
  dynamic "timeouts" { for_each = local.sensitive_body_version; content {} }
}
```

The `timeouts` block in azapi_resource serves a different purpose - it's used as a trigger mechanism for sensitive field changes, NOT for controlling operation durations.

## Why This Task Should Not Exist

1. **Timeouts are meta-arguments:** They control Terraform provider behavior (operation durations), not Azure resource state
2. **Different purpose in azapi_resource:** The azapi provider uses timeouts differently (as a change detection mechanism)
3. **Shadow module scope:** The replicator module's job is to build Azure API request body structure, not Terraform meta-arguments
4. **Direct user control:** Users of azapi_resource set their own timeout values directly on the resource, not via module outputs

## Verification

**Files checked:**
- ✅ `migrate_main.tf`: No timeouts implementation (correctly removed by checker)
- ✅ `migrate_outputs.tf`: No timeouts output (correctly removed by checker)
- ✅ `main.tf`: Contains timeouts for azurerm resource (correct - different context)
- ✅ `variables.tf`: Contains var.timeouts (used by main module, not shadow module)

## Conclusion

**This task is NOT APPLICABLE because:**
1. Timeouts are Terraform provider meta-arguments, not Azure resource properties
2. The shadow module should NOT replicate meta-arguments
3. The azapi_resource provider handles timeouts differently than azurerm provider
4. The checker correctly identified and removed the incorrect implementation from Task #96

**Status:** NOT APPLICABLE - No implementation needed or appropriate

---

## ✅ CHECKER VALIDATION - APPROVED AS NOT APPLICABLE

**Checked by:** Checker Agent
**Date:** 2025-12-24
**Task:** #97 - timeouts.create

### Validation Results

✅ **Architectural Understanding:** Task correctly identified as not applicable for shadow module
✅ **Meta-Arguments Recognition:** Timeouts are meta-arguments, not resource properties
✅ **Implementation State:** No incorrect implementation exists in migrate_* files
✅ **Consistency:** Aligns with Task #96 checker decision
✅ **Documentation:** Proper documentation of why task is not applicable

### Compliance Statement

This task has been correctly identified as NOT APPLICABLE for the shadow/replicator module. Timeouts are Terraform provider meta-arguments that:
1. Control operation durations in the provider SDK layer
2. Are not part of Azure resource API schema
3. Should not be replicated in the shadow module outputs
4. Are handled differently in azapi_resource vs azurerm resources

The absence of implementation in migrate_* files is CORRECT and INTENDED.

**Status:** APPROVED AS NOT APPLICABLE ✅

**Recommendation:** Update track.md to mark tasks #97, #98, #99, and #100 as "NOT APPLICABLE" (Task #96 already has checker approval).

---
