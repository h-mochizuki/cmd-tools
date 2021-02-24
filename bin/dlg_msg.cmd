@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo             Show message dialog.
echo ---------------------------------------------
echo  usage:
echo    dlg_msg [option] message
echo  ex:
echo    dlg_msg "Good morning!!"
echo  options:
echo\   /?: show this usage.
echo  args:
echo    message: send message
echo; 
echo  caution:
echo    argment is required.
echo    ex) dlg_msg -^> FREEZE!! WAIT INPUT.
echo =============================================
exit /b 1
:main
if "x%~1"=="x" (
    findstr .* | msg %USERNAME%
) else (
    echo %* | msg %USERNAME%
)
