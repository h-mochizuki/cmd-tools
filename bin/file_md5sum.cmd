@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo             Show md5sum hash.
echo ---------------------------------------------
echo  usage:
echo    file_md5sum [file]...
echo  ex:
echo    file_md5sum file -^> 2786...
echo  args:
echo    1+: file path
echo;
echo  caution:
echo    argment is required.
echo    ex) file_md5sum -^> FREEZE!! WAIT INPUT.
echo =============================================
exit /b 1
:main
call %~dp0path_include
for /f "usebackq tokens=*" %%i in (`str.stream %*`) do (
    certutil -hashfile "%%~fi" MD5 | findstr /V /B "CertUtil: "
)