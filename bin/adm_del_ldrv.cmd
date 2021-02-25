@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo               Delete local drive.
echo ---------------------------------------------
echo  usage:
echo    adm_del_ldrv [option] drive-letter
echo  options:
echo\   /?: show this usage.
echo  args:
echo    drive-letter: drive-letter to delete
echo =============================================
exit /b 1
:usage
(
    echo  usage:
    echo    adm_del_ldrv drive-letter
    echo  args:
    echo    drive-letter: drive-letter to delete
) >&2
exit /b 1
:main
if "x%~1"=="x" goto :usage
call %~dp0path_include
call var_setf dl str_upper %1
set "dl=%dl:~,1%"

set "reg_path=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices"
call reg query "%reg_path%" /v "%dl%:" >nul 2>&1
if errorlevel 1 (
    echo Drive[%dl%:] not found. >&2
    exit /b 1
)
for /f "usebackq tokens=1,2,*" %%a in (`reg query "%reg_path%" /v "%dl%:"`) do set "folder=%%c"
echo After the work, you need to restart the machine.
call yn "Delete drive[%dl%:]?"
if errorlevel 1 (
    echo Canceled. >&2
    exit /b 1
)
call var_setf regfile file_temp "%temp%" reg
(
    echo Windows Registry Editor Version 5.00
    echo;
    echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices]
    echo "%dl%:"=-
    echo;
) >"%regfile%"
call regedit /S %regfile%
set "elevel=%errorlevel%"
del /Q /F "%regfile%"
call :reg_startup "%folder%"
echo Drive[%dl%:] deleted.
echo Please reboot.
exit /b %elevel%

:reg_startup
if "x%~1"=="x" exit /b
set "folder=%~1"
if not exist "%folder:~4%\System Volume Information" exit /b
set "startup=C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
set "rm_svi=%startup%\rm_svi_%DATE:/=%_%RANDOM%.bat"
(
    echo\@echo off
    echo openfiles ^>nul 2^>^&1
    echo if not errorlevel 1 goto :admin
    echo powershell Start-Process -verb runAs cmd -ArgumentList '/c ""cd /d %%~dp0 ^^^& %%~nx0""'
    echo exit /b
    echo :admin
    echo icacls "%folder:~4%\System Volume Information" /grant moch:F
    echo rd /S /Q "%folder:~4%\System Volume Information"
    echo powershell Start-Process cmd -ArgumentList '/c ""cd /d %%~dp0 ^^^& timeout 2 /nobreak ^^^>nul ^^^& del "%%~nx0" ""'
) > "%rm_svi%"
echo Delete "System Volume Information" script registered: %rm_svi%
