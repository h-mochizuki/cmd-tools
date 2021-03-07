@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo             Show cpu performance.
echo ---------------------------------------------
echo  usage:
echo    adm_show_cpu [option]
echo  options:
echo\   /?: show this usage.
echo;
echo  caution:
echo    open another prompt,
echo    if you are not administrator.
echo =============================================
exit /b 1
:main
call %~dp0path_include
call adm_isadmin
if not errorlevel 1 call :cpu
adm_rerun "%~f0" %*

:cpu
typeperf "\processor(_total)\%% processor time"
