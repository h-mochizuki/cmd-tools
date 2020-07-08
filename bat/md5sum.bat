@echo off
setlocal
rem =============================================
rem                 show md5
rem ---------------------------------------------
rem  usage:
rem    md5sum [file]...
rem =============================================
set ARGORISM=MD5
if "x%~1"=="x" (
    for /f "usebackq tokens=*" %%i in (`findstr .*`) do certutil -hashfile "%%~fi" %ARGORISM% | findstr /V /B "CertUtil: "
) else (
    for %%i in ( %* ) do certutil -hashfile "%%~fi" %ARGORISM% | findstr /V /B "CertUtil: "
)