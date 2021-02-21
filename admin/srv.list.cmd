@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo         Show service list or detail.
echo ---------------------------------------------
echo  usage:
echo    srv.info
echo  args:
echo    1: service name [show list when empty]
echo =============================================
exit /b
:main
where file.temp >nul 2>nul
if errorlevel 1 set "PATH=%PATH%;%~dp0;%~dp0..\basic"
where args.setf >nul 2>nul
if errorlevel 1 set "PATH=%PATH%;%~dp0;%~dp0..\basic"
if "x%~1"=="x" (
    sc query state=all
    exit /b
)
call args.setf tmpfile file.temp
echo tmpfile: %tmpfile%
sc query state=all | findstr /B SERVICE_NAME >"%tmpfile%"
for /f "tokens=2* delims=: " %%s in (%tmpfile%) do (
    for %%n in ( %* ) do (
        echo "%%~s" | findstr /C:"%%~n" >nul 2>&1
        if not errorlevel 1 sc queryex "%%~s"
    )
)
del /F /Q "%tmpfile%">nul 2>&1
exit /b
