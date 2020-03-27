@echo off
setlocal
rem =============================================
rem                 start sub prompt
rem ---------------------------------------------
rem  usage:
rem    sub [WorkDir] [WorkName]
rem ---------------------------------------------
rem  Environment WorkDir
rem    WorkDir/
rem       .profile.bat : your preset bat(option)
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
if "x%WORK_DIR%"=="x" set "WORK_DIR=%CD:~1%"
for %%i in ( "%WORK_DIR%" ) do set "WORK_DIR=%%~fi"
if not exist "%WORK_DIR%" echo %1 not found. & exit /b 1
set "WORK_NAME=%~2"
if "x%WORK_NAME%"=="x" for %%i in ( "%WORK_DIR%" ) do set "WORK_NAME=%%~nxi"

pushd %~pd0..
set "EL=0"
set "NOW=%TIME: =0%"
for %%i in ( "wk_%DATE:/=%%NOW:~0,2%%NOW:~3,2%%NOW:~6,2%%NOW:~9,2%" ) do (
    mkdir "%%i"
    pushd "%%i"
    doskey /macros > .macros
    for /f "usebackq tokens=1,* delims==" %%m in ( `doskey /macros` ) do doskey %%m=
    (
        echo color 8E
        echo cd /D "%WORK_DIR%"
        echo title %WORK_NAME%
        echo prompt %WORK_NAME%$G
        echo if exist .profile.bat call .profile.bat
        echo if exist "%WORK_DIR%\.macros" doskey /macrofile="%WORK_DIR%\.macros"
        echo if exist "%WORK_DIR%\.profile" call "%WORK_DIR%\.profile"
    ) > script.bat
    cmd /Q /K script.bat
    for /f "usebackq tokens=1,* delims==" %%m in ( `doskey /macros` ) do doskey %%m=
    if exist .macros doskey /macrofile=.macros
    set "EL=%ERRORLEVEL%"
    prompt %OLD_PROMPT%
    color
    popd
    rmdir /S /Q "%%i"
)
popd
exit /b %EL%
