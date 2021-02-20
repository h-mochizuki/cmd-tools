@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo          Check you are administrator.
echo ---------------------------------------------
echo  usage:
echo    assert.admin
echo    # if errorlevel 1 echo not administrator
echo =============================================
exit /b
:main
openfiles >nul 2>&1
