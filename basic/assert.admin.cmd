@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo          Check you are administrator.
echo ---------------------------------------------
echo  usage:
echo    assert.admin
echo  ex:
echo    call assert.admin
echo    if not errorlevel 1 echo I'm admin -^> I'm admin
echo  return code:
echo    0: administrator
echo    1: not administrator
echo =============================================
exit /b
:main
openfiles >nul 2>&1
exit /b %errorlevel%