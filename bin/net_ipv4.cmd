@echo off
setlocal EnableDelayedExpansion
if not "x%~1"=="x/?" goto :main
echo =============================================
echo              Show IPv4 Addresses.
echo ---------------------------------------------
echo  usage:
echo    net_ipv4 [option] [name]
echo  ex:
echo    net_ipv4 Wi-Fi
echo    # -^> xx.xx.xx.xx : Wireless LAN adapter Wi-Fi
echo  options:
echo\   /?: show this usage.
echo  args:
echo    name: switch name
echo =============================================
exit /b 1
:main
for /f "usebackq tokens=* delims=" %%i in (`ipconfig`) do (
    echo %%i | findstr /R /C:"^ " >nul
    if errorlevel 1 (
        set "switch=%%i"
        if not "x!switch!"=="x" set "switch=!switch:~,-1!"
    )
    if "x%~1"=="x" (
        call :print "!switch!" "%%i"
    ) else (
        echo !switch!| findstr /C:"%~1" >nul
        if not errorlevel 1 call :print "!switch!" "%%i"
    )
)

:print
echo %~2| findstr IPv4 >nul
if errorlevel 1 exit /b
for /f "tokens=1,* delims=:" %%a in ( "%~2" ) do set "ip=%%b"
echo %ip:~1% : %~1
