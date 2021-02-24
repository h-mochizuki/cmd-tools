@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo             Trim last whitespace.
echo ---------------------------------------------
echo  usage:
echo    str_trim [option] string
echo  ex:
echo    echo string ^| str_trim -^> string
echo  options:
echo\   /?: show this usage.
echo  args:
echo    string: target string
echo;
echo  caution:
echo    argment is required.
echo    ex) str_trim -^> FREEZE!! WAIT INPUT.
echo =============================================
exit /b 1
:main
if "x%~1"=="x" (
    for /f "usebackq tokens=*" %%i in (`findstr .*`) do call :trim %%i
) else (
    call :trim %*
)
exit /b

:trim
echo %*