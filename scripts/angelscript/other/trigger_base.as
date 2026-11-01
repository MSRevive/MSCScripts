#pragma context server

namespace MS
{

class TriggerBase : CGameScript
{
	string EFFECT_DAMAGE;
	int EFFECT_TIME;
	string LAST_DMG;

	TriggerBase()
	{
		SetCallback("touch", "enable");
		SetProp(GetOwner(), "solid", 1);
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if (!(GetGameTime() > LAST_DMG)) return;
		string OUT_NAME = param2;
		EFFECT_DAMAGE = param3;
		if ((EFFECT_DAMAGE).findFirst("PARAM") == 0)
		{
			int BURN_DAMAGE = 1000;
		}
		EFFECT_TIME = 2;
		if ((EFFECT_DAMAGE).findFirst(";") >= 0)
		{
			EFFECT_DAMAGE = GetToken(param3, 0, ";");
			EFFECT_TIME = GetToken(param3, 1, ";");
			if ((param3).findFirst("no_monsters") >= 0)
			{
				int PLAYER_ONLY = 1;
			}
		}
		CallExternal(GAME_MASTER, "gm_setname", OUT_NAME);
		if ((PLAYER_ONLY))
		{
			if (!(IsValidPlayer(param1)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		LAST_DMG = GetGameTime();
		LAST_DMG += EFFECT_TIME;
		apply_damage(GetEntityIndex(param1));
	}

}

}
