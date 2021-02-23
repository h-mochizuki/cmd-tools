@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo     Execute command as administrator role.
echo ---------------------------------------------
echo  usage:
echo    adm_sudo [command]
echo  ex:
echo    adm_sudo echo abc -^> abc
echo  args:
echo    1+: commands
echo;
echo  caution1:
echo    command execute in another prompt,
echo    if you are not administrator.
echo  caution2:
echo    have to escape like "^|" or "^&"
echo    if use "|" or "&".
echo    ex) adm_sudo echo abc^^^| findstr a
echo =============================================
exit /b 1
:main
call %~dp0path.include

set "command=%*"
call adm_isadmin
if not errorlevel 1 goto :admin
set "command=%command:&=^&%"
set "command=%command:|=^|%"
set "command=%command:"=\"%"
powershell Start-Process -verb runAs cmd -ArgumentList '/c ""cd /d %cd%^&%command%""'
exit /b

:admin
set "command=%command:`n=&%"
set "command=%command:`l=|%"
%command%
