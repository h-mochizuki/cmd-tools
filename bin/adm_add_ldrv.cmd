@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo               Add local drive.
echo ---------------------------------------------
echo  usage:
echo    adm_add_ldrv [option] drive-letter folder
echo  options:
echo\   /?: show this usage.
echo  args:
echo    drive-letter: drive-letter to add
echo    folder      : mount folder path
echo =============================================
exit /b 1
:usage
(
    echo  usage:
    echo    adm_add_ldrv drive-letter folder
    echo  args:
    echo    drive-letter: drive-letter to add
    echo    folder      : mount folder path
) >&2
exit /b 1
:main
if "x%~1"=="x" goto :usage
if "x%~2"=="x" goto :usage
call %~dp0path_include
call var_setf dl str_upper %1
set "dl=%dl:~,1%"
set "folder=%~f2"

if exist "%dl%:\" (
    echo Drive[%dl%:] has already been used. >&2
    exit /b 1
)
call dir_exists "%folder%"
if errorlevel 1 (
    echo Target folder is not found: %folder%
    call yn "Create %folder%?"
    if errorlevel 1 (
        echo Canceled. >&2
        exit /b 1
    )
    mkdir "%folder%"
    echo;
)
echo After the work, you need to restart the machine.
call yn "Add drive[%dl%:]?"
if errorlevel 1 (
    echo Canceled. >&2
    exit /b 1
)
call var_setf regfile file_temp "%temp%" reg
(
    echo Windows Registry Editor Version 5.00
    echo;
    echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices]
    echo "%dl%:"="\\??\\%folder:\=\\%"
    echo;
) >"%regfile%"
call regedit /S %regfile%
set "elevel=%errorlevel%"
del /Q /F "%regfile%"
echo Linked %dl%:\ ^<-^> "%folder%"
echo Please reboot.
exit /b %elevel%
