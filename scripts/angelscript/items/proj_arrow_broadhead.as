#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowBroadhead : CGameScript
{
	ProjArrowBroadhead()
	{
		const int CLFX_ARROW = 1;
		const string SPRITE_ARROW_TRADE = "broadarrow";
		const int MODEL_BODY_OFS = 0;
		const string PROJ_DAMAGE = RandomInt(200, 300);
		const int PROJ_STICK_DURATION = 25;
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 0.2;
	}

	void arrow_spawn()
	{
		SetName("Iron Arrow");
		SetDescription("Great damage in trade for short range");
		SetWeight(0.125);
		SetSize(1);
		SetValue(5);
		SetGravity(0.85);
	}

}

}
