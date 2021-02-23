@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo          Show this propmpt history.
echo ---------------------------------------------
echo  usage:
echo    history
echo =============================================
exit /b 1
:main
doskey /history
exit 0