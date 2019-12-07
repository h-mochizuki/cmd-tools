@echo off
setlocal
rem =============================================
rem                 show md5
rem ---------------------------------------------
rem  usage:
rem    md5sum [file]...
rem =============================================
set TPATH=%*
set ARGORISM=MD5
if "x%TPATH%"=="x" (
    for /f "usebackq tokens=*" %%i in (`findstr .*`) do certutil -hashfile %%~fi %ARGORISM% | findstr /V /B "CertUtil: "
) else (
    for %%i in ( %TPATH% ) do certutil -hashfile %%~fi %ARGORISM% | findstr /V /B "CertUtil: "
)