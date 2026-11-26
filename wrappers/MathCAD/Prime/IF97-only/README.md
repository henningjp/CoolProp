# IF97-only Mathcad Prime add-in

This folder holds the direct IF97 add-in for Mathcad Prime. It calls the IF97 water and steam formulation directly, without loading CoolProp, so it is the fastest way to get IAPWS-IF97 properties in a worksheet. The source lives in the [CoolProp/IF97](https://github.com/CoolProp/IF97) repository.

## What is in the folder

| File | Purpose |
|---|---|
| `IF97-SI.dll` | Add-in with SI units: pressure in Pa, energy in J |
| `IF97-IAPWS.dll` | Add-in with IAPWS units: pressure in MPa, energy in kJ |
| `if97_Units_SI.mcdx` | Include worksheet with unit-aware wrapper functions for `IF97-SI.dll` |
| `if97_Units_IAPWS.mcdx` | Include worksheet with unit-aware wrapper functions for `IF97-IAPWS.dll` |

## Install exactly one DLL

**Never install both DLLs at the same time.** They define the same `if97_` functions, and Mathcad cannot tell them apart, which causes function conflicts. (The `if97_` prefix is there so these functions do not clash with other add-ins.)

1. Pick one DLL. Use `IF97-SI.dll` unless the worksheet needs MPa and kJ to compare against IAPWS tables.
2. Copy it into the `Custom Functions` folder of the Mathcad Prime install, for example `C:\Program Files\PTC\Mathcad Prime 12.0.0.0\Custom Functions`.
3. Restart Mathcad Prime.
4. Include the matching units worksheet (`if97_Units_SI.mcdx` for `IF97-SI.dll`, `if97_Units_IAPWS.mcdx` for `IF97-IAPWS.dll`) in any worksheet that uses the wrapper functions. The wrong pairing gives wrong numbers, with no error.

To switch units, remove the installed DLL from `Custom Functions`, copy in the other one, and restart Mathcad Prime.

## Check which DLL is loaded

Both include worksheets show the add-in version near the top, with the call `if97_getvers(0)`:

* `IF97-SI.dll` returns the plain version string, for example `"v2.2.0"`.
* `IF97-IAPWS.dll` adds a suffix, for example `"v2.2.0 (IAPWS Units)"`.

If a worksheet shows the wrong one, the wrong DLL is installed.
