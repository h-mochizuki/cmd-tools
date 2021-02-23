@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo  Echo your input parameters or input-stream.
echo ---------------------------------------------
echo  usage:
echo    str.stream [string]...
echo  ex:
echo    str.stream string -^> string
echo    echo string ^| str.stream -^> string
echo  args:
echo    1+: target strings
echo;
echo  caution: argment is required.
echo    str.stream -^> FREEZE!! WAIT INPUT.
echo =============================================
exit /b 1
:main
if "x%~1"=="x" (
    for /f "usebackq tokens=*" %%i in (`findstr .*`) do echo %%i
) else (
    for %%i in ( %* ) do echo %%i
)