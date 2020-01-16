@echo off
rem =============================================
rem              load properties
rem ---------------------------------------------
rem  usage:
rem    setp [properties file]
rem =============================================
for /f "eol=# tokens=1,* delims==" %%i in ( %1 ) do (
    set "%%i=%%j"
)
