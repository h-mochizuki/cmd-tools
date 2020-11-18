@echo off
setlocal
rem =============================================
rem                   show hosts
rem =============================================
set HOSTS_PATH=C:\Windows\System32\drivers\etc\hosts
if "x%~1"=="x-h" goto :help
if "x%~1"=="x-e" goto :edit
type %HOSTS_PATH% | findstr /V /R "#.*$" | findstr /V /R "^$"
exit /b

:edit
echo powershell start-process notepad -ArgumentList '%HOSTS_PATH%' -verb runas
powershell start-process notepad -ArgumentList '%HOSTS_PATH%' -verb runas
exit /b

:help
echo show hosts
echo ^> %~nx0 [option]
echo;
echo option:
echo   -h : show this usage.
echo   -e : edit hosts
exit /b 1

