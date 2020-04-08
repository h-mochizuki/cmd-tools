@echo off
setlocal
rem =============================================
rem                 run javaws
rem =============================================
if "x%1"=="x" goto :usage
if "x%1"=="x-c" goto :control_panel
if "x%1"=="x/c" goto :control_panel
goto :run_jws

:usage
echo run javaws
echo;
echo usage:
echo   ^>jws [options] [jnlp file]
echo options:
echo   -c : open java control panel
exit /b 1

:control_panel
javacpl >nul 2>&1
if not errorlevel 1 exit /b
for /f "usebackq tokens=*" %%i in ( `where java` ) do set "JAVA_BIN=%%~dpi"
pushd "%JAVA_BIN%"
for %%i in ( "." ) do set "JAVA_HOME=%%~dpi"
if exist "%JAVA_HOME%jre" set "JAVA_HOME=%JAVA_HOME%jre"
pushd "%JAVA_HOME%\bin"
javacpl
exit /b

:run_jws
echo %*|findstr "^-verbose">nul 2>&1
if not errorlevel 1 (
    javaws %*
) else (
    javaws -verbose %*
)
