@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo                 Show username.
echo ---------------------------------------------
echo  usage:
echo    username [option]
echo  options:
echo\   /?: show this usage.
echo =============================================
exit /b 1
:main
echo %USERNAME%
exit /b 0