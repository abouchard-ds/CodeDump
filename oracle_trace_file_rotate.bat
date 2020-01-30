::@ECHO OFF 
SETLOCAL ENABLEEXTENSIONS

:: Alexandre Bouchard
:: January 2020
:: --------------------------------------------------
:: This script is used to zip and archive trace files.
:: this does not follow best practices, only quick script.

TITLE Oracle Trace Files Rotate

SET logdate=%date:~-4%%date:~3,2%%date:~0,2%
SET Now=%Time: =0%
SET logtime=%Now:~0,2%%Now:~3,2%

:: ---------------------------------
:: FOR CLIENT TRACE FILES
:: ---------------------------------
:: mv all *.trc and *.trm to the folder
cd D:\oracle\diag\clients\user_SYSTEM\host_number\trace\

rmdir traceFiles
mkdir traceFiles

move *.trc traceFiles\
move *.trm traceFiles\


:: zip that folder and delete the input
zip -q -m -r "traceFiles_%logdate%-%logtime%.zip" traceFiles\*.*

:: mv the zip to archive
move "traceFiles_%logdate%-%logtime%.zip" "archives\traceFiles_%logdate%-%logtime%.zip"

:: ---------------------------------
:: FOR LISTENER TRACE FILES
:: ---------------------------------
cd D:\oracle\diag\tnslsnr\DBNAME\listener\trace

rmdir traceFiles
mkdir traceFiles

move *.trc traceFiles\
move *.trm traceFiles\

zip -q -m -r "traceFiles_%logdate%-%logtime%.zip" traceFiles\*.*

move "traceFiles_%logdate%-%logtime%.zip" "archives\traceFiles_%logdate%-%logtime%.zip"

:: ---------------------------------
:: FOR DATABASE TRACE FILES
:: ---------------------------------
cd D:\oracle\diag\rdbms\INSTID\INSTID\trace

rmdir traceFiles
mkdir traceFiles

move *.trc traceFiles\
move *.trm traceFiles\

zip -q -m -r "traceFiles_%logdate%-%logtime%.zip" traceFiles\*.*

move "traceFiles_%logdate%-%logtime%.zip" Alert_log_Archives\traceFiles_%logdate%-%logtime%.zip"
