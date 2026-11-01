#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowSilvertipped : CGameScript
{
	float ARROW_BREAK_CHANCE;
	int ARROW_EXPIRE_DELAY;
	int ARROW_SOLIDIFY_ON_WALL;
	int CLFX_ARROW;
	int MODEL_BODY_OFS;
	int PROJ_DAMAGE;
	int PROJ_STICK_DURATION;
	string SPRITE_ARROW_TRADE;

	ProjArrowSilvertipped()
	{
		CLFX_ARROW = 1;
		ARROW_EXPIRE_DELAY = 5;
		SPRITE_ARROW_TRADE = "silverarrow";
		MODEL_BODY_OFS = 6;
		PROJ_DAMAGE = RandomInt(120, 140);
		PROJ_STICK_DURATION = 45;
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 0.2;
	}

	void arrow_spawn()
	{
		SetName("Elven Arrow");
		SetDescription("Light , elven arrows. Long distance in trade for poor damage");
		SetWeight(0.1);
		SetSize(1);
		SetValue(3);
		SetGravity(0.5);
		SetGroupable(25);
	}

}

}
