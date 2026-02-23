#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjBoltIron : CGameScript
{
	ProjBoltIron()
	{
		const int HITSCAN_BOLT = 1;
		const int MODEL_BODY_OFS = 0;
		const int PROJ_DAMAGE = 300;
		const int PROJ_STICK_DURATION = 25;
		const int ARROW_SOLIDIFY_ON_WALL = 1;
		const float ARROW_BREAK_CHANCE = 0.2;
	}

	void arrow_spawn()
	{
		SetName("Iron Bolt");
		SetDescription("A crossbow bolt made of iron");
		SetWeight(0.15);
		SetSize(1);
		SetValue(75);
		SetGravity(0);
		SetGroupable(25);
	}

}

}
