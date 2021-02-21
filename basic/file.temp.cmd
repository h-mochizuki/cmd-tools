@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo          Return temporary file path.
echo ---------------------------------------------
echo  usage:
echo    file.temp -^> %%temp%%\bat~123.tmp
echo  args:
echo    1: folder path [create %%temp%% when empty]
echo    2: postfix [append tmp when empty]
echo =============================================
exit /b
:main
set "tmpdir=%tmp%"
if not "x%~1"=="x" set "tmpdir=%~1"
mkdir "%tmpdir%">nul 2>&1
set "postfix=tmp"
if not "x%~2"=="x" set "postfix=%~2"

:mktmp
set "tmpfile=%tmpdir%\bat~%random%.%postfix%"
if exist "%tmpfile%" goto :mktmp
echo %tmpfile%