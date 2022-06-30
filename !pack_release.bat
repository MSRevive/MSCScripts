::Packs scripts in a way that are good for a release.
::When doing do, update the version tag in this file.
::Use the version prefix. (Like "NOV2015", not "NOV2015a")

::Temporarily removes the dev folder and strips unnecessary space and comments from all scripts before compiling
::A report is also generated from cookscripts.exe in the scriptout folder reporting any errors or issues it found with scripts
::Errors will not stop scripts from compiling
::After compiling, the dev folder is replaced

@echo off

set version_tag=APR2022-rc

set script_path=scripts
set out_path=scriptout

:loop
title Packing TEST SC.DLL %date% %time%
echo REMEMBER TO UPDATE VERSION_TAG IN THIS BATCH FILE
echo Current Version tag: %version_tag%
echo.
pause
echo.
echo.
rem if "%1"=="" goto :error_par
cd .\scripts

echo.
echo ====================== Setting time stamp... 
echo.

echo.
echo { >beta_date.script
echo 	const BETA_TIMESTAMP "DEVELOPER %date% %time%" >>beta_date.script
echo 	setvarg G_SCRIPT_VERSION %version_tag% >>beta_date.script
echo } >>beta_date.script
echo Done.
cd..

echo.
echo ====================== Moving developer folder... 
echo.

move %cd%\%script_path%\developer %cd%
echo Done.

echo.
echo ====================== Clearing output folder... 
echo.

del %cd%\%out_path%\*.*
rmdir %cd%\%out_path% /s
echo Done.

echo.
echo ====================== Cooking Scripts... 
echo.

cookscripts.exe %cd%\%script_path%\ %cd%\%out_path%\
echo Done.

echo ====================== Compiling...
echo.

copy .\Scriptpack.exe %out_path%
cd %out_path%
ScriptPack.exe
echo Done.

echo.
echo ====================== Propogating...
echo.

copy .\sc.dll ..\
echo All done!
cd..

echo.
echo ====================== Moving developer folder back... 
echo.

move %cd%\developer %cd%\%script_path%
echo Done.

pause
