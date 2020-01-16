@echo off
setlocal
rem =============================================
rem             find empty directories
rem ---------------------------------------------
rem  usage:
rem    empdirs [path]
rem =============================================
if not "x%1"=="x" ( set "CURRENT_DIR=%~fp1" ) else ( set "CURRENT_DIR=%CD%" )
for /r "%CURRENT_DIR%" /d %%i in ( . ) do (
    dir /b "%%i" | findstr "^" >nul
    if errorlevel 1 echo %%~fi
)