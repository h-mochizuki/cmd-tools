@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo         Show service list or detail.
echo ---------------------------------------------
echo  usage:
echo    srv_list [option] name[...]
echo  ex:
echo    srv_list MySQL -^> SERVICE_NAM...
echo  options:
echo\   /?: show this usage.
echo  args:
echo    name: service names
echo          (show list when empty)
echo =============================================
exit /b 1
:main
if "x%~1"=="x" (
    sc query state=all
    exit /b
)

call %~dp0path_include
call var_setf tmpfile file_temp
sc query state=all | findstr /B SERVICE_NAME >"%tmpfile%"
for /f "tokens=2* delims=: " %%s in (%tmpfile%) do (
    for %%n in ( %* ) do (
        echo "%%~s" | findstr /C:"%%~n" >nul 2>&1
        if not errorlevel 1 sc queryex "%%~s"
    )
)
del /F /Q "%tmpfile%">nul 2>&1
exit /b
