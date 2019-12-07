@echo off
setlocal
rem =============================================
rem          swich user and run command
rem ---------------------------------------------
rem  usage:
rem    sudo [command]
rem =============================================
set COMMAND=%*
powershell Start-Process -verb runAs cmd -ArgumentList '/k ""cd /d %CD%^&%COMMAND%""'