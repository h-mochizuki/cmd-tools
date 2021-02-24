@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo            Confirm yes or no.
echo ---------------------------------------------
echo  usage:
echo    yn [option] [message]
echo  ex:
echo    yn
echo    # Are you sure? [y/N]^> n
echo    if errorlevel 1 echo No! -^> No!
echo  options:
echo\   /?: show this usage.
echo  args:
echo    message: confirm message
echo  return code:
echo    0: yes
echo    1: no
echo =============================================
exit /b 1
:main
set "result="
set "msg=Are you sure?"
if not "x%~1"=="x" set "msg=%~1"
set /p result="%msg% [y/N]> "
if not "x%result%"=="x" if /i "x%result:~0,1%"=="xy" exit /b 0
exit /b 1