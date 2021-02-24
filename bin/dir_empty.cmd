@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo           Check folder is empty.
echo ---------------------------------------------
echo  usage:
echo    dir_empty [option] folder
echo  ex:
echo    dir_empty %%CD%% ^>nul
echo    if errorlevel 1 echo empty!
echo  options:
echo\   /?: show this usage.
echo    /r: find recursively
echo  args:
echo    folder: folder path
echo  retrun code:
echo    0: empty
echo       or has empty folder if use /r option.
echo    1: not empty
echo =============================================
exit /b 1
:main
set "lavel=:find"
if "x%~1"=="x/r" set "lavel=:findr" & shift
if "x%~1"=="x" (
    call %lavel% .
    if errorlevel 1 exit /b 0
    exit /b 1
)
set "elevel=1"
for %%d in ( %* ) do (
    call %lavel% "%%~fd"
    if errorlevel 1 set "elevel=0"
)
exit /b %elevel%

:find
set "target=%~f1"
if not exist "%target%" exit /b 0
dir /b "%target%" | findstr "^" >nul 2>&1
if errorlevel 1 (
    echo %target%
    exit /b 1
)
exit /b 0

:findr
set "target=%~f1"
if not exist "%target%" exit /b 0
set "err=0"
for /r "%target%" /d %%i in ( . ) do (
    dir /b "%%i" | findstr "^" >nul
    if errorlevel 1 (
        echo %%~fi
        set "err=1"
    )
)
exit /b %err%
