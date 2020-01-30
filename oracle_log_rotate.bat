::@ECHO OFF 
SETLOCAL ENABLEEXTENSIONS

:: Alexandre Bouchard
:: December 2019
:: --------------------------------------------------
:: This script is used to rotate Oracle's logs.
:: All parameters are kept in the file, as variables.

TITLE Oracle Logs Rotate

SET logdate=%date:~-4%%date:~3,2%%date:~0,2%
SET Now=%Time: =0%
SET logtime=%Now:~0,2%%Now:~3,2%

:: ------------ listener logs 

if exist D:\oracle\diag\tnslsnr\DBNAME\listener\trace (
	cd D:\oracle\diag\tnslsnr\DBNAME\listener\trace
) else (
	echo 'Folder does not exists.'
	exit
)

if exist listener.log (
	move listener.log listener_%logdate%-%logtime%.log
	zip -q -m "listener_%logdate%-%logtime%.zip" "listener_%logdate%-%logtime%.log"
	move "listener_%logdate%-%logtime%.zip" "archives\listener_%logdate%-%logtime%.zip"
) else (
	echo 'Logfile not found.'
	exit
)

:: enable later if needed
:: ForFiles /p D:\oracle\diag\tnslsnr\DBNAME\listener\trace /s /d -30 /c "cmd /c del @file"

:: ------------ database logs 
if exist D:\oracle\diag\rdbms\instid\instid\trace (
	cd D:\oracle\diag\rdbms\instid\instid\trace
) else (
	echo 'Folder does not exists.'
	exit
)

if exist alert_instid.log (
	move alert_instid.log alert_instid_%logdate%-%logtime%.log
	zip -q -m "alert_instid_%logdate%-%logtime%.zip" "alert_instid_%logdate%-%logtime%.log"
	move "alert_instid_%logdate%-%logtime%.zip" "Alert_log_Archives\alert_instid_%logdate%-%logtime%.zip"
) else (
	echo 'Logfile not found.'
	exit
)


:: enable later, need to keep archives first
:: ForFiles /p D:\oracle\diag\rdbms\prdsyn01\prdsyn01\trace /s /d -365 /c "cmd /c del @file"
