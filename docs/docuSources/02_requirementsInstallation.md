@page 02_requirementsInstallation Requirements and installation

@section requirementsInstallation-hw Hardware requirements

see WinCC OA online documentation [link](https://www.winccoa.com/documentation/WinCCOA/latest/en_US/GettingStarted/GettingStarted-13_2.html)

@section requirementsInstallation-sw Software requirements

**WinCC OA** latest patch
for basic requirements see WinCC OA online documentation [link](https://www.winccoa.com/documentation/WinCCOA/latest/en_US/GettingStarted/GettingStarted-13_2.html)

**python** must be installed, min. V3.6

@section requirementsInstallation-installation Installation

_currently only manual integration, see steps below_

- Create new WinCC OA Project (With DB)
- Add subproject **_WinCCOA_QualityChecks_**
- Import Dp-List WinCCOA_QualityChecks\dplist\WinCCOA_QualityChecks.dpl
- Re-start your GEdi
- [Optional] Adapt following script to find python executable

WinCCOA_QualityChecks\scripts\libs\classes\QualityGates\Tools\Python\Python.ctl

``` cpp
public static synchronized string getExecutable()
{
  return findExecutable("python");
}
```
