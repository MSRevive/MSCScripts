#pragma context server

namespace MS
{

class Burn1000 : CGameScript
{
	int PLAYING_DEAD;

	Burn1000()
	{
		SetCallback("touch", "enable");
		SetProp(GetOwner(), "solid", 1);
	}

	void OnTouch(CBaseEntity@ other) override
	{
		SetName("Hot lava");
		SetRace("hated");
		PLAYING_DEAD = 1;
		SetInvincible(true);
		SetRoam(false);
		string OUT_NAME = param2;
		string BURN_DAMAGE = param3;
		if ((BURN_DAMAGE).findFirst("PARAM") == 0)
		{
			int BURN_DAMAGE = 1000;
		}
		CallExternal(GAME_MASTER, "gm_setname", OUT_NAME);
		ApplyEffect(param1, "effects/dot_fire", 2, GAME_MASTER, BURN_DAMAGE);
	}

}

}
