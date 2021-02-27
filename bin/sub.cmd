@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo                Start sub prompt.
echo ---------------------------------------------
echo  usage:
echo    sub [option] workdir
echo  options:
echo\   /?: show this usage.
echo    /n: window name.
echo  args:
echo    workdir: working folder path
echo             (current folder if empty)
echo  environment settings:
echo    workdir/
echo      .profile.bat: preset batch file
echo =============================================
exit /b 1
:main
call %~dp0path_include
call var_getopt /v /n %*
if not errorlevel 1 %_opt_shift_%
if not "x%_opt_value_%"=="x" set "workname=%_opt_value_%"

if "x%~1"=="x" (
    for %%i in ( . ) do set "workdir=%%~fi"
) else (
    set "workdir=%~f1"
)
call dir_exists "%workdir%"
if errorlevel 1 (
    if exist "%workdir%" (
        echo cannot create work folder: %workdir%
        exit /b 1
    )
    mkdir "%workdir%"
)

if "x%workname%"=="x" for %%i in ( "%workdir%" ) do set "workname=%%~nxi"
call var_setf tmpdir dir_temp
mkdir "%tmpdir%"
pushd "%tmpdir%"
doskey /macros > .macros
for /f "usebackq tokens=1,* delims==" %%m in ( `doskey /macros` ) do doskey %%m=
(
    echo color 2
    echo cd /D "%workdir%"
    echo title %workname%
    echo prompt %workname%$G
    echo if exist .profile.bat call .profile.bat
    echo if exist "%workdir%\.macros" doskey /macrofile="%workdir%\.macros"
) > script.bat
cmd /Q /K script.bat
for /f "usebackq tokens=1,* delims==" %%m in ( `doskey /macros` ) do doskey %%m=
if exist .macros doskey /macrofile=.macros
color
popd
rd /S /Q "%tmpdir%"
