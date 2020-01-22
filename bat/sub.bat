@echo off
setlocal
rem =============================================
rem                 start sub prompt
rem ---------------------------------------------
rem  usage:
rem    sub [WorkDir] [WorkName]
rem =============================================
if /i "x%~1"=="x/?" goto :usage
if /i "x%~1"=="x-?" goto :usage
goto :main

:usage
echo usage:
echo   ^>sub [option] [WorkDir] [WorkName]
echo option:
echo\  /?        : show this usage
echo args:
echo   WorkDir  : sub-prompt work directory
echo   WorkName : sub-prompt display name
exit /b 1

:main
set "BASE_DIR=%CD%"
set "OLD_PROMPT=%PROMPT%"
set "WORK_DIR=%~1"
if "x%WORK_DIR%"=="x" set "WORK_DIR=%CD%"
if "x%WORK_DIR%"=="x" for %%i in ( "%WORK_DIR%" ) do set "WORK_DIR=%%~dpi"
if not exist "%WORK_DIR%" echo %1 not found. & exit /b 1
set "WORK_NAME=%~2"
if "x%WORK_NAME%"=="x" for %%i in ( "%WORK_DIR%" ) do set "WORK_NAME=%%~nxi"

pushd %~pd0..
set "EL=0"
for %%i in ( "wk_%DATE:/=%%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%%TIME:~9,2%" ) do (
    mkdir "%%i"
    pushd "%%i"
    (
        echo cd /D "%WORK_DIR%"
        echo title %WORK_NAME%
        echo prompt %WORK_NAME%$G
    ) > script.bat
    cmd /Q /K script.bat
    set "EL=%ERRORLEVEL%"
    prompt %OLD_PROMPT%
    popd
    rmdir /S /Q "%%i"
)
popd
exit /b %EL%
