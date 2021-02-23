@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo            Rerun as administrator.
echo ---------------------------------------------
echo  usage:
echo    adm.asadmin [caller] [arguments]...
echo  ex:
echo    adm.asadmin "%~f0" %*
echo  args:
echo    1: caller file path
echo    2: original arguments
echo;
echo  caution:
echo    open another prompt,
echo    if you are not administrator.
echo =============================================
exit /b 1
:main
if "x%~1"=="x" exit /b
call %~dp0path.include
call adm.isadmin
if not errorlevel 1 exit /b

call var.setf args arr.remains %*
powershell Start-Process -verb runAs cmd -ArgumentList '/c ""cd /d %cd% ^& %~f1 %args%""'
exit /b 1
