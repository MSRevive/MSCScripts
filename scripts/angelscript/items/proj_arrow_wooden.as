#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowWooden : CGameScript
{
	ProjArrowWooden()
	{
		const int CLFX_ARROW = 1;
		const int MODEL_BODY_OFS = 0;
		const string PROJ_DAMAGE = RandomInt(60, 90);
		const int ARROW_STICK_DURATION = 10;
		const int ARROW_SOLIDIFY_ON_WALL = 1;
		const float ARROW_BREAK_CHANCE = 0.2;
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
