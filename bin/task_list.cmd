@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo         Show local or remote processes.
echo ---------------------------------------------
echo  usage:
echo    task_list [option]
echo  ex:
echo    task_list /nh /p 0
echo    # -^> System Idle Process              0 N/A
echo  options:
echo\   /?       : show this usage.
echo    /p [pid] : match pid
echo    /n [name]: image-name contains
echo    /nh      : no header
echo =============================================
exit /b 1
:main
call %~dp0path_include
set "cond="
set "image=  "
call var_getopt /v /p %*
if not "x%_opt_value_%"=="x" set cond=/FI "PID eq %_opt_value_%"
call var_getopt /v /n %*
if not "x%_opt_value_%"=="x" set "image=%_opt_value_%"

call var_getopt /nh %*
if errorlevel 1 (
    echo IMAGE NAME                     PID SERVICE
    echo ========================= ======== ============================================
)

set "elevel=1"
for /f "usebackq tokens=*" %%a in ( `tasklist /SVC /NH %cond%^| findstr /C:"%image%"` ) do (
    echo %%a
)
