@echo off
if not "x%~1"=="x/?" goto :main
echo =============================================
echo        Load variables from env file.
echo ---------------------------------------------
echo  usage:
echo    var.loadenv [file]
echo  args:
echo    1: file path
echo =============================================
exit /b
:main
if "x%~1"=="x" exit /b
for /f "eol=# tokens=1,* delims==" %%i in ( %~f1 ) do (
    if not "x%%i"=="x" (
        set "%%i=%%j"
        echo "%%i=%%j"
    )
)
