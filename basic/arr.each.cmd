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
echo  caution1:
echo    input-stream required.
echo    ex) arr.each -^> FREEZE!! WAIT INPUT.
echo  caution2:
echo    have to escape like "^|" or "^&"
echo    if use "|" or "&".
echo    ex) echo abc^| arr.each echo {}{}^^^| findstr a
echo =============================================
exit /b 1
:main
set "replacer={}"
set "command=%*"
set "command=%command:&=^&%"
set "command=%command:|=^|%"
for /f "usebackq tokens=*" %%o in (`findstr .*`) do call %%command:%replacer%=%%o%%