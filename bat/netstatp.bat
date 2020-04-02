@echo off
setlocal EnableDelayedExpansion
rem =============================================
rem            Show netstat and process
rem ---------------------------------------------
rem  usage:
rem    netstatp
rem    # PRT LOCAL_ADDR            FOREIGN_ADDR         STATUS      PID   COMMAND
rem    # -------------------------------------------------------------------------------
rem    # TCP 0.0.0.0:135           0.0.0.0:0            LISTENING   1156  svchost.exe RpcEptMapper,RpcSs
rem    # TCP 0.0.0.0:445           0.0.0.0:0            LISTENING   4     System N/A
rem =============================================
echo PRT LOCAL_ADDR             FOREIGN_ADDR         STATUS      PID   COMMAND
echo --------------------------------------------------------------------------------
for /f "usebackq tokens=1,2,3,4,5" %%a in ( `netstat -ano` ) do (
    set "COMMAND="
    set "PRT=%%a"
    if "x!PRT!"=="xTCP" (
        for /f "usebackq tokens=*" %%f in ( `pad "%%b" -21 -` ) do set "LADD=%%f"
        for /f "usebackq tokens=*" %%f in ( `pad "%%c" -20 -` ) do set "FADD=%%f"
        for /f "usebackq tokens=*" %%f in ( `pad "%%d" -11 -` ) do set "STS=%%f"
        for /f "usebackq tokens=*" %%f in ( `pad "%%e" -5 -` ) do set "PID=%%f"
        for /f "usebackq tokens=*" %%f in ( `tasklist /SVC /NH /FO CSV /FI "PID eq %%e"` ) do (
            set LINE=%%f
            set LINE=!LINE:","= !
            for /f "tokens=1,2,*" %%g in ( !LINE! ) do set "COMMAND=%%g %%i"
        )
        echo !PRT! !LADD:-= !  !FADD:-= ! !STS:-= ! !PID:-= ! !COMMAND!
    ) else (
    if "x!PRT!"=="xUDP" (
        for /f "usebackq tokens=*" %%f in ( `pad "%%b" -21 -` ) do set "LADD=%%f"
        for /f "usebackq tokens=*" %%f in ( `pad "%%c" -20 -` ) do set "FADD=%%f"
        for /f "usebackq tokens=*" %%f in ( `pad "%%d" -5 -` ) do set "PID=%%f"
        for /f "usebackq tokens=*" %%f in ( `tasklist /SVC /NH /FO CSV /FI "PID eq %%d"` ) do (
            set LINE=%%f
            set LINE=!LINE:","= !
            for /f "tokens=1,2,*" %%g in ( !LINE! ) do set "COMMAND=%%g %%i"
        )
        echo !PRT! !LADD:-= !  !FADD:-= ! !STS:-= ! !PID:-= ! !COMMAND!
    ))
)
