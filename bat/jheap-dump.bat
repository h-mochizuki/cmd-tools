@echo off
setlocal
rem =============================================
rem                java GC heap dump
rem =============================================
for %%i in ( . ) do set CURRENT_DIR=%%~pfi
:validate
where jps >nul 2>&1
if errorlevel 1 (
    echo 'jps' is not found.
    exit /b 9
)
where jcmd >nul 2>&1
if errorlevel 1 (
    echo 'jcmd' is not found.
    exit /b 9
)

pushd %~pd0..
for %%i in ( "wk_%DATE:/=%%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%%TIME:~9,2%" ) do (
    mkdir "%%i"
    pushd "%%i"
    call :main "%~1"
    popd
    rmdir /S /Q "%%i"
)
popd
exit /b

:main
@echo off
setlocal EnableDelayedExpansion
set "CNT=0"
for /f "usebackq tokens=1,*" %%a in ( `jps` ) do (
    if /i not "x%%b"=="xJps" (
        echo %%a %%b>>jps.txt
        set /a "CNT=!CNT!+1"
    )
)
if "x!CNT!"=="x0" (
    echo No java proces found.
    exit /b 1
)
echo current java process(es).
echo --------------------------
type jps.txt
echo --------------------------
set "ANSWER="
set /p ANSWER="Generate heap dump? [y/N]> "
if not "x%ANSWER%"=="x" if /i "x%ANSWER:~0,1%"=="xy" goto list
exit /b 1

:list
set "EL="
for /f "tokens=1,*" %%a in ( jps.txt ) do (
    call :exec %%a %%b
    set /a "EL=!EL!+!ERRORLEVEL!"
)
exit /b !EL!

:exec
@echo off
setlocal EnableDelayedExpansion
set PID=%~1
set NAME=%~2
set "ANSWER="
set /p ANSWER="Generate heap dump[pid=!PID!, name=!NAME!]? [y/N]> "
if not "x%ANSWER%"=="x" if /i "x%ANSWER:~0,1%"=="xy" goto dump
exit /b 1

:dump
set "FILENAME=!PID!_!NAME!.hpof"
set "FILENAME=!FILENAME: =!"
jcmd !PID! GC.heap_dump "%CURRENT_DIR%\!FILENAME!"
set EL=%ERRORLEVEL%
if "x%EL%"=="x0" echo =^> "%CURRENT_DIR%\!FILENAME!"
exit /b %EL%
