@echo off
setlocal EnableDelayedExpansion
rem =============================================
rem                  show ipv4
rem ---------------------------------------------
rem  usage:
rem    ipv4 [Switch Name]
rem =============================================
set EL=1
for %%i in ( "wk_%DATE:/=%%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%%TIME:~9,2%" ) do (
    mkdir "%%i"
    pushd "%%i"
    call :main
    if exist "ipv4.txt" (
        if "x%~1"=="x" (
            type ipv4.txt
            set EL=0
        ) else (
            for /f "tokens=1,* delims=:" %%a in ( ipv4.txt ) do (
                echo %%b| findstr "%~1">nul
                if not errorlevel 1 (
                    set "IP_ADDR=%%a"
                    echo !IP_ADDR: =!
                    set EL=0
                )
            )
        )
    )
    popd
    rmdir /S /Q "%%i"
)
exit /b !EL!

:main
@echo off
setlocal EnableDelayedExpansion
for /f "usebackq tokens=* delims=" %%j in ( `ipconfig` ) do (
    echo %%j| findstr /R /C:"^ ">nul
    if errorlevel 1 (
        set "IP_NAME=%%j"
        if not "x!IP_NAME!"=="x" set "IP_NAME=!IP_NAME:~0,-1!"
    )
    echo %%j| findstr IPv4>nul
    if not errorlevel 1 (
        for /f "usebackq tokens=1,* delims=:" %%a in ( `echo %%j` ) do set "IP_ADDR=%%b"
        if not "x!IP_ADDR!"=="x" set "IP_ADDR=!IP_ADDR: =!"
        if not "x!IP_ADDR!"=="x" (
            echo !IP_ADDR! : !IP_NAME!>>"ipv4.txt"
            set "IP_NAME="
            set "IP_ADDR="
        )
    )
)
