@echo off
setlocal
rem =============================================
rem   swich administraotr role and run command
rem ---------------------------------------------
rem  usage:
rem    sudo [command]
rem =============================================
set COMMAND=%*
openfiles >nul 2>&1
if not errorlevel 1 goto :admin
powershell Start-Process -verb runAs cmd -ArgumentList '/k ""cd /d %CD%^&%COMMAND%""'
exit /b %errorlevel%

:admin
%COMMAND%
exit /b %errorlevel%
