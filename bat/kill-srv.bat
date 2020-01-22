@echo off
setlocal EnableDelayedExpansion
rem =============================================
rem              kill service tasks
rem ---------------------------------------------
rem  usage:
rem    kill-srv [Serice Name]...
rem =============================================
set EL=1
if "x%~1"=="x" (
    echo usage:
    echo   ^> kill-srv [service-name]...
    exit /b 1
)
pushd %~pd0..
for %%i in ( "wk_%DATE:/=%%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%%TIME:~9,2%" ) do (
    mkdir "%%i"
    pushd "%%i"
    call :main %*
    set "EL=!ERRORLEVEL!"
    popd
    rmdir /S /Q "%%i"
)
popd
exit /b !EL!
endlocal

:main
@echo off
setlocal EnableDelayedExpansion
sc query state=all | findstr /B SERVICE_NAME>"origin.txt"
type "origin.txt" | findstr %*>"services.txt"
set "CNT=0"
for /f "usebackq tokens=1,* delims=: " %%a in ( services.txt ) do (
    set "SERVICE_NAME=%%b"
    set /a "CNT=!CNT!+1"
    echo !SERVICE_NAME!| findstr %* >> "match.txt"
)
if not exist "match.txt" (
    echo Service not found : [%*]
    exit /b 1
)
echo ---------------------------------------
type match.txt
echo ---------------------------------------
echo find !CNT! service(s).
set "ANSWER="
set /p ANSWER="Continue? [y/N]> "
if not "x%ANSWER%"=="x" if /i "x%ANSWER:~0,1%"=="xy" goto list
exit /b 1

:list
set EL=0
for /f "usebackq tokens=* delims=" %%j in ( match.txt ) do (
    call :stop "%%j"
    if errorlevel 1 set EL=1
)
exit /b !EL!
endlocal

:stop
@echo off
setlocal EnableDelayedExpansion
set "SERVICE_NAME=%~1"
set "STATE="
set "PID="
set "ANSWER="

set /p ANSWER="Kill '!SERVICE_NAME!'? [y/N]> "
if "x!ANSWER!"=="x" exit /b 1
if /i not "x!ANSWER:~0,1!"=="xy" exit /b 1

for /f "usebackq tokens=1,* delims=: " %%a in ( `sc queryex !SERVICE_NAME!` ) do (
    set "PNAME=%%a"
    set "PVALUE=%%b"
    if not "x!PNAME!"=="x" set "PNAME=!PNAME: =!"
    if "x!PNAME!"=="xSTATE" for %%c in ( !PVALUE! ) do set "STATE=%%c"
    if "x!PNAME!"=="xPID" set "PID=!PVALUE!"
)
if "x!STATE!"=="xSTOPPED" (
    echo !SERVICE_NAME! is not starting.
) else (
    taskkill /pid !PID! /f
    if errorlevel 1 (
        echo Failed to stop '!SERVICE_NAME!'.
        echo Please reboot machine.
        exit /b 9
    )
)
endlocal
