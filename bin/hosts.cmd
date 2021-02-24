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
echo =============================================
exit /b 1
:main
set "hosts=C:\Windows\System32\drivers\etc\hosts"
type %hosts%| findstr /V /R "#.*$"| findstr /V /R "^$"
exit /b 0