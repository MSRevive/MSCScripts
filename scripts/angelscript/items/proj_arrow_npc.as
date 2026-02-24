#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowNpc : CGameScript
{
	int ARROW_BODY_OFS;
	float ARROW_BREAK_CHANCE;
	int ARROW_EXPIRE_DELAY;
	int ARROW_SOLIDIFY_ON_WALL;
	int ARROW_STICK_DURATION;
	int PROJ_DAMAGE;

	ProjArrowNpc()
	{
		ARROW_BODY_OFS = 0;
		PROJ_DAMAGE = RandomInt(60, 90);
		ARROW_EXPIRE_DELAY = 5;
		ARROW_STICK_DURATION = 10;
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 0.1;
	}

	void arrow_spawn()
	{
		SetName("Blunt Wooden Arrow");
		SetDescription("It s more like a sharpened stick than an arrow");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.6);
		SetGroupable(25);
		SetUseable(0);
	}

}

}
