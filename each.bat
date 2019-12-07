@echo off
setlocal
rem =============================================
rem                generic xargs
rem ---------------------------------------------
rem  usage:
rem    echo hello| each echo {}{}
rem    # hellohello
rem =============================================
set COMMAND=%*
set REPLACER={}
for /f "usebackq tokens=*" %%o in (`findstr .*`) do call %%COMMAND:%REPLACER%=%%o%%