@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo      Check option exists in arguments.
echo ---------------------------------------------
echo  usage:
echo    for /f "usebackq tokens=*" %%%%s in (`var.hasopt /v %%*`) do (
echo      set "opt=true"
echo      rem args index shift
echo      %%%%s
echo    )
echo  args:
echo    1: option
echo    2+: arguments
echo =============================================
exit /b
:main
if "x%~1"=="x" exit /b 1
set "opt=%~1"
set "cnt=0"

:next
shift
set /a "cnt=%cnt%+1"
if "x%~1"=="x" exit /b 1
if "x%~1"=="x%opt%" echo shift /%cnt%& exit /b 0
goto :next
