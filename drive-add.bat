@echo off
setlocal EnableDelayedExpansion
rem =============================================
rem                 add localdrive
rem ---------------------------------------------
rem  usage:
rem    drive-add [path] [drive letter]
rem =============================================
if "x%1"=="x" goto usage
if "x%2"=="x" goto usage
set "DRIVE_PATH=%~pf1"
set "TIMESTAMP=%TIME:~0,8%"
set "TIMESTAMP=%DATE:/=%%TIMESTAMP::=%"
set "TEMPLATE=template\register_drive.reg.template"
pushd %~pd0

if not exist "%DRIVE_PATH%\" (
    echo Folder not found [%DRIVE_PATH%]
    exit /b 1
)
set "DRIVE_LETTER=%2"
set "DRIVE_LETTER=%DRIVE_LETTER:~0,1%"
for /f %%i in ("register_drive_%DRIVE_LETTER%_%TIMESTAMP%.reg") do set "REG_FILE=%%~pfi"

for /f "usebackq tokens=1* delims=:" %%a in (`findstr /n "^" %TEMPLATE%`) do (
    set "line=%%b"
    if "x!line!"=="x" (
        echo;>> !REG_FILE!
    ) else (
        set "line=!line:$DRIVE_LETTER$=%DRIVE_LETTER%!"
        set "line=!line:$DRIVE_PATH$=%DRIVE_PATH:\=\\%!"
        echo !line!>> !REG_FILE!
    )
)
if exist %REG_FILE% (
    regedit /S %REG_FILE%
    set "EL=%ERRORLEVEL%"
    del /Q /F %REG_FILE%
    echo Add %DRIVE_LETTER%-Drive [%DRIVE_PATH%]. Please reboot.
    exit /b %EL%
) else (
    exit /b 99
)

:usage
echo [err]Invalid parameters
echo drive-add [path] [drive letter]
exit /b 1
