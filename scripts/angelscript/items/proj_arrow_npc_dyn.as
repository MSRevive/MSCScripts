#pragma context server

#include "items/proj_arrow_npc.as"

namespace MS
{

class ProjArrowNpcDyn : CGameScript
{
	void ext_lighten()
	{
		SetGravity(param1);
		if (param4 != "PARAM4")
		{
			SetProp(GetOwner(), "scale", param4);
		}
		if (!(param2)) return;
		Effect("glow", GetOwner(), param3, 64, -1, -1);
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), param3, 96, 3.0);
	}

	void game_dodamage()
	{
		string OUT_PAR1 = param1;
		string OUT_PAR2 = param2;
		string OUT_PAR3 = param3;
		string OUT_PAR4 = param4;
		CallExternal("ent_expowner", "ext_arrow_hit", OUT_PAR1, OUT_PAR2, OUT_PAR3, OUT_PAR4);
	}

	void projectile_landed()
	{
		CallExternal("ent_expowner", "ext_arrow_landed", GetEntityOrigin(GetOwner()));
	}

}

}
