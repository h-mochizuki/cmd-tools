@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo         Show service list or detail.
echo ---------------------------------------------
echo  usage:
echo    srv.list [service name]...
echo  ex:
echo    srv.list MySQL -^> SERVICE_NAM...
echo  args:
echo    1+: service name [show list when empty]
echo =============================================
exit /b 1
:main
if "x%~1"=="x" (
    sc query state=all
    exit /b
)

call %~dp0path.include
call var.setf tmpfile file_temp
sc query state=all | findstr /B SERVICE_NAME >"%tmpfile%"
for /f "tokens=2* delims=: " %%s in (%tmpfile%) do (
    for %%n in ( %* ) do (
        echo "%%~s" | findstr /C:"%%~n" >nul 2>&1
        if not errorlevel 1 sc queryex "%%~s"
    )
)
del /F /Q "%tmpfile%">nul 2>&1
exit /b
