@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo                 Show hosts.
echo ---------------------------------------------
echo  usage:
echo    hosts [option]
echo  options:
echo\   /?: show this usage.
echo    /e: edit /etc/hosts
echo =============================================
exit /b 1
:main
set "hosts=C:\Windows\System32\drivers\etc\hosts"
if "x%~1"=="x/e" goto :edit
if "x%~1"=="x-e" goto :edit
type %hosts%| findstr /V /R "#.*$"| findstr /V /R "^$"
exit /b 0

:edit
call %~dp0path_include
call adm_sudo notepad "%hosts%"