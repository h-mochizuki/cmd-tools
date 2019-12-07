@echo off
setlocal
rem =============================================
rem        run cmd as administrator role
rem =============================================
powershell start-process cmd -ArgumentList '/k ""cd /d %CD%""' -verb runas
