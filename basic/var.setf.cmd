@echo off
if not "x%~1"=="x/?" goto :main
echo =============================================
echo         Set result value to variable.
echo ---------------------------------------------
echo  usage:
echo    call var.setf tempfile file.tmp
echo    # echo %%tempfile%% -^> %%temp%%\bat~123.tmp
echo  args:
echo    1: variable name [require]
echo    2+: commands
echo;
echo  caution:
echo    last value is set if multiple results.
echo =============================================
exit /b
:main
if "x%~1"=="x" exit /b
set "%~1="
call %~dp0path.include
for /f "usebackq tokens=*" %%c in (`arr.remains %*`) do (
    for /f "usebackq tokens=*" %%r in (`%%c`) do set "%~1=%%~r"
)
exit /b