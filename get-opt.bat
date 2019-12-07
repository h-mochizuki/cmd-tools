@echo off
setlocal EnableDelayedExpansion
rem =============================================
rem               get option value
rem ---------------------------------------------
rem  usage:
rem    get-opt [opt] [args]...
rem    # get-opt A /A
rem    # true
rem    # get-opt A /B
rem    # 
rem    # get-opt C /C ddd
rem    # ddd
rem  arguments:
rem    opt  : option name
rem           if option has value, start with ':'
rem    args : bat arguments
rem =============================================
set "ARG="
set "OPT="
set "NXT="
for %%i in ( %* ) do (
    if "x!OPT!"=="x" (
        set "OPT=%%i"
        echo %%i|findstr /B :>nul
        if not ERRORLEVEL 1 (
            set "ARG=true"
            set "OPT=!OPT:~1!"
        )
    ) else (
        if "x!NXT!"=="xtrue" echo %%i& exit /b 
        if "x%%i"=="x/!OPT!" (
            if "x!ARG!"=="xtrue" (
                set "NXT=true"
            ) else (
                echo true& exit /b
            )
        )
    )
)
