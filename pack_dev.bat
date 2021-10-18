::This batch file will automatically update the beta_date.script and compile the scripts for for dev testing
::Takes one argument which is the version string prefix you wish to compile for (Like "NOV2015", not "NOV2015a")
::The version string should still match with the other scripts though. Otherwise risk auto-disconnecting.

@ECHO OFF
:loop
title Packing TEST SC.DLL %date% %time%
echo Packing not-safe for client test patch
echo Got argument %1
echo.
if "%1"=="" goto :error_par
cd .\scripts
echo Setting time stamp.
echo { >beta_date.script
echo 	const BETA_TIMESTAMP "%date%" >>beta_date.script
echo 	setvarg G_SCRIPT_VERSION %1% >>beta_date.script
echo } >>beta_date.script
echo Compiling...
"../ScriptPack.exe"
move sc.dll "..\"
cd..
echo completed %date% %time%

goto :end

:error_par
echo NO PARAMTERS!
echo.
echo This batch file requires 7 character G_SCRIPT_VERSION param ( eg. JUN2007 )
pause

:end
pause