@echo off
setlocal
rem =============================================
rem             check administrator role
rem ---------------------------------------------
rem  usage:
rem    is-admin
rem    # if errorlevel 1  (
rem    #   echo "not admin"
rem    # ) else (
rem    #   echo "admin"
rem    # )
rem =============================================
openfiles >nul 2>&1
