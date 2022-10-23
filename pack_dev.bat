::This batch file will automatically update the beta_date.script and compile the scripts for for dev testing
::Takes one argument which is the version string prefix you wish to compile for (Like "NOV2015", not "NOV2015a")
::The version string should still match with the other scripts though. Otherwise risk auto-disconnecting.

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
start cmd /c scriptpack.exe -ve ^& pause
echo Completed at %date% %time%

goto :end

:end
pause