@echo off
if not "x%~1"=="x/?" goto :main
echo =============================================
echo        Load variables from env file.
echo ---------------------------------------------
echo  usage:
echo    var_loadenv [env file]
echo  ex:
echo    type some.txt -^> KEY=VALUE
echo    var_loadenv some.txt
echo    echo %%KEY%% ^-> VALUE
echo  args:
echo    1: environment file path
echo =============================================
exit /b 1
:main
if "x%~1"=="x" exit /b
for /f "eol=# tokens=1,* delims==" %%i in ( %~f1 ) do (
    if not "x%%i"=="x" (
        set "%%i=%%j"
        echo "%%i=%%j"
    )
)
