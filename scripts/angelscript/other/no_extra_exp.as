#pragma context server

#include "monsters/base_temporary.as"

namespace MS
{

class NoExtraExp : CGameScript
{
	NoExtraExp()
	{
	}

	void OnSpawn() override
	{
		if (!(GetCvar("ms_difficulty"))) return;
		SetGlobalVar("G_PLAYER_RAMP", 0);
		SendInfoMsg("all", "NO BONUS XP Bonus experience is blocked on this map. Monsters will not scale per player on server.");
	}

}

}
