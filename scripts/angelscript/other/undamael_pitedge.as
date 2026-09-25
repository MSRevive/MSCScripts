#pragma context server

#include "monsters/debug.as"

namespace MS
{

class UndamaelPitedge : CGameScript
{
	string LAST_TOUCH;
	string RAND_ID;
	string UNDAMAEL_ID;

	UndamaelPitedge()
	{
		SetCallback("touch", "enable");
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if (!(param1 == UNDAMAEL_ID)) return;
		if (!(GetGameTime() > LAST_TOUCH)) return;
		CallExternal(UNDAMAEL_ID, "ext_pitedge_touch");
		LAST_TOUCH = GetGameTime();
		LAST_TOUCH += 0.1;
	}

	void undamael_spawn()
	{
		UNDAMAEL_ID = FindEntityByName("undamael");
	}

	void bd_debug()
	{
		if (RAND_ID == "RAND_ID")
		{
			SetName("pitedge");
			RAND_ID = RandomInt(1000, 9999);
		}
	}

}

}
