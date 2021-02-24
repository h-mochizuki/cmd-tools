@echo off
if not "x%~1"=="x/?" goto :main
echo =============================================
echo         Set result value to variable.
echo ---------------------------------------------
echo  usage:
echo    var_setf [option] name command
echo  ex:
echo    var_setf tempfile file_tmp
echo    echo %%tempfile%% -^> %%temp%%\bat~123.tmp
echo  options:
echo\   /?: show this usage.
echo  args:
echo    name: variable name [require]
echo    command: command that want to evaluate
echo;
echo  caution:
echo    last value is set if multiple results.
echo =============================================
exit /b 1
:main
if "x%~1"=="x" exit /b
call %~dp0path_include

set "%~1="
for /f "usebackq tokens=*" %%c in (`arr_remains %*`) do (
    for /f "usebackq tokens=*" %%r in (`%%c`) do set "%~1=%%~r"
)
exit /b