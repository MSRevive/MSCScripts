#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowBroadhead : CGameScript
{
	float ARROW_BREAK_CHANCE;
	int ARROW_SOLIDIFY_ON_WALL;
	int CLFX_ARROW;
	int MODEL_BODY_OFS;
	int PROJ_DAMAGE;
	int PROJ_STICK_DURATION;
	string SPRITE_ARROW_TRADE;

	ProjArrowBroadhead()
	{
		CLFX_ARROW = 1;
		SPRITE_ARROW_TRADE = "broadarrow";
		MODEL_BODY_OFS = 0;
		PROJ_DAMAGE = RandomInt(200, 300);
		PROJ_STICK_DURATION = 25;
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 0.2;
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
