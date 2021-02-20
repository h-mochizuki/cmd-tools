@if(0)==(0) echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo   Input-stream to output-stream and file.
echo ---------------------------------------------
echo  usage:
echo    echo abc ^| str.tee log.txt -^> abc
echo    # cat log.txt -^> abc
echo  args:
echo    1: -a append mode[option]
echo    2: log-file path[option]
echo =============================================
exit /b
:main
findstr .* | call cscript //nologo /E:JScript "%~f0" %*
exit /b
@end
var fso = WScript.CreateObject("Scripting.FileSystemObject");
var argCnt = WScript.Arguments.Count();
var mode = 2;
var filename = "";
for(var i = 0; i < WScript.Arguments.Count(); i++){
    if (WScript.Arguments(i) == "-a") {
        mode = 8;
    } else {
        filename = WScript.Arguments(i) || "";
    }
}
if (filename == "") {
    function date(){
        var d      = new Date();
        var year   = d.getFullYear();
        var month  = ('0' + (d.getMonth()+1)).slice(-2);
        var day    = ('0' + d.getDate()).slice(-2);
        var hour   = ('0' + d.getHours()).slice(-2);
        var minute = ('0' + d.getMinutes()).slice(-2);
        var second = ('0' + d.getSeconds()).slice(-2);
        return year + month + day + hour + minute + second;
    }
    filename = "log_" + date() + ".txt";
}
var file = fso.OpenTextFile(filename, mode, true);

while (!WScript.StdIn.AtEndOfStream) {
  var line = WScript.StdIn.ReadLine(); 
  WScript.StdOut.WriteLine(line);
  file.WriteLine(line);
}
file.close();
