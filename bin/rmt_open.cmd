@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo             Open remote desktop.
echo ---------------------------------------------
echo  usage:
echo    rmt_open hostname [option]
echo  options:
echo\   /?: show this usage.
echo    /u: username
echo    /p: password
echo  args:
echo    hostname: target hostname/ip-address
echo =============================================
exit /b 1
:main
call var_getopt /v /u %*
if not errorlevel 1 (
    %_opt_shift_%
    if not "x%_opt_value_%"=="x" set "username=%_opt_value_%"
)
call var_getopt /v /p %*
if not errorlevel 1 (
    %_opt_shift_%
    if not "x%_opt_value_%"=="x" set "password=%_opt_value_%"
)

if "x%~1"=="x" (
    echo hostname is required.>&2
    echo $ %~0 hostname [options]>&2
    exit /b 9
) else (
    set "server=%~1"
)
if not "x%username%%password%"=="x" (
    cmdkey /generic:TERMSRV/%server% /user:%USERNAME% /pass:%PASSWORD%
)
start /wait mstsc /v:%server%
if not "x%username%%password%"=="x" (
    cmdkey /delete:TERMSRV/%server%
)
