@echo off
setlocal EnableDelayedExpansion
if not "x%~1"=="x/?" goto :main
echo =============================================
echo            Return array is empty.
echo ---------------------------------------------
echo  usage:
echo    arr.empty [arguments]...
echo  ex:
echo    echo %%* -^> 1 2 3
echo    call arr.count %%*
echo    if not errorlevel 1 echo empty -^> empty
echo  args:
echo    1+: arguments
echo  return code:
echo    0: empty
echo    1: not empty
echo =============================================
exit /b
:main
call %~dp0path.include
call var.setf size arr.count %*
if "x%size%"=="x0" exit /b 0
exit /b 1