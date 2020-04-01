@echo off
setlocal EnableDelayedExpansion

for /f "usebackq tokens=1,2,3,4,5" %%a in ( `netstat -ano` ) do (
    set "COMMAND="
    set "PRT=%%a"
    if "x!PRT!"=="xTCP" (
        for /f "usebackq tokens=*" %%f in ( `fill "%%b" 20 -` ) do set "LADD=%%f"
        for /f "usebackq tokens=*" %%f in ( `fill "%%c" -20 -` ) do set "FADD=%%f"
        for /f "usebackq tokens=*" %%f in ( `fill "%%d" -11 -` ) do set "STS=%%f"
        for /f "usebackq tokens=*" %%f in ( `fill "%%e" 5 -` ) do set "PID=%%f"
        for /f "usebackq tokens=*" %%f in ( `tasklist /SVC /NH /FO CSV /FI "PID eq %%e"` ) do (
            set LINE=%%f
            set LINE=!LINE:","= !
            for /f "tokens=1,2,*" %%g in ( !LINE! ) do set "COMMAND=%%g %%i"
        )
        echo !PID:-= ! !PRT! !STS:-= ! !LADD:-= !-^>!FADD:-= ! !COMMAND!
    ) else ( 
    if "x!PRT!"=="xUDP" (
        for /f "usebackq tokens=*" %%f in ( `fill "%%b" 20 -` ) do set "LADD=%%f"
        for /f "usebackq tokens=*" %%f in ( `fill "%%c" -20 -` ) do set "FADD=%%f"
        for /f "usebackq tokens=*" %%f in ( `fill "%%d" 5 -` ) do set "PID=%%f"
        for /f "usebackq tokens=*" %%f in ( `tasklist /SVC /NH /FO CSV /FI "PID eq %%d"` ) do (
            set LINE=%%f
            set LINE=!LINE:","= !
            for /f "tokens=1,2,*" %%g in ( !LINE! ) do set "COMMAND=%%g %%i"
        )
        for /f "usebackq tokens=* delims=;" %%f in ( `fill !PID! 5 -` ) do set "PID=%%f"
        echo !PID:-= !     !STS:-= ! !LADD:-= !-^>!FADD:-= ! !COMMAND!
    ))
)
