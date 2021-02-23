@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo             Show message dialog.
echo ---------------------------------------------
echo  usage:
echo    dialog.msg [message]
echo  ex:
echo    dialog.msg "Good morning!!"
echo  args:
echo    1: message
echo; 
echo  caution:
echo    argment is required.
echo    ex) dialog.msg -^> FREEZE!! WAIT INPUT.
echo =============================================
exit /b 1
:main
if "x%~1"=="x" (
    findstr .* | msg %USERNAME%
) else (
    echo %* | msg %USERNAME%
)
