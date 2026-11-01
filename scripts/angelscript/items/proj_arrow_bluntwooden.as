#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowBluntwooden : CGameScript
{
	float ARROW_BREAK_CHANCE;
	int ARROW_EXPIRE_DELAY;
	int ARROW_SOLIDIFY_ON_WALL;
	int ARROW_STICK_DURATION;
	int CLFX_ARROW;
	int MODEL_BODY_OFS;
	int PROJ_DAMAGE;
	string SPRITE_ARROW_TRADE;

	ProjArrowBluntwooden()
	{
		CLFX_ARROW = 1;
		MODEL_BODY_OFS = 0;
		SPRITE_ARROW_TRADE = "woodenarrow";
		PROJ_DAMAGE = RandomInt(30, 60);
		ARROW_STICK_DURATION = 10;
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 0.2;
		ARROW_EXPIRE_DELAY = 5;
	}

	void arrow_spawn()
	{
		SetName("Blunt Wooden Arrow");
		SetDescription("It's more like a sharpened stick than an arrow");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0.1);
		SetGravity(0.75);
	}

}

}
