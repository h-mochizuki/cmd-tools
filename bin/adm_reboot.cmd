@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo               Reboot machine.
echo ---------------------------------------------
echo  usage:
echo    adm_reboot
echo =============================================
exit /b 1
:main
call %~dp0path_include
call yn "Reboot?"
if errorlevel 1 exit /b 1
shutdown /r /t 0
