@echo off
setlocal
rem =============================================
rem                 show msg dialog
rem =============================================
set "MSG=%*"
CScript.exe //NoLogo %~dp0vbs\msg-info.vbs %MSG%
