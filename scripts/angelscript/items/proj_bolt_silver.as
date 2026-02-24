#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjBoltSilver : CGameScript
{
	float ARROW_BREAK_CHANCE;
	int ARROW_SOLIDIFY_ON_WALL;
	int HITSCAN_BOLT;
	int MODEL_BODY_OFS;
	int PROJ_DAMAGE;
	string PROJ_DAMAGE_TYPE;
	int PROJ_STICK_DURATION;

	ProjBoltSilver()
	{
		HITSCAN_BOLT = 1;
		MODEL_BODY_OFS = 0;
		PROJ_DAMAGE = 400;
		PROJ_DAMAGE_TYPE = "holy";
		PROJ_STICK_DURATION = 25;
		ARROW_SOLIDIFY_ON_WALL = 1;
		ARROW_BREAK_CHANCE = 0.2;
	}

	void arrow_spawn()
	{
		SetName("Blessed Bolt");
		SetDescription("A crossbow bolt blessed with enchanted silver to fight the unholy.");
		SetWeight(0.175);
		SetSize(1);
		SetValue(400);
		SetGravity(0);
		SetGroupable(25);
	}

}

}
