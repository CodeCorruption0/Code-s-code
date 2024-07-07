<!-- : BATCH
@echo off & cd /d "%~dp0"
@cscript //nologo "%~f0?.wsf"
Setlocal EnableExtensions EnableDelayedExpansion
color a
:noTextCursor-menu
 For /f %%e in ('Echo Prompt $E^|cmd') Do set "\E=%%e"
 <nul Set /P "=%\E%[?25l"
 Set /A "delay=4", "Files=0","FC=1"

 For %%i in (5 6 7 8 9 10 11 12 13 14 15 14 13 12 11 10 9 8 7 6 5)Do (
  Set /A Files+=1
  Call :menu %%i "infile!Files!.txt"
 )

 For /L %%i in ()Do (
  for /f "tokens=1-4 delims=:.," %%a in ("!time: =0!") do set /a "t2=(((1%%a*60)+1%%b)*60+1%%c)*100+1%%d-36610100, tDiff=t2-t1"
  if !tDiff! lss 0 set /a tDiff+=24*60*60*100
  if !tDiff! geq !delay! (
   Set /A "FC=FC %% Files + 1"
   <nul Set /P "=%\E%[1;0H"
   If !FC! GTR 10 (If !Offset! GTR 1 Set /A "Offset-=1")Else Set "offset=!FC!"
   (For /f "Delims=" %%G in (infile!FC!.txt)Do echo ^[[K%\E%[!offset!G%%G%\E%[E") > Con
   echo ^[[0J
   set /a t1=t2
  )
 )

:menu
cls
echo Welcome to the clock! The retake of the app on your phone!
echo %\E%
echo 11. Date ^& Time
echo 2. Stopwatch
echo 3. Timer
choice /c 123 /m "Enter your choice (1-3): " /n
cls
if "%errorlevel%"=="1" goto dnt
if "%errorlevel%"=="2" goto noTextCursor-stopwatch
if "%errorlevel%"=="3" goto input-days

:noTextCursor-stopwatch
set "start_time=%time%"
 For /f %%e in ('Echo Prompt $E^|cmd') Do set "\E=%%e"
 <nul Set /P "=%\E%[?25l"
 Set /A "delay=4", "Files=0","FC=1"

 For %%i in (5 6 7 8 9 10 11 12 13 14 15 14 13 12 11 10 9 8 7 6 5)Do (
  Set /A Files+=1
  Call :stopwatch %%i "infile!Files!.txt"
 )

 For /L %%i in ()Do (
  for /f "tokens=1-4 delims=:.," %%a in ("!time: =0!") do set /a "t2=(((1%%a*60)+1%%b)*60+1%%c)*100+1%%d-36610100, tDiff=t2-t1"
  if !tDiff! lss 0 set /a tDiff+=24*60*60*100
  if !tDiff! geq !delay! (
   Set /A "FC=FC %% Files + 1"
   <nul Set /P "=%\E%[1;0H"
   If !FC! GTR 10 (If !Offset! GTR 1 Set /A "Offset-=1")Else Set "offset=!FC!"
   (For /f "Delims=" %%G in (infile!FC!.txt)Do echo ^[[K%\E%[!offset!G%%G%\E%[E") > Con
   echo ^[[0J
   set /a t1=t2
  )
 )
 
:stopwatch
<nul set /p "=%\E%[H"
for /f "tokens=1-4 delims=:.," %%a in ("%start_time%") do (
    set /a "start_h=%%a", "start_m=1%%b-100", "start_s=1%%c-100", "start_ms=1%%d-100"
)
set "end_time=%time%"
for /f "tokens=1-4 delims=:.," %%a in ("%end_time%") do (
    set /a "end_h=%%a", "end_m=1%%b-100", "end_s=1%%c-100", "end_ms=1%%d-100"
)
set /a "elapsed_ms=(end_h*3600000+end_m*60000+end_s*1000+end_ms)-(start_h*3600000+start_m*60000+start_s*1000+start_ms)"

set /a "elapsed_h=elapsed_ms/3600000, elapsed_ms%%=3600000"
set /a "elapsed_m=elapsed_ms/60000, elapsed_ms%%=60000"
set /a "elapsed_s=elapsed_ms/1000, elapsed_ms%%=1000"
set "elapsed_ms=0%elapsed_ms%"
set "elapsed=!elapsed_h!:!elapsed_m!:!elapsed_s!.!elapsed_ms:~-3!"
set "end_time=%time%"

echo %elapsed%
choice /c xc /t 1 /d c >nul
if errorlevel 2 goto stopwatch
if errorlevel 1 goto menu

:input-days
<nul set /p "=%\E%[H"
set /p "days=How many days?: "
if not defined days goto input-days
goto input-hours

:input-hours
<nul set /p "=%\E%[H"
set /p "hours=How many hours?: "
if not defined hours goto input-hours
goto input-minutes

:input-minutes
<nul set /p "=%\E%[H"
set /p "minutes=How many minutes?: "
if not defined minutes goto input-minutes
goto input-seconds

:input-seconds
<nul set /p "=%\E%[H"
set /p "seconds=How many seconds?: "
if not defined seconds goto input-seconds
goto check-seconds

:check-seconds
if %seconds% geq 60 (
	set /a minutes+=1
	set /a seconds-=1
)
goto check-minutes

:check-minutes
if %seconds% geq 60 (
	goto check-seconds
)

if %minutes% geq 60 (
	set /a hours+=1
	set /a minutes-=1
)
goto check-hours

:check-hours
if %minutes% geq 60 (
	goto check-minutes
)

if %hours% gtr 24 (
	set /a days+=1
	set /a hours-=24
)
goto noTextCursor-timer

:noTextCursor-timer
 For /f %%e in ('Echo Prompt $E^|cmd') Do set "\E=%%e"
 <nul Set /P "=%\E%[?25l"
 Set /A "delay=4", "Files=0","FC=1"

 For %%i in (5 6 7 8 9 10 11 12 13 14 15 14 13 12 11 10 9 8 7 6 5)Do (
  Set /A Files+=1
  Call :timer %%i "infile!Files!.txt"
 )

 For /L %%i in ()Do (
  for /f "tokens=1-4 delims=:.," %%a in ("!time: =0!") do set /a "t2=(((1%%a*60)+1%%b)*60+1%%c)*100+1%%d-36610100, tDiff=t2-t1"
  if !tDiff! lss 0 set /a tDiff+=24*60*60*100
  if !tDiff! geq !delay! (
   Set /A "FC=FC %% Files + 1"
   <nul Set /P "=%\E%[1;0H"
   If !FC! GTR 10 (If !Offset! GTR 1 Set /A "Offset-=1")Else Set "offset=!FC!"
   (For /f "Delims=" %%G in (infile!FC!.txt)Do echo ^[[K%\E%[!offset!G%%G%\E%[E") > Con
   echo ^[[0J
   set /a t1=t2
  )
 )

:timer
<nul set /p "=%\E%[H"
if "%days%"=="1" (
	set "dayAmount=day"
) else (
	set "dayAmount=days"
)

if "%hours%"=="1" (
	set "hourAmount=hour"
) else (
	set "hourAmount=Hours"
)

if "%minutes%"=="1" (
	set "minuteAmount=minute"
) else (
	set "minuteAmount=minutes"
)

if "%seconds%"=="1" (
	set "secondAmount=second"
) else (
	set "secondAmount=seconds"
)

echo Timer: %days% %dayAmount%, %hours% %hourAmount%, %minutes% %minuteAmount%, ^& %seconds% %secondAmount% remaining.
timeout /t 1 /nobreak >nul
set /a seconds-=1
if %seconds% leq 0 (
	set /a minutes-=1
	set seconds=59
)
if %minutes% leq 0 (
	set /a hours-=1
	set minutes=59
)
if %hours% leq 0 (
	set /a days-=1
	set hours=23
)
if %days% equ -1 (
	goto end-timer
)
set check=seconds+minutes+hours+days
if %check% leq 0 (
	goto end-timer
)
goto timer

:end-timer
cls
echo The timer has finished!
pause >nul
goto menu

:dnt
cls
date /t & time /t
pause >nul
goto noTextCursor-menu
BATCH : --->
<job><script language="VBScript">
set x = CreateObject ("WScript.Shell")
x.SendKeys "{f11}"
</script></job>
