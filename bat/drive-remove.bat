@echo off
setlocal EnableDelayedExpansion
rem =============================================
rem               remove localdrive
rem ---------------------------------------------
rem  usage:
rem    drive-remove [drive letter]
rem =============================================
if "x%1"=="x" goto usage
set "DRIVE_LETTER=%1"
set "DRIVE_LETTER=%DRIVE_LETTER:~0,1%"
for %%i in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do call set "DRIVE_LETTER=%%DRIVE_LETTER:%%i=%%i%%"
set "TIMESTAMP=%TIME:~0,8%"
set "TIMESTAMP=%DATE:/=%%TIMESTAMP::=%"

if not exist "%DRIVE_LETTER%:\" (
    echo %DRIVE_LETTER%: drive is not found.
    exit /b 1
)
echo Remove link %DRIVE_LETTER%: =^> "%DRIVE_PATH%"
echo After the work, you need to restart the machine.
set /p ANSWER="Remove %DRIVE_LETTER%: drive? [y/N]> "
if not "x%ANSWER%"=="x" if /i "x%ANSWER:~0,1%"=="xy" goto exec
exit /b 1

:exec
pushd %~pd0..
for /f "usebackq tokens=1,2,* delims= " %%i in ( `reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices" /v "%DRIVE_LETTER%:"` ) do (
    if not "x%%k"=="xDevices" set "DRIVE_DIR=%%k"
    set "DRIVE_DIR=!DRIVE_DIR:~4!"
)
for /f %%i in ("remove_drive_%DRIVE_LETTER%_%TIMESTAMP%.reg") do set "REG_FILE=%%~pfi"
(
    echo Windows Registry Editor Version 5.00
    echo;
    echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices]
    echo "%DRIVE_LETTER%:"=-
    echo;
)>> !REG_FILE!
if exist %REG_FILE% (
    if exist "%DRIVE_LETTER%:\System Volume Information" (
        icacls "%DRIVE_LETTER%:\System Volume Information" /grant %USERNAME%:F
        echo %USERNAME% is granted on full access control: %DRIVE_LETTER%:\System Volume Information
    )
    regedit /S %REG_FILE%
    set "EL=%ERRORLEVEL%"
    del /Q /F %REG_FILE%
    echo Remove %DRIVE_LETTER%-Drive. Please reboot.
    if exist "!DRIVE_DIR!" rd /S /Q "!DRIVE_DIR!"
    exit /b %EL%
) else (
    exit /b 99
)

:usage
echo [err]Invalid parameters
echo drive-remove [drive letter]
exit /b 1
