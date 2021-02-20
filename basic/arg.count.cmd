@echo off
setlocal EnableDelayedExpansion
if not "x%1"=="x/?" goto :main
echo =============================================
echo          Return arguments count.
echo ---------------------------------------------
echo  usage:
echo    arg.count 1 2 3 -^> 3
echo    arg.count -^> 0
echo  args:
echo    1+: arguments
echo =============================================
exit /b
:main
set "cnt=0"
for %%i in ( %* ) do set /a "cnt=!cnt!+1"
echo %cnt%