@echo off
setlocal
rem =============================================
rem                string length
rem ---------------------------------------------
rem  usage:
rem    stlen aaa
rem    # 3
rem =============================================
set "L=0"
set W=%~1
:wc
if "x%W%"=="x" echo %L% & exit /b
set /a "L=%L%+1"
set W=%W:~0,-1%
goto :wc
