@echo off
setlocal EnableDelayedExpansion
if not "x%~1"=="x/?" goto :main
echo =============================================
echo          Return match item index.
echo ---------------------------------------------
echo  usage:
echo    arr_indexof [option] target [item...]
echo  ex:
echo    arr_indexof -^> 0
echo    arr_indexof a -^> 0
echo    arr_indexof a b c -^> 0
echo    arr_indexof a a b c -^> 1
echo    arr_indexof c a b c -^> 3
echo    arr_indexof a a a a -^> 1
echo  options:
echo\   /?: show this usage.
echo  args:
echo    target: target item
echo    item  : array items
echo =============================================
exit /b 1
:main
set "cnt=0"
if "x%~1"=="x" echo !cnt!& exit /b 1
set "target=%~1"

call %~dp0path_include
for /f "usebackq tokens=*" %%c in (`arr_remains %*`) do (
    for %%i in ( %%c ) do (
        set /a "cnt=!cnt!+1"
        if "x%target%"=="x%%~i" echo !cnt!& exit /b
    )
)
echo 0
exit /b 1