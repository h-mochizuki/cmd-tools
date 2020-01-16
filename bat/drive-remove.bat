@echo off
setlocal EnableDelayedExpansion
rem =============================================
rem               remove localdrive
rem ---------------------------------------------
rem  usage:
rem    drive-remove [drive letter]
rem =============================================
pushd %~pd0
if "x%1"=="x" goto usage
set "TIMESTAMP=%TIME:~0,8%"
set "TIMESTAMP=%DATE:/=%%TIMESTAMP::=%"
set "TEMPLATE=template\remove_localdrive.reg.template"

set "DRIVE_LETTER=%1"
set "DRIVE_LETTER=%DRIVE_LETTER:~0,1%"
for /f %%i in ("remove_drive_%DRIVE_LETTER%_%TIMESTAMP%.reg") do set "REG_FILE=%%~pfi"

for /f "usebackq tokens=1* delims=:" %%a in (`findstr /n "^" %TEMPLATE%`) do (
    set "line=%%b"
    if "x!line!"=="x" (
        echo;>> !REG_FILE!
    ) else (
        set "line=!line:$DRIVE_LETTER$=%DRIVE_LETTER%!"
        echo !line!>> !REG_FILE!
    )
)
if exist %REG_FILE% (
    if exist "%DRIVE_LETTER%:\System Volume Information" (
        icacls "%DRIVE_LETTER%:\System Volume Information" /grant %USERNAME%:F
        echo %USERNAME% is granted on full access control: %DRIVE_LETTER%:\System Volume Information
    )
    regedit /S %REG_FILE%
    set "EL=%ERRORLEVEL%"
    del /Q /F %REG_FILE%
    echo Remove %DRIVE_LETTER%-Drive. Please reboot.
    exit /b %EL%
) else (
    exit /b 99
)

:usage
echo [err]Invalid parameters
echo drive-remove [drive letter]
exit /b 1