@echo off
setlocal
rem =============================================
rem                 absolute path
rem ---------------------------------------------
rem  usage:
rem    apath [path]
rem    echo [path]| apath
rem =============================================
set TPATH=%*
if "x%TPATH%"=="x" (
    for /f "usebackq tokens=*" %%i in (`findstr .*`) do echo %%~fi
) else (
    for /f "usebackq tokens=*" %%i in (`echo %TPATH%`) do echo %%~fi
)