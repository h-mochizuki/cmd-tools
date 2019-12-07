@echo off
setlocal EnableDelayedExpansion
rem =============================================
rem                count words
rem ---------------------------------------------
rem  usage:
rem    wcnt 1 2 3
rem    # 3
rem =============================================
set "CNT=0"
if "x%1"=="x" (
    for /f "usebackq tokens=*" %%i in ( `findstr .*` ) do if not "x%%i" == "x" for %%j in ( %%i ) do set /a "CNT=!CNT!+1"
) else (
    for %%i in ( %* ) do set /a "CNT=!CNT!+1"
)
echo %CNT%
