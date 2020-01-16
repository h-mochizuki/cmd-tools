@echo off
setlocal EnableDelayedExpansion
rem =============================================
rem             show file in jar
rem ---------------------------------------------
rem  usage:
rem    cat-jar [jar] [resource-path]...
rem =============================================
if "x%~1"=="x" goto :usage
if /i "x%~1"=="x/?" goto :usage
if /i "x%~1"=="x-?" goto :usage
pushd %~dp0\..
set "EL=1"
for %%i in ( "wk_%DATE:/=%%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%%TIME:~9,2%" ) do (
    mkdir "%%i"
    pushd "%%i"
    call :main %*
    set "EL=%ERRORLEVEL%"
    popd
    rmdir /S /Q "%%i"
)
popd
exit /b !EL!

:usage
echo usage:
echo   ^>cat-jar [jar] [resource-path]...
exit /b 1

:main
set "JAR_PATH=%~1"
shift
if "x!JAR_PATH!"=="x" exit /b
if not exist "!JAR_PATH!" (
    echo Notfound: !JAR_PATH!
    exit /b 1
)
:file
set "RESOURCE_PATH=%~1"
shift
if "x!RESOURCE_PATH!"=="x" exit /b
for %%i in ( "!RESOURCE_PATH!" ) do set "FILE_NAME=%%~nxi"
if "!RESOURCE_PATH!"=="!FILE_NAME!" (
    jar xvf "!JAR_PATH!" "!FILE_NAME!">nul 2>&1
    set "FILE_PATH=!FILE_NAME!"
) else (
    set "DIR_NAME=!RESOURCE_PATH:/%FILE_NAME%=!"
    jar xvf "!JAR_PATH!" "!FILE_NAME!" "!DIR_NAME!">nul 2>&1
    set "FILE_PATH=!DIR_NAME:/=\!\!FILE_NAME!"
)
if exist "!FILE_PATH!" type "!FILE_PATH!"
goto :file
