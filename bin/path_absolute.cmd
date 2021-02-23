@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo    Return absolute path from your inputs.
echo ---------------------------------------------
echo  usage:
echo    path_absolute [folder or file]...
echo  ex:
echo    path_absolute FILE -^> C:\PATH\TO\FILE
echo    echo FILE ^| path_absolute -^> C:\PATH\TO\FILE
echo  args:
echo    1+: folder or file name
echo; 
echo  caution:
echo    argment is required.
echo    ex) path_absolute -^> FREEZE!! WAIT INPUT.
echo =============================================
exit /b 1
:main
call %~dp0path_include
for /f "usebackq tokens=*" %%i in (`str.stream %*`) do echo %%~fi