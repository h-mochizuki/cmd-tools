@echo off
setlocal
if not "x%~1"=="x/?" goto :main
echo =============================================
echo            Convert to lowercase.
echo ---------------------------------------------
echo  usage:
echo    str_lower [option] string[...]
echo  ex:
echo    str_lower STRING -^> string
echo  options:
echo\   /?: show this usage.
echo  args:
echo    string: target string
echo;
echo  caution:
echo    argment is required.
echo    ex) str_lower -^> FREEZE!! WAIT INPUT.
echo =============================================
exit /b 1
:main
if "x%~1"=="x" (
    for /f "usebackq tokens=*" %%i in (`findstr .*`) do call :lowercase %%i
) else (
    call :lowercase %*
)
exit /b

:lowercase
set "s=%*"
set "s=%s:A=a%"
set "s=%s:B=b%"
set "s=%s:C=c%"
set "s=%s:D=d%"
set "s=%s:E=e%"
set "s=%s:F=f%"
set "s=%s:G=g%"
set "s=%s:H=h%"
set "s=%s:I=i%"
set "s=%s:J=j%"
set "s=%s:K=k%"
set "s=%s:L=l%"
set "s=%s:M=m%"
set "s=%s:N=n%"
set "s=%s:O=o%"
set "s=%s:P=p%"
set "s=%s:Q=q%"
set "s=%s:R=r%"
set "s=%s:S=s%"
set "s=%s:T=t%"
set "s=%s:U=u%"
set "s=%s:V=v%"
set "s=%s:W=w%"
set "s=%s:X=x%"
set "s=%s:Y=y%"
set "s=%s:Z=z%"
echo %s%
