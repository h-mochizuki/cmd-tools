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
for %%i in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do call set "DRIVE_LETTER=%%DRIVE_LETTER:%%i=%%i%%"
set "DRIVE_PATH=%~pf2"
set "TIMESTAMP=%TIME:~0,8%"
set "TIMESTAMP=%DATE:/=%%TIMESTAMP::=%"

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
(
    echo Windows Registry Editor Version 5.00
    echo;
    echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices]
    echo "%DRIVE_LETTER%:"="\\??\\%DRIVE_PATH:\=\\%"
    echo;
)>> !REG_FILE!
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
