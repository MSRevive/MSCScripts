#pragma context server

namespace MS
{

class MultisourceFix : CGameScript
{
	string LAST_TOUCHED;
	int ME_ACTIVE;

	MultisourceFix()
	{
		SetCallback("touch", "enable");
		SetProp(GetOwner(), "solid", 1);
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if ((ME_ACTIVE)) return;
		if (!(IsValidPlayer(param1))) return;
		float TIME_DIFF = GetGameTime();
		TIME_DIFF -= LAST_TOUCHED;
		if (!(TIME_DIFF > 2.0)) return;
		LAST_TOUCHED = GetGameTime();
		ME_ACTIVE = 1;
		CallExternal(GAME_MASTER, "calruin2_trigger_touched");
	}

	void calruin2_trigger_reset()
	{
		ME_ACTIVE = 0;
	}

}

}
