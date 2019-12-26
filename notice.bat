@echo off
setlocal EnableDelayedExpansion
rem =============================================
rem                 show msg dialog
rem =============================================
set "WS=%TIME:~0,8%%TIME:~9,2%"
set "WS=%~dp0.ws_notice_%DATE:/=%%WS::=%.txt"
if "x%1"=="x" (
    for /f "usebackq tokens=*" %%i in (`findstr .*`) do echo %%i>>%WS%
) else (
    for %%i in ( %* ) do echo %%i>>%WS%
)
msg /V /W %USERNAME% <"%WS%"
del /F /Q "%WS%"
