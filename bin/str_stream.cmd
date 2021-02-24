@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo  Echo your input parameters or input-stream.
echo ---------------------------------------------
echo  usage:
echo    str_stream [option] string[...]
echo  ex:
echo    str_stream string -^> string
echo    echo string ^| str_stream -^> string
echo  options:
echo\   /?: show this usage.
echo  args:
echo    string: target string
echo;
echo  caution:
echo    argment is required.
echo    ex) str_stream -^> FREEZE!! WAIT INPUT.
echo =============================================
exit /b 1
:main
if "x%~1"=="x" (
    for /f "usebackq tokens=*" %%i in (`findstr .*`) do echo %%i
) else (
    for %%i in ( %* ) do echo %%i
)