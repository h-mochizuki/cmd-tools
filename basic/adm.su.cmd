@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo          Switch administrator role.
echo ---------------------------------------------
echo  usage:
echo    adm.su
echo;
echo  caution:
echo    open another prompt,
echo    if you are not administrator.
echo =============================================
exit /b
:main
where assert.admin >nul 2>nul
if errorlevel 1 set "PATH=%PATH%;%~dp0"

call assert.admin
if not errorlevel 1 exit /b
powershell Start-Process -verb runAs cmd -ArgumentList '/k ""cd /d %cd%""'
