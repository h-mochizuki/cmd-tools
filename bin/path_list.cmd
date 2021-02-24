@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo           Show separated PATH list.
echo ---------------------------------------------
echo  usage:
echo    path_list [option]
echo  options:
echo\   /?: show this usage.
echo =============================================
exit /b 1
:main
for /f "usebackq tokens=1,* delims==" %%o in (`path`) do call :print "%%~p"
exit /b

:print
if "x%~1"=="x" exit /b
for /f "tokens=1,* delims=;" %%o in ( "%~1" ) do (
    echo %%~o
    call :print "%%~p"
)
