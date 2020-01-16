@echo off
setlocal
rem =============================================
rem              show confirm dialog
rem =============================================
pushd %~pd0..
set EL=1
for %%i in ( "wk_%DATE:/=%%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%%TIME:~9,2%" ) do (
    mkdir "%%i"
    pushd "%%i"
    call :main %*
    set "EL=!ERRORLEVEL!"
    popd
    rmdir /S /Q "%%i"
)
popd
exit /b !EL!

:main
(
    echo Option Explicit
    echo Dim msg
    echo Dim i
    echo Dim re
    echo If WScript.Arguments.Count ^< 1 Then
    echo     msg = "OK?"
    echo Else
    echo     for i=1 to WScript.Arguments.Count
    echo         If Len^(msg^) ^> 1 Then msg = msg ^& vbCrLf
    echo         msg = msg ^& WScript.Arguments.Item^(i-1^)
    echo     next
    echo End If
    echo WScript.Quit^(msgbox^(msg, vbOKCancel + vbQuestion^) - 1^)
)>confirm.vbs

if "x%1"=="x" (
    set MSG=
    for /f "usebackq tokens=*" %%i in (`findstr .*`) do set MSG=!MSG! "%%i"
    CScript.exe //NoLogo confirm.vbs !MSG!
) else (
    CScript.exe //NoLogo confirm.vbs %*
)
