#pragma context server

#include "effects/base_effect.as"

namespace MS
{

class TrackGaxePickup : CGameScript
{
	string EFFECT_ID;
	string EFFECT_SCRIPT;

	TrackGaxePickup()
	{
		EFFECT_ID = "track_gaxe";
		EFFECT_SCRIPT = currentscript;
	}

	void game_removefromowner()
	{
		SetGlobalVar("G_OLDHELENA_AXE_PICKED", 1);
	}

	void game_fall()
	{
		SetGlobalVar("G_OLDHELENA_AXE_PICKED", 0);
	}

}

}
