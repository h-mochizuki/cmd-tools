@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo                Wait seconds.
echo ---------------------------------------------
echo  usage:
echo    time_waitsec [seconds]
echo  ex:
echo    time_waitsec 10
echo  args:
echo    1: seconds
echo =============================================
exit /b 1
:main
timeout /t %~1 /nobreak