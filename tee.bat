@echo off
setlocal
rem =============================================
rem                 generic tee
rem =============================================
set COMMAND=%*
for /f "usebackq tokens=*" %%o in (`findstr .*`) do echo %%o | CScript.exe //NoLogo ~dp03rd-party\tee\Tee.VBS %COMMAND%