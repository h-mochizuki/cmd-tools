@echo off
setlocal
rem =============================================
rem             check administrator role
rem ---------------------------------------------
rem  usage:
rem    is-admin
rem    # true or false
rem =============================================
openfiles >nul 2>&1
if errorlevel 1 (
    echo false
    exit /b 1
) else (
    echo true
)
