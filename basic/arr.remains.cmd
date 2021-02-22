@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo   Return arguments without first argument.
echo ---------------------------------------------
echo  usage:
echo    arr.remains 1 2 "3 4" 5 -^> 2 "3 4" 5
echo  args:
echo    1+: arguments
echo =============================================
exit /b
:main
shift
if "x%~1"=="x" exit /b
set "result="

:next
set "arg=%~1"
if "x%arg%"=="x" (
    echo %result:__{double_quote}__="%
    exit /b
)
echo "%arg%"| findstr /C:" " >nul 2>&1
if errorlevel 1 (
    if "x%result%"=="x" (
        set "result=%arg%"
    ) else (
        set "result=%result% %arg%"
    )
) else (
    if "x%result%"=="x" (
        set "result=__{double_quote}__%arg%__{double_quote}__"
    ) else (
        set "result=%result% __{double_quote}__%arg%__{double_quote}__"
    )
)
shift
goto :next