@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo              Check number only.
echo ---------------------------------------------
echo  usage:
echo    str_isnum [string]...
echo  ex:
echo    str_isnum -123.456
echo    if not errorlevel 1 echo number!
echo  args:
echo    1+: target string
echo  return code:
echo    0: number only.
echo    1: contains not number charactor.
echo;
echo  caution:
echo    argment is required.
echo    ex) str_isnum -^> FREEZE!! WAIT INPUT.
echo =============================================
exit /b 1
:main
call %~dp0path_include
for /f "usebackq tokens=*" %%i in (`str_stream %*`) do (
    echo %%i| findstr /R /C:"^-*[0-9]*\.*[0-9]*$" >nul
    if errorlevel 1 exit /b 1
)
exit /b 0
