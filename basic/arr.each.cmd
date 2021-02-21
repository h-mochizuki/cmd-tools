@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo       Execute command each input-stream.
echo ---------------------------------------------
echo  usage:
echo    echo a^| arr.each echo {}{} -^> aa
echo  args:
echo    1+: commands [{} replaced argument]
echo;
echo  caution1: argment is required.
echo    arr.each -^> FREEZE!! WAIT INPUT.
echo  caution2: white space is counted.
echo    echo str   ^| arr.each -^> 6
echo =============================================
exit /b
:main
set "command=%*"
set "replacer={}"
for /f "usebackq tokens=*" %%o in (`findstr .*`) do call %%command:%replacer%=%%o%%