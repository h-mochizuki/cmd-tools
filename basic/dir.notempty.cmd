@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo           Check folder is not empty.
echo ---------------------------------------------
echo  usage:
echo    dir.notempty [option] [folder]
echo  ex:
echo    dir.notempty %%CD%% ^>nul
echo    if not errorlevel 1 echo empty!
echo  option:
echo    /r: find recursively
echo  args:
echo    1: folder path
echo =============================================
exit /b 1
:main
set "lavel=:find"
if "x%~1"=="x/r" set "lavel=:findr" & shift
if "x%~1"=="x" (
    call %lavel% .
    if errorlevel 1 exit /b 1
)
set "elevel=0"
for %%d in ( %* ) do (
    call %lavel% "%%~fd"
    if errorlevel 1 set "elevel=1"
)
exit /b %elevel%

:find
set "target=%~f1"
if not exist "%target%" exit /b 1
dir /b "%target%" | findstr "^" >nul 2>&1
if errorlevel 1 echo %target% & exit /b 1
exit /b

:findr
set "target=%~f1"
if not exist "%target%" exit /b 1
set "err="
for /r "%target%" /d %%i in ( . ) do (
    dir /b "%%i" | findstr "^" >nul
    if errorlevel 1 (
        set "err=1"
        echo %%~fi
    )
)
exit /b %err%
