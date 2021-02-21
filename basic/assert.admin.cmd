@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo          Check you are administrator.
echo ---------------------------------------------
echo  usage:
echo    call assert.admin
echo    # if not errorlevel 1 echo administrator.
echo =============================================
exit /b
:main
openfiles >nul 2>&1
exit /b %errorlevel%