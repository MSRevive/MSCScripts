#pragma context server

#include "monsters/debug.as"

namespace MS
{

class UndamaelHurt : CGameScript
{
	string LAST_TOUCH;
	string RAND_ID;
	string UNDAMAEL_ID;

	UndamaelHurt()
	{
		SetCallback("touch", "enable");
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if (!(param1 != UNDAMAEL_ID)) return;
		LogDebug("touching something not undamael!");
		if (!(GetGameTime() > LAST_TOUCH)) return;
		LAST_TOUCH = GetGameTime();
		LAST_TOUCH += 0.5;
		if (!(IsEntityAlive(param1))) return;
		if ((IsEntityAlive(UNDAMAEL_ID)))
		{
			ShowHelpTip(param1, "generic", "BEWARE", "The lava Undmael rests in acts as his digestive system. Undamael has gained", GetEntityHealth(param1), "health.");
			HealEntity(UNDAMAEL_ID, GetEntityHealth(param1));
		}
		if ("UNDAMAEL_ID" != UNDAMAEL_ID)
		{
			XDoDamage(param1, "direct", 10000, 1.0, UNDAMAEL_ID, UNDAMAEL_ID, "none", "target");
		}
		else
		{
			if ((IsValidPlayer(param1)))
			{
				KillEntity(param1);
			}
			else
			{
				XDoDamage(param1, "direct", 10000, 1.0, GAME_MASTER, GAME_MASTER, "none", "target");
			}
		}
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
