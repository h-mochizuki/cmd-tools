@echo off
rem =============================================
rem             set function result
rem ---------------------------------------------
rem  usage:
rem    setf MSG=echo hello
rem    # echo %MSG%
rem    # hello
rem =============================================
for /f "tokens=1,* delims==" %%i in ( "%*" ) do (
    for /f "usebackq tokens=*" %%o in ( `%%j` ) do set "%%i=%%o"
)
