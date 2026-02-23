#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowGeneric : CGameScript
{
	ProjArrowGeneric()
	{
		const int CLFX_ARROW = 1;
		const int ARROW_BODY_OFS = 0;
		const string SPRITE_ARROW_TRADE = "woodenarrow";
		const string PROJ_DAMAGE = RandomInt(30, 60);
		const int ARROW_STICK_DURATION = 10;
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 0.2;
		const int ARROW_EXPIRE_DELAY = 5;
	}

	void arrow_spawn()
	{
		SetName("Arrow");
		SetDescription("A crudely made arrow");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0.1);
		SetGravity(0.75);
	}

}

}
