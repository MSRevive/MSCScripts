#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjThorn : CGameScript
{
	ProjThorn()
	{
		const string PROJ_ANIM_IDLE = "idle_standard";
		const string PROJ_DAMAGE = RandomInt(60, 90);
		const int PROJ_STICK_DURATION = 0;
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 1.0;
		const int MODEL_BODY_OFS = 24;
		const int ARROW_BODY_OFS = 24;
		const string PROJ_ANIM_IDLE = "idle_icebolt";
		const string ROJ_DAMAGETYPE = "pierce";
		const string PROJ_DAMAGE = Random(4, 8);
		const string MODEL_WORLD = "weapons/projectiles.mdl";
	}

	void arrow_spawn()
	{
		SetName("large thorn");
		SetDescription("a large thorn");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.0);
		SetUseable(0);
	}

}

}
