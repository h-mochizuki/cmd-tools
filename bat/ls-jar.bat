@echo off
setlocal EnableDelayedExpansion
rem =============================================
rem             list files in jar
rem ---------------------------------------------
rem  usage:
rem    ls-jar [option] [jar]...
rem  option:
rem    /C  : show class file only
rem =============================================
if "x%~1"=="x" goto :usage
if /i "x%~1"=="x/?" goto :usage
if /i "x%~1"=="x-?" goto :usage
goto :main

:usage
echo usage:
echo   ^>ls-jar [option] [jar]...
echo option:
echo\  /c  : show class file only
exit /b 1

:main
if /i "x%~1"=="x/c" set CLASS_ONLY=1
if /i "x%~1"=="x-c" set CLASS_ONLY=1
if "x!CLASS_ONLY!"=="x1" shift

:list
set "JAR_PATH=%~1"
shift
if "x!JAR_PATH!"=="x" exit /b
if not exist "!JAR_PATH!" (
    echo Notfound: !JAR_PATH!
    goto :list
)
echo !JAR_PATH!|findstr /E ar>nul
if not ERRORLEVEL 1 (
    for /f "usebackq tokens=*" %%j in ( `jar tvf !JAR_PATH!` ) do (
        for %%k in ( %%j ) do set "N=%%k"
        if not "x!N:~-1!"=="x/" (
            if "x!CLASS_ONLY!"=="x" (
                echo !N!
            ) else (
                if "x!N:~-6!"=="x.class" (
                    set "N=!N:~0,-6!"
                    echo !N:/=.!
                )
            )
        )
    )
    if not "x%~1"=="x" echo;
    goto :list
)
