@echo off
setlocal
rem =============================================
rem   swich administraotr role and run command
rem ---------------------------------------------
rem  usage:
rem    sudo [command]
rem =============================================
openfiles >nul 2>&1
if errorlevel 1 (
    powershell Start-Process -verb runAs cmd -ArgumentList '/k ""cd /d %CD%^&%*""'
) else (
    %*
)
