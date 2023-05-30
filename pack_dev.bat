::This batch file will automatically update the beta_date.script and compile the scripts for for dev testing

@ECHO OFF
:loop
title Packing TEST SC.DLL %date% %time%
echo Packing not-safe for client test patch
echo.

cd .\scripts
echo Setting time stamp.
echo { >beta_date.script
echo 	const BETA_TIMESTAMP "CANARY: %date% %time%" >>beta_date.script
echo } >>beta_date.script
echo Compiling...
cd ../

echo ====================== Compiling...
scriptpack.exe -vef
pause