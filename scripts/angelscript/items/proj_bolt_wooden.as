#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjBoltWooden : CGameScript
{
	ProjBoltWooden()
	{
		const int HITSCAN_BOLT = 1;
		const int MODEL_BODY_OFS = 0;
		const int PROJ_DAMAGE = 110;
		const int PROJ_STICK_DURATION = 25;
		const int ARROW_SOLIDIFY_ON_WALL = 1;
		const float ARROW_BREAK_CHANCE = 0.01;
	}

	void arrow_spawn()
	{
		SetName("Wooden Bolt");
		SetDescription("A primitive crossbow bolt");
		SetWeight(0.1);
		SetSize(1);
		SetValue(10);
		SetGravity(0);
		SetGroupable(25);
	}

}

}
