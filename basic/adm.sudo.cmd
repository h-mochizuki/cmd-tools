@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo     Execute command as administrator role.
echo ---------------------------------------------
echo  usage:
echo    adm.sudo [command]
echo  ex:
echo    adm.sudo echo abc -^> abc
echo  args:
echo    1+: commands
echo;
echo  caution1:
echo    command execute in another prompt,
echo    if you are not administrator.
echo  caution2:
echo    "`l" use instead of pipe.
echo    adm.sudo echo abc `l findstr a
echo  caution3:
echo    "`n" use instead of line feed.
echo    adm.sudo echo abc `n pause
echo =============================================
exit /b 1
:main
call %~dp0path.include

set "command=%*"
call assert.admin
if not errorlevel 1 goto :admin
set "command=%command:`n=^&%"
set "command=%command:`l=^|%"
set "command=%command:"=\"%"
powershell Start-Process -verb runAs cmd -ArgumentList '/c ""cd /d %cd%^&%command%""'
exit /b

:admin
set "command=%command:`n=&%"
set "command=%command:`l=|%"
%command%
