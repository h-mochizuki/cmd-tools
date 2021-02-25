@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo         Show local drive infomation.
echo ---------------------------------------------
echo  usage:
echo    adm_info_ldrv [option] [drive-letter]
echo  options:
echo\   /?: show this usage.
echo    /p: show folder path only
echo  args:
echo    drive-letter: target drive-letter
echo =============================================
exit /b 1
:main
call %~dp0path_include
set "pathonly="
call var_getopt /p %*
if not errorlevel 1 (
    set "pathonly=1"
    %_opt_shift_%
)
set "cond= "
if "x%~1"=="x" goto :info
call var_setf dl str_upper %1
set cond=/v "%dl:~,1%:"

:info
set "reg_path=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices"
for /f "usebackq tokens=1,2,*" %%a in (`reg query "%reg_path%" %cond% ^| findstr /C:":" ^| findstr /C:"??"`) do (
    call :print "%%a" "%%c"
)
exit /b

:print
set "dl=%~1"
set "folder=%~2"
set "folder=%folder:~4%"
if "x%pathonly%"=="x" (
    echo %dl% ^<-^> %folder%
) else (
    echo %folder%
)
