#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowHoly : CGameScript
{
	ProjArrowHoly()
	{
		const int CLFX_ARROW = 1;
		const string SPRITE_ARROW_TRADE = "firearrow";
		const int MODEL_BODY_OFS = 0;
		const string PROJ_DAMAGE_TYPE = "holy";
		const int PROJ_DAMAGE = 300;
		const int ARROW_STICK_DURATION = 5;
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 0.5;
		const int ARROW_EXPIRE_DELAY = 5;
	}

	void arrow_spawn()
	{
		SetName("Holy Arrow");
		SetDescription("An arrow imbued with divine energies");
		SetWeight(0.125);
		SetSize(1);
		SetValue(300);
		SetGravity(0.8);
		SetGroupable(25);
	}

}

}
