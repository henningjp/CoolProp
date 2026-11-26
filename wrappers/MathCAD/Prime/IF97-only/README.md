# IF97-only Mathcad Prime add-in

This folder holds the direct IF97 add-in for Mathcad Prime. It calls the IF97 water and steam formulation directly, without loading CoolProp, so it is the fastest way to get IAPWS-IF97 properties in a worksheet. The source lives in the [CoolProp/IF97](https://github.com/CoolProp/IF97) repository.

Like the CoolProp add-in, it uses SI units: pressure in Pa, energy in J.

## Why use it

**Water and steam matter to the power industry.** Steam cycles, boilers, turbines, condensers, and feedwater systems all run on water properties. The IAPWS-IF97 formulation is the industry standard for them, so power engineers evaluate it constantly, often thousands of times in a single design or simulation worksheet.

**No CoolProp overhead.** The add-in contains only the IF97 formulation. It does not load the CoolProp library, its fluid database, or its backends. `IF97-SI.dll` is about 0.18 MB, compared with about 9.7 MB for `CoolPropMathcadWrapper.dll`, so Mathcad Prime loads much less when it starts. If a worksheet only needs water and steam, this is all that is required. It can also be installed alongside the CoolProp add-in.

**Speed.** A direct call into IF97 is the fastest way to get exact IF97 values into a worksheet. The table shows the time for one sweep of 1,000 temperatures from 273.16 K to 2000 K at 10 MPa, evaluating enthalpy, entropy, density, and speed of sound at each point (4,000 values). Times are the median of five full recalculations in Mathcad Prime 12. The low-level calls create the state once, then use `AS_update` once per point and `AS_get` for each property.

| Route | ms per sweep | vs. direct add-in |
|---|---:|---:|
| Low-level `SVDSBTL&IF97` | 1.6 | 0.94x |
| **Direct IF97 add-in** | **1.7** | **1.0x** |
| Low-level `IF97::Water` | 2.3 | 1.4x |
| Low-level `HEOS` | 7.4 | 4.4x |
| `PropsSI` with `IF97::Water` | 11.9 | 7.0x |
| `PropsSI` with `HEOS` | 220 | 129x |
| `PropsSI` with `SVDSBTL&IF97` | about 4,150 | about 2,400x |

The `SVDSBTL&IF97` low-level route is as fast but is a table interpolation, not the exact formulation, and it has no heat capacity (cp). The `PropsSI` `SVDSBTL&IF97` time was measured on 100 points and scaled to 1,000.

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
