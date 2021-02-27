@echo off
if not "x%~1"=="x/?" goto :main
echo =============================================
echo               Enable cmd-tools
echo ---------------------------------------------
echo  usage:
echo    cmd-tools [option]
echo  options:
echo\   /? : show this usage.
echo    /l : command list
echo =============================================
exit /b 1
:main
call %~dp0bin\path_include
if "x%~1"=="x" (
    echo cmd-tools enabled.
    exit /b
)

setlocal EnableDelayedExpansion
call var_getopt /l %*
if not errorlevel 1 goto :list
exit /b

:list
pushd %~dp0bin
echo command       : description
echo --------------------------------------------------------
for %%b in ( *.cmd ) do call :detail "%%~nb"
exit /b

:detail
set "name=%~1"
set "next="
for /f "tokens=1,* delims= " %%l in ( %name%.cmd ) do (
    if "x!next!"=="x1" (
        call :print "%name%" "%%m"
        exit /b
    )
    echo %%m|findstr /C:"====" >nul 2>&1
    if not errorlevel 1 set "next=1"
)
exit /b

:print
call var_setf name str_padding %~1 14
set "detail=%~2"
echo %name%: %detail%
