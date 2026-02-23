#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowBlunt : CGameScript
{
	ProjArrowBlunt()
	{
		const string SPRITE_ARROW_TRADE = "broadarrow";
		const int ARROW_BODY_OFS = 3;
		const int PROJ_STICK_ON_WALL_NEW = 1;
		const int PROJ_REMOVE_ON_USE = 1;
		const string PROJ_DAMAGE = RandomInt(150, 250);
		const string PROJ_DAMAGE_TYPE = "blunt";
		const int ARROW_STICK_DURATION = 25;
		const int PROJ_STICK_DURATION = 25;
		const int PROJ_STICK_ON_NPC = 1;
		const int ARROW_SOLIDIFY_ON_WALL = 1;
		const int ARROW_EXPIRE_DELAY = 120;
		const float ARROW_BREAK_CHANCE = 0.2;
	}

	void arrow_spawn()
	{
		SetName("Climbing Arrow");
		SetDescription("An sturdy arrow with a forked iron tip for use as a piton");
		SetWeight(0.25);
		SetSize(1);
		SetValue(5);
		SetGravity(0.85);
	}

}

}
