# IF97-only Mathcad Prime add-in

This folder holds the direct IF97 add-in for Mathcad Prime. It calls the IF97 water and steam formulation directly, without loading CoolProp, so it is the fastest way to get IAPWS-IF97 properties in a worksheet. The source lives in the [CoolProp/IF97](https://github.com/CoolProp/IF97) repository.

Like the CoolProp add-in, it uses SI units: pressure in Pa, energy in J.

## What is in the folder

| File | Purpose |
|---|---|
| `IF97-SI.dll` | The add-in |
| `if97_Units_SI.mcdx` | Include worksheet with unit-aware wrapper functions for `IF97-SI.dll` |

## Install

1. Copy `IF97-SI.dll` into the `Custom Functions` folder of the Mathcad Prime install, for example `C:\Program Files\PTC\Mathcad Prime 12.0.0.0\Custom Functions`.
2. Restart Mathcad Prime.
3. Include `if97_Units_SI.mcdx` in any worksheet that uses the wrapper functions.

All function names begin with `if97_`, so they do not clash with other add-ins.

## IAPWS units (MPa, kJ)

A variant with pressure in MPa and energy in kJ, for easy comparison with IAPWS tables, can be built from the [CoolProp/IF97](https://github.com/CoolProp/IF97) repository with the `IF97_IAPWS_UNITS` CMake option. It is not shipped here. Its functions have the same names, so never install it together with `IF97-SI.dll`.

## Check which DLL is loaded

The call `if97_getvers(0)` returns the add-in version, for example `"v2.4.0"`. The IAPWS-units variant adds a suffix: `"v2.4.0 (IAPWS Units)"`.
