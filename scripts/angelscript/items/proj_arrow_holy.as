#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowHoly : CGameScript
{
	float ARROW_BREAK_CHANCE;
	int ARROW_EXPIRE_DELAY;
	int ARROW_SOLIDIFY_ON_WALL;
	int ARROW_STICK_DURATION;
	int CLFX_ARROW;
	int MODEL_BODY_OFS;
	int PROJ_DAMAGE;
	string PROJ_DAMAGE_TYPE;
	string SPRITE_ARROW_TRADE;

	ProjArrowHoly()
	{
		CLFX_ARROW = 1;
		SPRITE_ARROW_TRADE = "firearrow";
		MODEL_BODY_OFS = 0;
		PROJ_DAMAGE_TYPE = "holy";
		PROJ_DAMAGE = 300;
		ARROW_STICK_DURATION = 5;
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 0.5;
		ARROW_EXPIRE_DELAY = 5;
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
