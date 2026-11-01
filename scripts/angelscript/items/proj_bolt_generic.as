#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjBoltGeneric : CGameScript
{
	float ARROW_BREAK_CHANCE;
	int ARROW_SOLIDIFY_ON_WALL;
	int HITSCAN_BOLT;
	int MODEL_BODY_OFS;
	int PROJ_DAMAGE;
	int PROJ_STICK_DURATION;

	ProjBoltGeneric()
	{
		HITSCAN_BOLT = 1;
		MODEL_BODY_OFS = 0;
		PROJ_DAMAGE = 100;
		PROJ_STICK_DURATION = 25;
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 0.01;
	}

	void arrow_spawn()
	{
		SetName("Crossbow Bolt");
		SetDescription("A crudely made bolt");
		SetWeight(0.2);
		SetSize(1);
		SetValue(0);
		SetGravity(0);
		SetGroupable(25);
	}

}

}
