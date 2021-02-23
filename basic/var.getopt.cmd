@echo off
if not "x%~1"=="x/?" goto :main
echo =============================================
echo    Return option exists, value and remains.
echo ---------------------------------------------
echo  usage:
echo    var.getopt [opts] [option] [arguments]...
echo  ex:
echo    echo %%* -^> 1 "2" /p value 3
echo    call var.getopt /v /p %%*
echo    if not errorlevel 1 (
echo      echo %%_opt_name_%%  -^> /p
echo      echo %%_opt_value_%% -^> value
echo      echo %%_opt_remains_%% -^> 1 "2" 3
echo      echo %%_opt_shift_%% -^> shift /3 ^& shift /3
echo      rem Do shift!!
echo      %%_opt_shift_%%
echo    )
echo    echo %%1 -^> 1
echo    echo %%2 -^> "2"
echo    echo %%3 -^> 3
echo;
echo    # easy way:
echo    call var.getopt /v /p %%* ^&^& %%_opt_shift_%%
echo    set value=%%_opt_value_%%
echo  opts:
echo    /v: set value to _opt_value_
echo        set //v instead of /v if use /v option and empty value.
echo  args:
echo    1: option
echo    2: arguments
echo  return code:
echo    0: option exists
echo    1: no option
echo  set variables: if option exists.
echo    _opt_name_: option name
echo    _opt_value_: option value if option has value
echo    _opt_remains_: remain argumengs
echo    _opt_shift_: shift commands
echo =============================================
exit /b
:main
pushd "%~dp0"
set _opt_name_=
set _opt_value_=
set _opt_remains_=
set _opt_shift_=
for %%w in ( ".ws_%DATE:/=%%RANDOM%%RANDOM%" ) do (
    mkdir "%%w"
    pushd "%%w"
    call :sub %*
    if errorlevel 1 (
        if exist option.env (
            for /f "tokens=*" %%i in ( option.env ) do (
                if not "x%%i"=="x" %%i
            )
        )
        call :fail
    ) else (
        if exist option.env (
            for /f "tokens=*" %%i in ( option.env ) do (
                if not "x%%i"=="x" %%i
            )
        )
    )
    popd
    rmdir /S /Q "%%w"
)
popd
exit /b %errorlevel%

:fail
exit /b 1

:sub
setlocal
call %~dp0path.include
set "cnt=0"
if "x%~1"=="x/v" set "hasval=1" & shift
if "x%~1"=="x" exit /b 1
set "opt=%~1"
if "x%opt%"=="x//v" set "opt=/v"
set "remains= "

:next
shift
if "x%~1"=="x" (
    if exist option.env (
        echo set _opt_remains_=%remains:~1%>> option.env
        exit /b 0
    ) else (
        echo set _opt_name_=%opt%>> option.env
        echo set _opt_remains_=%remains:~1%>> option.env
        exit /b 1
    )
)
set /a "cnt=%cnt%+1"
if "x%~1"=="x%opt%" (
    if not exist option.env (
        echo set _opt_name_=%1>> option.env
        if "x%hasval%"=="x" (
            echo set _opt_shift_=shift /%cnt%>> option.env
        ) else (
            echo set _opt_value_=%2>> option.env
            echo set _opt_shift_=shift /%cnt% ^& shift /%cnt%>> option.env
            shift
        )
    ) else (
        call :empty %remains%
        if errorlevel 1 (
            set "remains=%remains% %1"
        ) else (
            set "remains=%1"
        )
    )
) else (
    if errorlevel 1 (
        set "remains=%remains% %1"
    ) else (
        set "remains=%1"
    )
)
goto :next

:empty
if "x%~1"=="x" exit /b 0
exit /b 1