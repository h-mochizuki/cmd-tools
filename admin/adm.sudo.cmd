@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo     Execute command as administrator role.
echo ---------------------------------------------
echo  usage:
echo    adm.sudo echo abc -^> abc
echo  args:
echo    1+: commands
echo;
echo  caution:
echo    command execute in another prompt,
echo    if you are not administrator.
echo =============================================
exit /b
:main
where assert.admin >nul 2>nul
if errorlevel 1 set "PATH=%PATH%;%~dp0;%~dp0..\basic"

call assert.admin
if not errorlevel 1 (
    %*
    exit /b %errorlevel%
)
set "command=%*"
set "command=%command:"=\"%"
powershell Start-Process -verb runAs cmd -ArgumentList '/c ""cd /d %cd%^&%command%""'
