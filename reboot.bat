@echo off
setlocal
rem =============================================
rem               reboot your machine
rem ---------------------------------------------
rem  usage:
rem    reboot
rem =============================================
set /p ANSWER="Reboot? [y/N]> "
if not "x%ANSWER%"=="x" if /i "x%ANSWER:~0,1%"=="xy" goto exec
exit /b 1

:exec
shutdown /r /t 0