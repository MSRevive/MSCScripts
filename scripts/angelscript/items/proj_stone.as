#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjStone : CGameScript
{
	int ARROW_BODY_OFS;
	float ARROW_BREAK_CHANCE;
	int ARROW_SOLIDIFY_ON_WALL;
	int MODEL_BODY_OFS;
	string MODEL_WORLD;
	string PROJ_ANIM_IDLE;
	int PROJ_DAMAGE;
	int PROJ_STICK_DURATION;
	string ROJ_DAMAGETYPE;

	ProjStone()
	{
		PROJ_ANIM_IDLE = "idle_standard";
		PROJ_DAMAGE = RandomInt(60, 90);
		PROJ_STICK_DURATION = 0;
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 1.0;
		MODEL_BODY_OFS = 3;
		ARROW_BODY_OFS = 3;
		PROJ_ANIM_IDLE = "idle_icebolt";
		ROJ_DAMAGETYPE = "blunt";
		PROJ_DAMAGE = Random(4, 8);
		MODEL_WORLD = "weapons/projectiles.mdl";
	}

	void arrow_spawn()
	{
		SetName("small stone");
		SetDescription("a small stone");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.6);
		SetUseable(0);
	}

}

}
