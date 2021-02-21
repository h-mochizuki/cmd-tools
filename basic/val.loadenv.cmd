@echo off
if not "x%~1"=="x/?" goto :main
echo =============================================
echo        Load variables from env file.
echo ---------------------------------------------
echo  usage:
echo    val.loadenv file
echo  args:
echo    1: environment file path
echo =============================================
exit /b
:main
if "x%~1"=="x" exit /b
for /f "eol=# tokens=1,* delims==" %%i in ( %~f1 ) do (
    set "%%i=%%j"
)
