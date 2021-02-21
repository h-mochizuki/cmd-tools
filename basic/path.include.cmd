@echo off
if not "x%~1"=="x/?" goto :main
echo =============================================
echo          Append folder path to PATH.
echo ---------------------------------------------
echo  usage:
echo    call path.include "C:\path\to\folder"
echo  args:
echo    1: folder path [set %~dp0 if empty]
echo =============================================
exit /b
:main
if "x%~1"=="x" (
    pushd %~dp0
    path | findstr /C:"%CD%;" >nul 2>&1
    if errorlevel 1 (
        path | findstr /E /C:"%CD%" >nul 2>&1
        if errorlevel 1 set "PATH=%PATH%;%CD%"
    )
    popd
) else (
    path | findstr /C:"%~f1;" >nul 2>&1
    if errorlevel 1 (
        path | findstr /E /C:"%~f1" >nul 2>&1
        if errorlevel 1 set "PATH=%PATH%;%~f1"
    )
)
