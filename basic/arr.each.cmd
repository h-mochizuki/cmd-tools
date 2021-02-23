@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo       Execute command each input-stream.
echo ---------------------------------------------
echo  usage:
echo    arr.each [command]
echo  ex:
echo    echo a^| arr.each echo {}{} -^> aa
echo  args:
echo    1: command [{} replaced stream item]
echo;
echo  caution: input-stream required.
echo    arr.each -^> FREEZE!! WAIT INPUT.
echo =============================================
exit /b
:main
set "command=%*"
set "replacer={}"
for /f "usebackq tokens=*" %%o in (`findstr .*`) do call %%command:%replacer%=%%o%%