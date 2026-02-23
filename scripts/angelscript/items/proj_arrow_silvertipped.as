#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowSilvertipped : CGameScript
{
	ProjArrowSilvertipped()
	{
		const int CLFX_ARROW = 1;
		const int ARROW_EXPIRE_DELAY = 5;
		const string SPRITE_ARROW_TRADE = "silverarrow";
		const int MODEL_BODY_OFS = 6;
		const string PROJ_DAMAGE = RandomInt(120, 140);
		const int PROJ_STICK_DURATION = 45;
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 0.2;
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
