#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowJagged : CGameScript
{
	ProjArrowJagged()
	{
		const int CLFX_ARROW = 1;
		const int MODEL_BODY_OFS = 0;
		const string SPRITE_ARROW_TRADE = "silverarrow";
		const string PROJ_DAMAGE = RandomInt(275, 375);
		const int PROJ_STICK_DURATION = 25;
		const int ARROW_SOLIDIFY_ON_WALL = 1;
		const float ARROW_BREAK_CHANCE = 0.2;
	}

	void arrow_spawn()
	{
		SetName("Jagged Arrow");
		SetDescription("When the target moves , the jags wound it");
		SetWeight(0.15);
		SetSize(3);
		SetValue(50);
		SetGravity(0.8);
		SetHUDSprite("hand", "arrows");
		SetHUDSprite("trade", SPRITE_ARROW_TRADE);
		SetHand("any");
	}

}

}
