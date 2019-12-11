@echo off
setlocal
rem =============================================
rem                count string length
rem ---------------------------------------------
rem  usage:
rem    strlen [string]
rem    echo [string]| strlen
rem =============================================
if "x%1"=="x" (
    for /f "usebackq tokens=*" %%i in (`findstr .*`) do call :calc "%%i"
) else (
    call :calc "%1"
)
exit /b

:calc
set "STR=%~1"
set CNT=0
:next
if not "x%STR%"=="x" (
    set "STR=%STR:~1%"
    set /a CNT=%CNT%+1
    goto :next
)
echo %CNT%
