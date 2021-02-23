@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo                Wait seconds.
echo ---------------------------------------------
echo  usage:
echo    time.waitsec [seconds]
echo  ex:
echo    time.waitsec 10
echo  args:
echo    1: seconds
echo =============================================
exit /b 1
:main
timeout /t %~1 /nobreak