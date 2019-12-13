@echo off
setlocal
rem =============================================
rem               confirm yes or no?
rem ---------------------------------------------
rem  usage:
rem    yn
rem    # if errorlevel 1 echo Not sure!
rem =============================================
set "MSG=Are you sure?"
if not "x%~1"=="x" set "MSG=%~1"
set /p ANSWER="%MSG% [y/N]> "
if not "x%ANSWER%"=="x" if /i "x%ANSWER:~0,1%"=="xy" exit /b 0
exit /b 1
