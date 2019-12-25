@echo off
setlocal EnableDelayedExpansion
rem =============================================
rem                 show msg dialog
rem =============================================
if "x%1"=="x" (
    set MSG=
    for /f "usebackq tokens=*" %%i in (`findstr .*`) do set MSG=!MSG! "%%i"
    CScript.exe //NoLogo %~dp0vbs\msg-info.vbs !MSG!
) else (
    CScript.exe //NoLogo %~dp0vbs\msg-info.vbs %*
)
