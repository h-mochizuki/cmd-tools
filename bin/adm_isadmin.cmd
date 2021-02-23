@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo          Check you are administrator.
echo ---------------------------------------------
echo  usage:
echo    adm_isadmin
echo  ex:
echo    adm_isadmin
echo    if not errorlevel 1 echo I'm admin -^> I'm admin
echo  return code:
echo    0: administrator
echo    1: not administrator
echo =============================================
exit /b 1
:main
openfiles >nul 2>&1
exit /b %errorlevel%