@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo    Return absolute path from your inputs.
echo ---------------------------------------------
echo  usage:
echo    path.absolute [folder or file]...
echo  ex:
echo    path.absolute FILE -^> C:\PATH\TO\FILE
echo    echo FILE ^| path.absolute -^> C:\PATH\TO\FILE
echo  args:
echo    1+: folder or file name
echo; 
echo  caution:
echo    argment is required.
echo    ex) path.absolute -^> FREEZE!! WAIT INPUT.
echo =============================================
exit /b 1
:main
call %~dp0path.include
for /f "usebackq tokens=*" %%i in (`str.stream %*`) do echo %%~fi