@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo          Check command is available.
echo ---------------------------------------------
echo  usage:
echo    path_available [option] command
echo  ex:
echo    path_available java
echo    if errorlevel 1 echo unavailable -^> unavailable
echo  options:
echo\   /?: show this usage.
echo  args:
echo    command: command that want to use
echo  return code:
echo    0: available
echo    1: unavailable
echo =============================================
exit /b 1
:main
if "x%~1"=="x" exit /b 0
where "%~1" >nul 2>&1
if errorlevel 1 (
    echo '%~1' is unavailable
    exit /b 1
)
exit /b 0