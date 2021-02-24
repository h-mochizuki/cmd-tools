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
call yn "Do you want to reboot your PC?"
if errorlevel 1 exit /b 1
echo Reboot your PC.
echo Please wait a moment.
call time_waitsec 3 >nul
shutdown /r /t 0
