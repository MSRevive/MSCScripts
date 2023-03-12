::Packs scripts in a way that are good for a release.
::When doing do, update the version tag in this file.
::Use the version prefix. (Like "NOV2015", not "NOV2015a")

::Temporarily removes the dev folder and strips unnecessary space and comments from all scripts before compiling
::A report is also generated from cookscripts.exe in the scriptout folder reporting any errors or issues it found with scripts
::Errors will not stop scripts from compiling
::After compiling, the dev folder is replaced

@echo off

set script_path=scripts

:loop
title Packing TEST SC.DLL %date% %time%
echo.

echo.
echo ====================== Setting time stamp... 
echo.

cd .\scripts
echo { >beta_date.script
echo 	const BETA_TIMESTAMP "RELEASE: %date% %time%" >>beta_date.script
echo } >>beta_date.script
echo Done.
cd ../

echo ====================== Compiling...
scriptpack.exe -refv
echo Done.
pause