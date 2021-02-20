@echo off
setlocal
if not "x%1"=="x/?" goto :main
echo =============================================
echo    Return absolute path from your inputs.
echo ---------------------------------------------
echo  usage:
echo    file.apath FILE -^> C:\PATH\TO\FILE
echo    echo FILE ^| file.apath -^> C:\PATH\TO\FILE
echo  args:
echo    1: input-string or input-stream
echo; 
echo  caution: argment is required.
echo    file.apath -^> FREEZE!! WAIT INPUT.
echo =============================================
exit /b
:main
where str.stream >nul 2>nul
if errorlevel 1 set "PATH=%PATH%;%~dp0"
for /f "usebackq tokens=*" %%i in (`str.stream %*`) do echo %%~fi