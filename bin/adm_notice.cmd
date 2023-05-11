@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo             Show task-bar msg.
echo ---------------------------------------------
echo  usage:
echo    adm_notice [option] message
echo  ex:
echo    adm_notice "Hey" -^> show popup "Hey"
echo  options:
echo    /t ^<title^>: title.
echo\   /?: show this usage.
echo  args:
echo    message: send message
echo =============================================
exit /b 1
:main
call %~dp0path_include

set "TITLE="
set "MSG="
if "x%~1"=="x/t" (
    set "TITLE=%~2"
    shift
    shift
)
if "x%~1"=="x" (
    set "MSG=%TITLE%"
) else (
    set "MSG=%~1"
)
if "x%TITLE%"=="x" (
    set "TITLE=%MSG%"
)

set "CMD_SCRIPT="
set "CMD_SCRIPT=%CMD_SCRIPT%; [Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')"
set "CMD_SCRIPT=%CMD_SCRIPT%; [Reflection.Assembly]::LoadWithPartialName('System.Drawing')"
set "CMD_SCRIPT=%CMD_SCRIPT%; $notifyIcon = New-Object System.Windows.Forms.NotifyIcon"
set "CMD_SCRIPT=%CMD_SCRIPT%; $notifyIcon.Icon = [System.Drawing.SystemIcons]::Information"
set "CMD_SCRIPT=%CMD_SCRIPT%; $notifyIcon.Visible = $true"
set "CMD_SCRIPT=%CMD_SCRIPT%; $notifyIcon.ShowBalloonTip(5000, '%TITLE%', '%MSG%', [System.Windows.Forms.ToolTipIcon]::Info)"

powershell.exe -Command %CMD_SCRIPT% >nul
