#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjBoltWooden : CGameScript
{
	float ARROW_BREAK_CHANCE;
	int ARROW_SOLIDIFY_ON_WALL;
	int HITSCAN_BOLT;
	int MODEL_BODY_OFS;
	int PROJ_DAMAGE;
	int PROJ_STICK_DURATION;

	ProjBoltWooden()
	{
		HITSCAN_BOLT = 1;
		MODEL_BODY_OFS = 0;
		PROJ_DAMAGE = 110;
		PROJ_STICK_DURATION = 25;
		ARROW_SOLIDIFY_ON_WALL = 1;
		ARROW_BREAK_CHANCE = 0.01;
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
