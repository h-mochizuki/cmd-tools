@echo off
setlocal EnableDelayedExpansion
rem =============================================
rem                show datetime
rem ---------------------------------------------
rem  usage:
rem    datetime [format]
rem    # datetime yyyy/mm/dd hh:mi:ss
rem    # 2019/12/09 10:36:54
rem  format:
rem    yyyy, y4    : four digits 'year'
rem    yy, y2      : last tow digits 'year'
rem    mm, mo, m12 : 'month'
rem    dd          : 'day'
rem    ampm, ap    : 'am' or 'pm'
rem    hh, h24     : 24-'hour' notation
rem    h12         : 12-'hour' notation
rem    mi          : 'minuts'
rem    ss          : 'seconds'
rem =============================================
set "FORMAT=%*"
set "NOW=%TIME: =0%"
set "NOW=%DATE% %NOW:~0,8%"
if "x%FORMAT%"=="x" echo %NOW%&exit /b
set "H12=%NOW:~11,2%"
set "AMPM=AM"
if %H12% gtr 12 (
    set "AMPM=PM"
    set /a H12=1%H12%-12
    set "H12=%H12:~1,2%"
)
set FORMAT=!FORMAT:YYYY=%NOW:~0,4%!
set FORMAT=!FORMAT:Y4=%NOW:~0,4%!
set FORMAT=!FORMAT:YY=%NOW:~2,2%!
set FORMAT=!FORMAT:Y2=%NOW:~2,2%!
set FORMAT=!FORMAT:MM=%NOW:~5,2%!
set FORMAT=!FORMAT:MO=%NOW:~5,2%!
set FORMAT=!FORMAT:M12=%NOW:~5,2%!
set FORMAT=!FORMAT:DD=%NOW:~8,2%!
set FORMAT=!FORMAT:AMPM=%AMPM%!
set FORMAT=!FORMAT:AP=%AMPM%!
set FORMAT=!FORMAT:HH=%NOW:~11,2%!
set FORMAT=!FORMAT:H24=%NOW:~11,2%!
set FORMAT=!FORMAT:H12=%H12%!
set FORMAT=!FORMAT:M60=%NOW:~14,2%!
set FORMAT=!FORMAT:mm=%NOW:~14,2%!
set FORMAT=!FORMAT:MI=%NOW:~14,2%!
set FORMAT=!FORMAT:SS=%NOW:~17,2%!
echo %FORMAT%
