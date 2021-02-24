@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo             Check folder exists.
echo ---------------------------------------------
echo  usage:
echo    dir_exists [option] [folder]
echo  ex:
echo    dir_exists D:\some\folder
echo    if errorlevel 1 echo folder is not exists.
echo  options:
echo\   /?: show this usage.
echo  args:
echo    folder: folder path
echo  retrun code:
echo    0: exists
echo    1: not exists
echo =============================================
exit /b 1
:main
pushd "%~f1" >nul 2>&1
