@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo            Confirm yes or no.
echo ---------------------------------------------
echo  usage:
echo    assert.yn
echo    # Are you sure? [y/N]^> 1
echo    # if errorlevel 1 echo No! -^> No!
echo  args:
echo    1: confirm message.
echo =============================================
exit /b
:main
set "result="
set "msg=Are you sure?"
if not "x%~1"=="x" set "msg=%~1"
set /p result="%msg% [y/N]> "
if not "x%result%"=="x" if /i "x%result:~0,1%"=="xy" exit /b 0
exit /b 1