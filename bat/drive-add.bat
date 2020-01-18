@echo off
setlocal EnableDelayedExpansion
rem =============================================
rem                 add localdrive
rem ---------------------------------------------
rem  usage:
rem    drive-add [drive letter] [path]
rem =============================================
if "x%1"=="x" goto usage
if "x%2"=="x" goto usage
set "ANSWER="
set "DRIVE_LETTER=%1"
set "DRIVE_LETTER=%DRIVE_LETTER:~0,1%"
set "DRIVE_PATH=%~pf2"
set "TIMESTAMP=%TIME:~0,8%"
set "TIMESTAMP=%DATE:/=%%TIMESTAMP::=%"
set "TEMPLATE=template\register_localdrive.reg.template"

if exist "%DRIVE_LETTER%:\" (
    echo %DRIVE_LETTER%: drive has already exists.
    exit /b 1
)
echo Add link %DRIVE_LETTER%: =^> "%DRIVE_PATH%"
echo After the work, you need to restart the machine.
set /p ANSWER="Add %DRIVE_LETTER%: drive? [y/N]> "
if not "x%ANSWER%"=="x" if /i "x%ANSWER:~0,1%"=="xy" goto exec
exit /b 1

:exec
pushd %~pd0..
if not exist "%DRIVE_PATH%\" (
    echo Folder not found [%DRIVE_PATH%]
    exit /b 1
)
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
    echo Linked %DRIVE_LETTER%: =^> "%DRIVE_PATH%"
    echo Please reboot.
    exit /b %EL%
) else (
    exit /b 99
)

:usage
echo [err]Invalid parameters
echo drive-add [drive letter] [path]
exit /b 1
