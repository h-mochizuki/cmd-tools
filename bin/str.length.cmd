@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo             Count string length.
echo ---------------------------------------------
echo  usage:
echo    str.length [string]...
echo  ex:
echo    str.length string -^> 6
echo    echo str^| str.length -^> 3
echo  args:
echo    1+: target strings
echo;
echo  caution1: argment is required.
echo    str.length -^> FREEZE!! WAIT INPUT.
echo  caution2: white space is counted.
echo    echo str   ^| str.length -^> 6
echo =============================================
exit /b 1
:main
call %~dp0path_include
for /f "usebackq tokens=*" %%i in (`str.stream %*`) do call :calc "%%~i"
exit /b

:calc
set "str=%~1"
set "cnt=0"
:next
if not "x%str%"=="x" (
    set "str=%str:~1%"
    set /a cnt=%cnt%+1
    goto :next
)
echo %cnt%