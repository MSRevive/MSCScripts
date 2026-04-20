#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowWooden : CGameScript
{
	float ARROW_BREAK_CHANCE;
	int ARROW_SOLIDIFY_ON_WALL;
	int ARROW_STICK_DURATION;
	int CLFX_ARROW;
	int MODEL_BODY_OFS;
	int PROJ_DAMAGE;

	ProjArrowWooden()
	{
		CLFX_ARROW = 1;
		MODEL_BODY_OFS = 0;
		PROJ_DAMAGE = RandomInt(60, 90);
		ARROW_STICK_DURATION = 10;
		ARROW_SOLIDIFY_ON_WALL = 1;
		ARROW_BREAK_CHANCE = 0.2;
	}

	void arrow_spawn()
	{
		SetName("Wooden Arrow");
		SetDescription("A wooden arrow");
		SetWeight(0.1);
		SetSize(1);
		SetValue(1);
		SetGravity(0.7);
		SetGroupable(25);
	}

}

}
