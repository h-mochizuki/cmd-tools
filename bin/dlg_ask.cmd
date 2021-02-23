@if(0)==(0) echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo             Show confirm dialog.
echo ---------------------------------------------
echo  usage:
echo    dlg_ask [message]
echo  ex:
echo    dlg_ask "Are you sure?"
echo    if errorlevel 1 echo No! -^> No!
echo  args:
echo    1: message
echo  return code:
echo    0: yes
echo    1: no
echo; 
echo  caution:
echo    argment is required.
echo    ex) dlg_ask -^> FREEZE!! WAIT INPUT.
echo =============================================
exit /b 1
:main
if "x%~1"=="x" (
    findstr .* | call cscript //nologo /E:JScript "%~f0"
) else (
    echo %* | call cscript //nologo /E:JScript "%~f0"
)
exit /b %errorlevel%
@end
var text = "";
while (!WScript.StdIn.AtEndOfStream) {
    if (text != "") {
        text = text + "\n";
    }
    text = text + WScript.StdIn.ReadLine(); 
}
if (text == "") {
    text = "Are you sure?";
}
var sh = WScript.CreateObject("WScript.Shell");
var ret = sh.Popup(text, 0, "Windows Script Host", 32+4+0)
if (ret == 6) {
    WScript.Quit(0);
}
WScript.Quit(1);
