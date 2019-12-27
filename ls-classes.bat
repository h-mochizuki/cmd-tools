@echo off
setlocal EnableDelayedExpansion
rem =============================================
rem             show classes in jar
rem ---------------------------------------------
rem  usage:
rem    ls-classes [jar]...
rem =============================================
set "WK=%TIME:~0,8%%TIME:~9,2%"
set "WK=wk_%DATE:/=%%WK::=%.txt"
for %%i in ( %* ) do (
    echo %%i|findstr /E .jar>nul
    if not ERRORLEVEL 1 (
        for /f "usebackq tokens=*" %%j in ( `jar tvf %%i` ) do (
            for %%k in ( %%j ) do set "N=%%k"
            echo !N!|findstr /E .class>nul
            if not ERRORLEVEL 1 (
                set "N=!N:.class=!"
                echo !N:/=.!>>%WK%
            )
        )
    )
)
if exist %WK% (
    type %WK%
    del /F /Q %WK%
)
