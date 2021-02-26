@echo off
setlocal EnableDelayedExpansion
if not "x%~1"=="x/?" goto :main
echo =============================================
echo          Return first N charactors.
echo ---------------------------------------------
echo  usage:
echo    str_take [option] max string[...]
echo  ex:
echo    str_take 3 string -^> str
echo  options:
echo\   /?: show this usage.
echo  args:
echo    max   : max length
echo    string: target string
echo;
echo  caution:
echo    argment is required.
echo    ex) str_take -^> FREEZE!! WAIT INPUT.
echo =============================================
exit /b 1
:main
if "x%~1"=="x" exit /b
set "max=%~1"
call %~dp0path_include
call var_setf remains arr_remains %*
if "x%~2"=="x" (
    for /f "usebackq tokens=*" %%i in (`findstr .*`) do call :take "%%i"
) else (
    for %%i in ( %remains% ) do call :take "%%i"
)
exit /b

:take
set "arg=%~1"
echo !arg:~,%max%!
