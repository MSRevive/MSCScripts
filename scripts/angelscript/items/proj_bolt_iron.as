#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjBoltIron : CGameScript
{
	float ARROW_BREAK_CHANCE;
	int ARROW_SOLIDIFY_ON_WALL;
	int HITSCAN_BOLT;
	int MODEL_BODY_OFS;
	int PROJ_DAMAGE;
	int PROJ_STICK_DURATION;

	ProjBoltIron()
	{
		HITSCAN_BOLT = 1;
		MODEL_BODY_OFS = 0;
		PROJ_DAMAGE = 300;
		PROJ_STICK_DURATION = 25;
		ARROW_SOLIDIFY_ON_WALL = 1;
		ARROW_BREAK_CHANCE = 0.2;
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
