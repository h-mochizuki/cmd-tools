@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo            Convert to uppercase.
echo ---------------------------------------------
echo  usage:
echo    str_upper [option] string[...]
echo  ex:
echo    str_upper string -^> STRING
echo  options:
echo\   /?: show this usage.
echo  args:
echo    string: target string
echo;
echo  caution:
echo    argment is required.
echo    ex) str_upper -^> FREEZE!! WAIT INPUT.
echo =============================================
exit /b 1
:main
if "x%~1"=="x" (
    for /f "usebackq tokens=*" %%i in (`findstr .*`) do call :uppercase %%i
) else (
    call :uppercase %*
)
exit /b

:uppercase
set "s=%*"
set "s=%s:a=A%"
set "s=%s:b=B%"
set "s=%s:c=C%"
set "s=%s:d=D%"
set "s=%s:e=E%"
set "s=%s:f=F%"
set "s=%s:g=G%"
set "s=%s:h=H%"
set "s=%s:i=I%"
set "s=%s:j=J%"
set "s=%s:k=K%"
set "s=%s:l=L%"
set "s=%s:m=M%"
set "s=%s:n=N%"
set "s=%s:o=O%"
set "s=%s:p=P%"
set "s=%s:q=Q%"
set "s=%s:r=R%"
set "s=%s:s=S%"
set "s=%s:t=T%"
set "s=%s:u=U%"
set "s=%s:v=V%"
set "s=%s:w=W%"
set "s=%s:x=X%"
set "s=%s:y=Y%"
set "s=%s:z=Z%"
echo %s%
