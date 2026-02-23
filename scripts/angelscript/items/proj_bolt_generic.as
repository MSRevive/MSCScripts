#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjBoltGeneric : CGameScript
{
	ProjBoltGeneric()
	{
		const int HITSCAN_BOLT = 1;
		const int MODEL_BODY_OFS = 0;
		const int PROJ_DAMAGE = 100;
		const int PROJ_STICK_DURATION = 25;
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 0.01;
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
