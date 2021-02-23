@echo off
if not "x%~1"=="x/?" goto :main
echo =============================================
echo          Append folder path to PATH.
echo ---------------------------------------------
echo  usage:
echo    path_include [folder or file]
echo  ex:
echo    path_include "C:\path\to\folder"
echo  args:
echo    1: folder or file path [set %~dp0 if empty]
echo =============================================
exit /b 1
:main
pushd %~dp0
if "x%~1"=="x" (
    path | findstr /C:"%CD%;" >nul 2>&1
    if errorlevel 1 (
        path | findstr /E /C:"%CD%" >nul 2>&1
        if errorlevel 1 set "PATH=%PATH%;%CD%"
    )
) else (
    path | findstr /C:"%~f1;" >nul 2>&1
    if errorlevel 1 (
        path | findstr /E /C:"%~f1" >nul 2>&1
        if errorlevel 1 set "PATH=%PATH%;%~f1"
    )
)
popd
