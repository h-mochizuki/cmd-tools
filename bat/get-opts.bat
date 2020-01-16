@echo off
rem =============================================
rem               get option value
rem ---------------------------------------------
rem  usage:
rem    get-opt [opt] [args]...
rem    # get-opt A /A
rem    > echo %OPT-SET% => true
rem    # get-opt A /B
rem    > echo %OPT-SET% => false
rem    # get-opt :C /C ccc ddd eee fff
rem    > echo %OPT-SET% => true
rem    > echo %OPT-VAL% => ccc
rem    > echo %OPT-ARGS% => ddd eee fff
rem  arguments:
rem    opt  : option name
rem           if option has value, start with ':'
rem    args : bat arguments
rem =============================================
set "OPT-SET="
set "OPT-VAL="
set "OPT-ARGS="
pushd %~pd0..
for %%i in ( "wk_%DATE:/=%%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%%TIME:~9,2%" ) do (
    mkdir "%%i"
    pushd "%%i"
    call :main %*
    if errorlevel 1 (
        if exist error.txt type error.txt
    ) else (
        if exist opt.txt (
            set "OPT-SET=true"
            for /f "eol=# tokens=*" %%j in ( opt.txt ) do (
                if not "x%%j"=="x" set "OPT-VAL=%%j"
            )
        )
        for /f "eol=# tokens=*" %%j in ( remains.txt ) do (
            if not "x%%j"=="x" set "OPT-ARGS=%%j"
        )
    )
    popd
    rmdir /S /Q "%%i"
)
popd
exit /b

:main
@echo off
setlocal EnableDelayedExpansion
echo;> remains.txt
( echo %* ) > original_args.txt
set "OPT=%~1"
if "x%OPT%"=="x" (
    echo option-name is not set > error.txt
    exit /b 9
)
shift
set "ARG="
echo %OPT%|findstr /B :>nul
if not ERRORLEVEL 1 (
    set "ARG=true"
    set "OPT=!OPT:~1!"
)
set "OPT=!OPT:~0,1!"
set "YET="
set "NEXT="
set "REMAINS="
:NEXT
if not "x%~1"=="x" (
    if "x%YET%"=="x" (
        if "x%NEXT%"=="xtrue" (
            ( echo %1)> opt.txt
            set "YET=true"
            shift
            goto NEXT
        )
        if "x%~1"=="x/%OPT%" (
            echo;> opt.txt
            if "x%ARG%"=="xtrue" (
                set "NEXT=true"
            ) else (
                set "YET=true"
            )
            shift
            goto NEXT
        )
    )
    if defined REMAINS (
        set REMAINS=%REMAINS% %1
    ) else (
        set REMAINS=%1
    )
    shift
    goto NEXT
)
if defined REMAINS echo %REMAINS%> remains.txt
exit /b 0
endlocal
