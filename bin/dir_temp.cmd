@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo      Return unused temporary folder path.
echo ---------------------------------------------
echo  usage:
echo    dir_temp [option] folder
echo  ex:
echo    dir_temp -^> %%temp%%\tmp~123
echo  options:
echo\   /?: show this usage.
echo  args:
echo    folder: parent folder path
echo            (%%temp%% when empty)
echo =============================================
exit /b 1
:main
set "parent=%tmp%"
if not "x%~1"=="x" set "parent=%~f1"
if exist "%parent%" (
    pushd "%parent%" >nul 2>&1
    if errorlevel 1 (
        echo %parent% is not folder.
        exit /b 1
    )
) else (
    mkdir "%parent%">nul 2>&1
    if errorlevel 1 (
        echo Failed to create parent folder : %parent%
        exit /b 1
    )
)

:mktmp
set "tmpdir=%parent%\tmp~%random%"
if exist "%tmpdir%" goto :mktmp
echo %tmpdir%