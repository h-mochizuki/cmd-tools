@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo       Return unused temporary file path.
echo ---------------------------------------------
echo  usage:
echo    file_temp [option] [folder] [extension]
echo  ex:
echo    file_temp -^> %%temp%%\bat~123.tmp
echo  options:
echo\   /?: show this usage.
echo  args:
echo    folder   : parent folder path
echo               (%%temp%% when empty)
echo    extension: filename extension
echo               (append tmp when empty)
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
set "postfix=tmp"
if not "x%~2"=="x" set "postfix=%~2"

:mktmp
set "tmpfile=%parent%\bat~%random%.%postfix%"
if exist "%tmpfile%" goto :mktmp
echo %tmpfile%