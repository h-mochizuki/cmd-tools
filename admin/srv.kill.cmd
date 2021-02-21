@echo off
setlocal EnableDelayedExpansion
if not "x%~1"=="x/?" goto :main
echo =============================================
echo            Kill service process.
echo ---------------------------------------------
echo  usage:
echo    srv.kill a_service
echo    # abort a_service(pid:123)? [y/N]^> y
echo    # -^> a_service was abort.
echo  args:
echo    1+: service name
echo =============================================
exit /b
:main
if "x%~1"=="x" exit /b
where assert.admin >nul 2>nul
if errorlevel 1 set "PATH=%PATH%;%~dp0;%~dp0..\basic"
where srv.list >nul 2>nul
if errorlevel 1 set "PATH=%PATH%;%~dp0;%~dp0..\basic"
where assert.yn >nul 2>nul
if errorlevel 1 set "PATH=%PATH%;%~dp0;%~dp0..\basic"

call assert.admin
if errorlevel 1 (
    powershell Start-Process -verb runAs cmd -ArgumentList '/c ""cd /d %cd%^&%~f0 %*^&pause""'
    exit /b
)

set "elevel=0"
for /f "usebackq tokens=1,2,3" %%s in (`srv.list %*`) do (
    if "x%%s"=="xSERVICE_NAME:" set "name=%%t"
    if "x%%s"=="xSTATE" set "state=%%t"
    if "x%%s"=="xPID" (
        call :confirm "%%u" "!name!" "!state!"
        if errorlevel 1 set "elevel=1"
    )
)
exit /b !elevel!

:confirm
if "x%~2"=="x" exit /b
if "x%~3"=="xSTOPPED" exit /b
call assert.yn "abort %~2(pid:%~1)?"
if not errorlevel 1 (
    taskkill /pid %~1 /f
    if errorlevel 1 (
        echo Failed to stop "%~2(pid:%~1)".
        exit /b 9
    )
)