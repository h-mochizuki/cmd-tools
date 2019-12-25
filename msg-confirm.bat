@echo off
setlocal
rem =============================================
rem              show confirm dialog
rem =============================================
set "MSG=%*"
CScript.exe //NoLogo %~dp0vbs\msg-confirm.vbs %MSG%
