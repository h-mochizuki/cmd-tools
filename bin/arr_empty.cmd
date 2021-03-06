@echo off
setlocal EnableDelayedExpansion
if not "x%~1"=="x/?" goto :main
echo =============================================
echo            Return array is empty.
echo ---------------------------------------------
echo  usage:
echo    arr_empty [option] item[...]
echo  ex:
echo    echo %%* -^> 1 2 3
echo    call arr_empty %%*
echo    if not errorlevel 1 echo empty -^> empty
echo  options:
echo\   /?: show this usage.
echo  args:
echo    item: array items
echo  return code:
echo    0: empty
echo    1: not empty
echo =============================================
exit /b 1
:main
for %%i in ( %* ) do exit /b 1
exit /b 0