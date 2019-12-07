@echo off
setlocal
rem =============================================
rem                   show hosts
rem =============================================
set HOSTS_PATH=C:\Windows\System32\drivers\etc\hosts
type %HOSTS_PATH% | findstr /V /R "#.*$" | findstr /V /R "^$"
