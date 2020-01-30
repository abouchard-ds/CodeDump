::@ECHO OFF 
SETLOCAL ENABLEEXTENSIONS

:: Alexandre Bouchard
:: December 2019
:: --------------------------------------------------
:: This script is used to rotate Oracle's logs.
:: All parameters are kept in the file, as variables.

:: TODO: use windows array so we may loop all logs folders in the same code. but since 
::       the system will be decom., may not have time for that.

TITLE Oracle Logs Rotate

SET logdate=%date:~-4%%date:~3,2%%date:~0,2%
SET Now=%Time: =0%
SET logtime=%Now:~0,2%%Now:~3,2%

:: ------------ listener logs 

if exist blabla\listener\trace (
	cd blabla\listener\trace
) else (
	echo 'Folder does not exists.'
	exit
)

if exist listener.log (
	move listener.log listener_%logdate%-%logtime%.log
	zip -q -m "listener_%logdate%-%logtime%.zip" "listener_%logdate%-%logtime%.log"
) else (
	echo 'Logfile not found.'
	exit
)

ForFiles /p blabla\listener\trace /s /d -30 /c "cmd /c del @file"

:: ------------ database logs 
if exist blabla\trace (
	cd blabla\trace
) else (
	echo 'Folder does not exists.'
	exit
)

if exist alert_blabla01.log (
	move alert_blabla01.log alert_blabla01_%logdate%-%logtime%.log
	zip -q -m "alert_blabla01_%logdate%-%logtime%.zip" "alert_blabla01_%logdate%-%logtime%.log"
) else (
	echo 'Logfile not found.'
	exit
)


:: enable later, need to keep archives first
:: ForFiles /p blabla\trace /s /d -365 /c "cmd /c del @file"
