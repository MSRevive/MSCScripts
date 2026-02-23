#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowNpc : CGameScript
{
	ProjArrowNpc()
	{
		const int ARROW_BODY_OFS = 0;
		const string PROJ_DAMAGE = RandomInt(60, 90);
		const int ARROW_EXPIRE_DELAY = 5;
		const int ARROW_STICK_DURATION = 10;
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 0.1;
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
