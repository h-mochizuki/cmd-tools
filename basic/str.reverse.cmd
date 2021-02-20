@echo off
setlocal
if not "x%1"=="x/?" goto :main
echo =============================================
echo               Reverse string
echo ---------------------------------------------
echo  usage:
echo    str.reverse abcd -^> dcba
echo    echo biz^| str.reverse -^> zib
echo  args:
echo    1: input-string or input-stream
echo;
echo  caution: argment is required.
echo    str.reverse -^> FREEZE!! WAIT INPUT.
echo =============================================
exit /b
:main
where str.stream >nul 2>nul
if errorlevel 1 set "PATH=%PATH%;%~dp0"
for /f "usebackq tokens=*" %%i in (`str.stream %*`) do call :rev "%%~i"
exit /b

:rev
set "result="
set "remains=%~1"
:next
if not "x%remains%"=="x" (
    set "result=%remains:~0,1%%result%"
    set "remains=%remains:~1%"
    goto :next
)
echo %result%
