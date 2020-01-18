@echo off
setlocal
rem =============================================
rem                 show variable
rem ---------------------------------------------
rem  usage:
rem    env [VAR NAME(PATH default)]
rem =============================================
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
if "x%~1"=="x" (
    call :split "!PATH!"
) else (
    call :split "!%~1!"
)
if exist split.txt type split.txt
exit /b

:split
if "x%~1"=="x" exit /b
for /f "tokens=1,* delims=;" %%a in ( "%~1" ) do (
    echo %%a>>split.txt
    call :split "%%b"
)
