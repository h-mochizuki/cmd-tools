@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo                Wait seconds.
echo ---------------------------------------------
echo  usage:
echo    time_waitsec [option] [seconds]
echo  ex:
echo    time_waitsec 10
echo  options:
echo\   /?: show this usage.
echo  args:
echo    seconds: wait seconds
echo =============================================
exit /b 1
:main
timeout /t %~1 /nobreak