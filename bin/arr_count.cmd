@echo off
setlocal EnableDelayedExpansion
if not "x%~1"=="x/?" goto :main
echo =============================================
echo          Return array item count.
echo ---------------------------------------------
echo  usage:
echo    arr_count [arguments]...
echo  ex:
echo    arr_count 1 2 3 -^> 3
echo    arr_count -^> 0
echo  args:
echo    1+: arguments
echo =============================================
exit /b 1
:main
set "cnt=0"
for %%i in ( %* ) do set /a "cnt=!cnt!+1"
echo %cnt%