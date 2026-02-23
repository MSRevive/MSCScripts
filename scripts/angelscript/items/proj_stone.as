#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjStone : CGameScript
{
	ProjStone()
	{
		const string PROJ_ANIM_IDLE = "idle_standard";
		const string PROJ_DAMAGE = RandomInt(60, 90);
		const int PROJ_STICK_DURATION = 0;
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 1.0;
		const int MODEL_BODY_OFS = 3;
		const int ARROW_BODY_OFS = 3;
		const string PROJ_ANIM_IDLE = "idle_icebolt";
		const string ROJ_DAMAGETYPE = "blunt";
		const string PROJ_DAMAGE = Random(4, 8);
		const string MODEL_WORLD = "weapons/projectiles.mdl";
	}

	void arrow_spawn()
	{
		SetName("small stone");
		SetDescription("a small stone");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.6);
		SetUseable(0);
	}

}

}
