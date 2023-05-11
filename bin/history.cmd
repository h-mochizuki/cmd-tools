@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo          Show this propmpt history.
echo ---------------------------------------------
echo  usage:
echo    history [option]
echo  options:
echo\   /?: show this usage.
echo =============================================
exit /b 1
:main
doskey /history
exit /b 0