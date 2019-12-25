@echo off
setlocal
rem =============================================
rem              show confirm dialog
rem =============================================
if "x%1"=="x" (
    set MSG=
    for /f "usebackq tokens=*" %%i in (`findstr .*`) do set MSG=!MSG! "%%i"
    CScript.exe //NoLogo %~dp0vbs\msg-confirm.vbs !MSG!
) else (
    CScript.exe //NoLogo %~dp0vbs\msg-confirm.vbs %*
)
