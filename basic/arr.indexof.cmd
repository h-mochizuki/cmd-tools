@echo off
setlocal EnableDelayedExpansion
if not "x%~1"=="x/?" goto :main
echo =============================================
echo          Return match item index.
echo ---------------------------------------------
echo  usage:
echo    arr.indexof -^> 0
echo    arr.indexof a -^> 0
echo    arr.indexof a b c -^> 0
echo    arr.indexof a a b c -^> 1
echo    arr.indexof c a b c -^> 3
echo    arr.indexof a a a a -^> 1
echo  args:
echo    1: target item
echo    2+: array
echo =============================================
exit /b
:main
set "cnt=0"
if "x%~1"=="x" echo !cnt!& exit /b 1
set "target=%~1"

call %~dp0path.include
for /f "usebackq tokens=*" %%c in (`arr.remains %*`) do (
    for %%i in ( %%c ) do (
        set /a "cnt=!cnt!+1"
        if "x%target%"=="x%%~i" echo !cnt!& exit /b
    )
)
echo 0
exit /b 1