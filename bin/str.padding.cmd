@echo off
setlocal EnableDelayedExpansion
if not "x%~1"=="x/?" goto :main
echo =============================================
echo           Pad string with padding.
echo ---------------------------------------------
echo  usage:
echo    str.padding [string] [size] [charactor]
echo  ex:
echo    str.padding abcd 10 * -^> abcd******
echo    str.padding 1234 -10 0 -^> 0000001234
echo  args:
echo    1: input-string
echo    2: padding size[right justified if minus]
echo    3: padding charactor[default: whitespace]
echo =============================================
exit /b 1
:main
call %~dp0path.include

set "cnt=0"
set "input=%~1"
for /f "usebackq" %%i in ( `str.length %input%` ) do set "cnt=%%i"
if %cnt% LEQ 0 exit /b

set "right_justified="
set "size=%~2"
if "x%size%"=="x" set "size=%cnt%"
if "x%size:~0,1%"=="x-" (
    set "right_justified=1"
    set "size=!size:~1!"
)
if %size% LEQ 0 set "size=%cnt%"
set /a "to=%size%-%cnt%"

set "padding=%~3"
if "x%padding%"=="x" set "padding= "

set "result="
for /l %%i in (1,1,%to%) do set "result=!result!!padding!"
if "x%right_justified%"=="x" (
    echo !input!!result!
) else (
    echo !result!!input!
)
