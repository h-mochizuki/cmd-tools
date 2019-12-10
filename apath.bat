@echo off
setlocal
rem =============================================
rem                 absolute path
rem ---------------------------------------------
rem  usage:
rem    apath [path]...
rem    echo [path]| apath
rem =============================================
if "x%1"=="x" (
    for /f "usebackq tokens=*" %%i in (`findstr .*`) do echo %%~fi
) else (
    for %%i in ( %* ) do echo %%~fi
)