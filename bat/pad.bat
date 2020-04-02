@echo off
setlocal EnableDelayedExpansion
rem =============================================
rem         Pad the String with the spaces
rem ---------------------------------------------
rem  usage:
rem    pad 1234 10
rem    # 0000001234
rem    pad hoge -10 *
rem    # hoge******
rem =============================================

set "WC=0"
set WD=%~1
for /f "usebackq" %%i in ( `strlen %WD%` ) do set "WC=%%i"
if %WC% LEQ 0 exit /b

set "REV="
set SIZE=%~2
if "x%SIZE%"=="x" set "SIZE=%WC%"
if "x%SIZE:~0,1%"=="x-" (
    set "REV=1"
    set "SIZE=!SIZE:~1!"
)
if %SIZE% LEQ 0 set "SIZE=%WC%"
set /a "TO=%SIZE%-%WC%"

set FC=%~3
if "x%FC%"=="x" set "FC= "

set "RE="
for /l %%i in (1,1,%TO%) do set "RE=!RE!!FC!"
if "x%REV%"=="x" (
    echo !RE!!WD!
) else (
    echo !WD!!RE!
)
