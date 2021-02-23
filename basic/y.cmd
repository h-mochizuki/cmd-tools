@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo               Retrun 0.
echo ---------------------------------------------
echo  usage:
echo    y
echo  ex:
echo    y
echo    if not errorlevel 1 echo yes -^> yes
echo  return code:
echo    0: always
echo =============================================
exit /b 1
:main
exit /b 0
