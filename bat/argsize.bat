@echo off
setlocal
rem =============================================
rem               count arguments
rem ---------------------------------------------
rem  usage:
rem    argsize 1 2 3 4 5
rem    # 5
rem =============================================
set "CNT="
:count
if not "x%~1"=="x" (
    set /a "CNT=%CNT%+1"
    shift
    goto :count 
)
echo %CNT%