@if(0)==(0) echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo             Return current time.
echo ---------------------------------------------
echo  usage:
echo    time_current [format]
echo  ex:
echo    time_current -^> 2021/02/21 06:54:34
echo    time_current yyyyMMdd -^> 20210221
echo  format: (default: yyyy/MM/dd HH:mm:ss)
echo    yyyy        : four digits 'year'
echo    yy          : last tow digits 'year'
echo    MM, mo, m12 : 'month'
echo    dd          : 'day'
echo    ampm        : 'am' or 'pm'
echo    HH, h24     : 24-'hour' notation
echo    hh, h12     : 12-'hour' notation
echo    mm, mi, m60 : 'minuts'
echo    ss          : 'seconds'
echo =============================================
exit /b 1
:main
if "x%~1"=="x" (
    echo;| call cscript //nologo /E:JScript "%~f0"
) else (
    echo %*| call cscript //nologo /E:JScript "%~f0"
)
exit /b
@end
var result;
while (!WScript.StdIn.AtEndOfStream) {
  result = WScript.StdIn.ReadLine();
}
if (result == "") {
    result  = "yyyy/MM/dd HH:mm:ss";
}
var d      = new Date();
var yyyy   = d.getFullYear();
var yy   = ('' + d.getFullYear()).slice(-2);
var MM  = ('0' + (d.getMonth()+1)).slice(-2);
var dd    = ('0' + d.getDate()).slice(-2);
var HH   = ('0' + d.getHours()).slice(-2);
var hh   = ('0' + (d.getHours() % 12)).slice(-2);
var AMPM = d.getHours() < 12 ? "AM" : "PM";
var mm = ('0' + d.getMinutes()).slice(-2);
var ss = ('0' + d.getSeconds()).slice(-2);

result = result.replace(/yyyy/, yyyy);
result = result.replace(/yy/, yy);
result = result.replace(/MM/, MM);
result = result.replace(/mo/, MM);
result = result.replace(/m12/, MM);
result = result.replace(/dd/, dd);
result = result.replace(/HH/, HH);
result = result.replace(/h24/, HH);
result = result.replace(/hh/, hh);
result = result.replace(/h12/, hh);
result = result.replace(/ampm/, AMPM);
result = result.replace(/mm/, mm);
result = result.replace(/mi/, mm);
result = result.replace(/m60/, mm);
result = result.replace(/ss/, ss);

WScript.Echo(result);