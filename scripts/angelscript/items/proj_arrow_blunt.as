#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowBlunt : CGameScript
{
	int ARROW_BODY_OFS;
	float ARROW_BREAK_CHANCE;
	int ARROW_EXPIRE_DELAY;
	int ARROW_SOLIDIFY_ON_WALL;
	int ARROW_STICK_DURATION;
	int PROJ_DAMAGE;
	string PROJ_DAMAGE_TYPE;
	int PROJ_REMOVE_ON_USE;
	int PROJ_STICK_DURATION;
	int PROJ_STICK_ON_NPC;
	int PROJ_STICK_ON_WALL_NEW;
	string SPRITE_ARROW_TRADE;

	ProjArrowBlunt()
	{
		SPRITE_ARROW_TRADE = "broadarrow";
		ARROW_BODY_OFS = 3;
		PROJ_STICK_ON_WALL_NEW = 1;
		PROJ_REMOVE_ON_USE = 1;
		PROJ_DAMAGE = RandomInt(150, 250);
		PROJ_DAMAGE_TYPE = "blunt";
		ARROW_STICK_DURATION = 25;
		PROJ_STICK_DURATION = 25;
		PROJ_STICK_ON_NPC = 1;
		ARROW_SOLIDIFY_ON_WALL = 1;
		ARROW_EXPIRE_DELAY = 120;
		ARROW_BREAK_CHANCE = 0.2;
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
