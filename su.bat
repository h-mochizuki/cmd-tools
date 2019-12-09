@echo off
setlocal
rem =============================================
rem        swhich administrator role
rem =============================================
openfiles >nul 2>&1
if errorlevel 1 powershell start-process cmd -ArgumentList '/k ""cd /d %CD%""' -verb runas
