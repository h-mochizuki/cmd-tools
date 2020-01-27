@echo off
setlocal
rem =============================================
rem                 show variable
rem ---------------------------------------------
rem  usage:
rem    env [VAR NAME(PATH default)]
rem =============================================
if /i "x%~1"=="x/?" goto :usage
if /i "x%~1"=="x-?" goto :usage

pushd %~pd0..
for %%i in ( "wk_%DATE:/=%%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%%TIME:~9,2%" ) do (
    mkdir "%%i"
    pushd "%%i"
    call :main %*
    popd
    rmdir /S /Q "%%i"
)
popd
exit /b

:usage
echo management path variables
echo;
echo usage:
echo   ^>env [option] [name]...
echo option:
echo\  /? : show usage
echo args:
echo   name : variable name^(Default 'PATH'^)
exit /b 1

:main
@echo off
setlocal EnableDelayedExpansion
if /i "x%~1"=="x/k" goto :keys
if /i "x%~1"=="x-k" goto :keys
if "x%~1"=="x" (
    call :split "!PATH!"
) else (
    call :split "!%~1!"
)
if exist split.txt type split.txt
exit /b

:keys
for /f "usebackq tokens=1,* delims==" %%a in ( `set` ) do (
    echo %%a>>keys.txt
)
if exist keys.txt type keys.txt
exit /b

:split
if "x%~1"=="x" exit /b
for /f "tokens=1,* delims=;" %%a in ( "%~1" ) do (
    echo %%a>>split.txt
    call :split "%%b"
)
