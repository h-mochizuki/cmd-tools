@echo off
setlocal EnableDelayedExpansion
if not "x%~1"=="x/?" goto :main
echo =============================================
echo           Pad string with padding.
echo ---------------------------------------------
echo  usage:
echo    str_padding [option] string size char
echo  ex:
echo    str_padding abcd 10 * -^> abcd******
echo    str_padding 1234 -10 0 -^> 0000001234
echo  options:
echo\   /?: show this usage.
echo  args:
echo    string: taret string
echo    size  : padding size
echo            (right justified if minus)
echo    char  : padding charactor
echo            (default: whitespace)
echo =============================================
exit /b 1
:main
call %~dp0path_include

set "cnt=0"
set "input=%~1"
for /f "usebackq" %%i in ( `str_length %input%` ) do set "cnt=%%i"
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
