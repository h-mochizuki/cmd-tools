@echo off
setlocal EnableDelayedExpansion
rem =============================================
rem               Reverse string
rem ---------------------------------------------
rem  usage:
rem    reverse hoge
rem    # egoh
rem =============================================
if "x%~1"=="x" (
    for /f "usebackq tokens=*" %%i in (`findstr .*`) do call :rev "%%~i"
) else (
    call :rev "%~1"
)
exit /b

:rev
set "RE="
set "STR=%~1"
:next
if not "x%STR%"=="x" (
    set "RE=%STR:~0,1%%RE%"
    set "STR=%STR:~1%"
    goto :next
)
echo %RE%
