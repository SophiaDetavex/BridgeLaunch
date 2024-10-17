@echo off
cls
echo Program version is v4.5
REM Written for <CENSORED> by Sophia <CENSORED>, :D
::::::::::::::::::::::::::::::::::::::::::::
:: Automatically check & get admin rights V2
::::::::::::::::::::::::::::::::::::::::::::
@echo off
ECHO.
ECHO =============================
ECHO Running Admin shell
ECHO =============================
:init
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion
:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )
:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
ECHO **************************************
ECHO Invoking UAC for Privilege Escalation
ECHO **************************************
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /B
:gotPrivileges
setlocal & pushd .
cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
echo ::::::::::::::::::::::::::::
echo ::START
echo ::::::::::::::::::::::::::::
goto :MainFunc
:MainFunc
  echo/I now have Admin rights!
  echo/
  echo/Arguments using %%args%%:    %args%
  echo/Arguments using %%*: %*
  echo/%%1= %~1
  echo/%%2= %~2
  echo/%%3= %~3
  echo/
  echo/Current Directory: %CD%
  echo/
  echo/This file: %0
  echo/
  REM Set color.
  color 0c
  REM Go to game path.
  pushd "%~dp0"
  REM Run QRes.
  "%~dp0\qres.exe" /x 1920 /y 1080
  REM Before the game has ran, we send a little message to Jon here NOT to close this window, in case he forgets :)
  echo DO NOT CLOSE WHILE GAME IS IN PROGRESS... LOADING...
  REM Run the game.
  call "%~dp0\stbc.exe"
  "%~dp0\qres.exe" /x 2560 /y 1600
  echo Script written by SophieDev.
  echo Hope you enjoyed your playtime, user :D
  echo Also:
  echo Resolution has been set back. Please press enter to exit.
  pause>nul
  exit
