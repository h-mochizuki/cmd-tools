@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo             Show md5sum hash.
echo ---------------------------------------------
echo  usage:
echo    file.md5sum file -^> 2786...
echo =============================================
exit /b
:main
where str.stream >nul 2>nul
if errorlevel 1 set "PATH=%PATH%;%~dp0"
for /f "usebackq tokens=*" %%i in (`str.stream %*`) do (
    certutil -hashfile "%%~fi" MD5 | findstr /V /B "CertUtil: "
)