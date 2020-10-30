@echo off
setlocal EnableDelayedExpansion
rem =============================================
rem                 run javaws
rem =============================================
if "x%1"=="x" goto :usage
if "x%JAVA_HOME%"=="x" (
    where java >nul 2>&1
    if errorlevel 1 echo Java is not installed >&2 & exit /b 1
    for /f "usebackq tokens=*" %%i in ( `where java` ) do set "JAVA_BIN=%%~dpi"
    for %%i in ( "!JAVA_BIN!." ) do set "JAVA_HOME=%%~dpi"
    set JAVA_HOME=!JAVA_HOME:~0,-1!
)
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
if exist "%JAVA_HOME%\jre" set "JAVA_HOME=%JAVA_HOME%\jre"
"%JAVA_HOME%\bin\javacpl"
exit /b

:run_jws
set JAVAWS_TRACE_NATIVE=1
set JAVA_TOOL_OPTIONS=-agentlib:jdwp=transport=dt_socket,address=12345,server=y,suspend=n %JAVA_TOOL_OPTIONS%
echo %*|findstr "^-verbose">nul 2>&1
if not errorlevel 1 (
    "%JAVA_HOME%\bin\javaws" %*
) else (
    "%JAVA_HOME%\bin\javaws" -verbose %*
)
