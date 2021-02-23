@if(0)==(0) echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo         Return current unixtime.
echo ---------------------------------------------
echo  usage:
echo    time.unixtime
echo  ex:
echo    time.unixtime -^> 16138...
echo =============================================
exit /b 1
:main
call cscript //nologo /E:JScript "%~f0" %*
exit /b
@end
WScript.Echo(new Date().getTime());