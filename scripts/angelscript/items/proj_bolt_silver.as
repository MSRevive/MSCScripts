#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjBoltSilver : CGameScript
{
	ProjBoltSilver()
	{
		const int HITSCAN_BOLT = 1;
		const int MODEL_BODY_OFS = 0;
		const int PROJ_DAMAGE = 400;
		const string PROJ_DAMAGE_TYPE = "holy";
		const int PROJ_STICK_DURATION = 25;
		const int ARROW_SOLIDIFY_ON_WALL = 1;
		const float ARROW_BREAK_CHANCE = 0.2;
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
