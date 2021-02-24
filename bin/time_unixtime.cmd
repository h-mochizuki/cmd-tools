@if(0)==(0) echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo         Return current unixtime.
echo ---------------------------------------------
echo  usage:
echo    time_unixtime [option]
echo  ex:
echo    time_unixtime -^> 16138...
echo  options:
echo\   /?: show this usage.
echo =============================================
exit /b 1
:main
call cscript //nologo /E:JScript "%~f0" %*
exit /b
@end
WScript.Echo(new Date().getTime());