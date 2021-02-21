@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo            Rerun as administrator.
echo ---------------------------------------------
echo  usage:
echo    adm.asadmin "%~f0" %*
echo  args:
echo    1: caller file path
echo    2: original args
echo =============================================
exit /b
:main
if "x%~1"=="x" exit /b
where assert.admin >nul 2>nul
if errorlevel 1 set "PATH=%PATH%;%~dp0"
call assert.admin
if not errorlevel 1 exit /b

where var.setf >nul 2>nul
if errorlevel 1 set "PATH=%PATH%;%~dp0"
where arr.remains >nul 2>nul
if errorlevel 1 set "PATH=%PATH%;%~dp0"
call var.setf args arr.remains %*
powershell Start-Process -verb runAs cmd -ArgumentList '/c ""cd /d %cd% ^& %~f1 %args%""'
exit /b 1
