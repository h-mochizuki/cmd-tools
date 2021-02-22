@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo             Show message dialog.
echo ---------------------------------------------
echo  usage:
echo    dialog.msg "Good morning!!"
echo  args:
echo    1: input-string or input-stream
echo; 
echo  caution: argment is required.
echo    dialog.msg -^> FREEZE!! WAIT INPUT.
echo =============================================
exit /b
:main
if "x%~1"=="x" (
    findstr .* | msg %USERNAME%
) else (
    echo %* | msg %USERNAME%
)
