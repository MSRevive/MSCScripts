#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowJagged : CGameScript
{
	float ARROW_BREAK_CHANCE;
	int ARROW_SOLIDIFY_ON_WALL;
	int CLFX_ARROW;
	int MODEL_BODY_OFS;
	int PROJ_DAMAGE;
	int PROJ_STICK_DURATION;
	string SPRITE_ARROW_TRADE;

	ProjArrowJagged()
	{
		CLFX_ARROW = 1;
		MODEL_BODY_OFS = 0;
		SPRITE_ARROW_TRADE = "silverarrow";
		PROJ_DAMAGE = RandomInt(275, 375);
		PROJ_STICK_DURATION = 25;
		ARROW_SOLIDIFY_ON_WALL = 1;
		ARROW_BREAK_CHANCE = 0.2;
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
