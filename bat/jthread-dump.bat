@echo off
setlocal
rem =============================================
rem                java thread dump
rem =============================================
for %%i in ( . ) do set CURRENT_DIR=%%~pfi
for /f "usebackq" %%i in ( `timestamp` ) do set TS=%%i
set "MYPID=%~1"
:validate
where jps >nul 2>&1
if errorlevel 1 (
    echo 'jps' is not found.
    exit /b 9
)
where jstack >nul 2>&1
if errorlevel 1 (
    echo 'jstack' is not found.
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
for /f "usebackq tokens=1,*" %%a in ( `jps -m` ) do (
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
set /p ANSWER="Generate thread dump? [y/N]> "
if not "x%ANSWER%"=="x" if /i "x%ANSWER:~0,1%"=="xy" goto each
exit /b 1

:each
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
if "x%MYPID%"=="x!PID!" (
    goto dump
) else if "x%MYPID%"=="x" (
    set "ANSWER="
    set /p ANSWER="Generate thread dump[pid=!PID!, name=!NAME!]? [y/N]> "
    if not "x%ANSWER%"=="x" if /i "x%ANSWER:~0,1%"=="xy" goto dump
)
exit /b 1

:dump
set "FILENAME=!PID!_!NAME!_dump_%TS%.log"
set "FILENAME=!FILENAME: =!"
jstack -l !PID! >> "%CURRENT_DIR%\!FILENAME!"
set EL=%ERRORLEVEL%
if "x%EL%"=="x0" echo =^> "%CURRENT_DIR%\!FILENAME!"
exit /b %EL%
