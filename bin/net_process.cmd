@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo           Show netstat and process.
echo ---------------------------------------------
echo  usage:
echo    net_process [option]
echo  options:
echo\   /?: show this usage.
echo =============================================
exit /b 1
:main
call %~dp0path_include
echo PRT LOCAL_ADDR             FOREIGN_ADDR         STATUS      PID   COMMAND
echo --------------------------------------------------------------------------------
for /f "usebackq tokens=1,2,3,4,5" %%a in ( `netstat -ano` ) do (
    set "proto=%%a"
    if "x%%~a"=="xTCP" call :tcp "%%~b" "%%~c" "%%~d" "%%~e"
    if "x%%~a"=="xUDP" call :udp "%%~b" "%%~c" "%%~d"
)
exit /b

:tcp
set "command="
call var_setf ladd str_padding "%~1" 21
call var_setf fadd str_padding "%~2" 20
call var_setf status str_padding "%~3" 11
call var_setf pid str_padding "%~4" 5
for /f "usebackq tokens=1,2,*" %%a in ( `task_list /nh /p %~4` ) do set "command=%%a %%c"
echo TCP %ladd%  %fadd% %status% %pid% %command%
exit /b

:udp
set "command="
call var_setf ladd str_padding "%~1" 21
call var_setf fadd str_padding "%~2" 20
set "status=           "
call var_setf pid str_padding "%~3" 5
for /f "usebackq tokens=1,2,*" %%a in ( `task_list /nh /p %~3` ) do set "command=%%a %%c"
echo UDP %ladd%  %fadd% %status% %pid% %command%
exit /b
