#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjBoltSteel : CGameScript
{
	float HEAVY_BOLT;
	string MY_XBOW;

	ProjBoltSteel()
	{
		const int HITSCAN_BOLT = 1;
		const int HEAVY_ONLY = 1;
		const int MODEL_BODY_OFS = 0;
		const int PROJ_DAMAGE = 400;
		const int PROJ_STICK_DURATION = 25;
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 0.2;
		HEAVY_BOLT = 0.5;
	}

	void arrow_spawn()
	{
		SetName("Steel Bolt");
		SetDescription("A crossbow bolt made of heavy steel designed for heavier crossbows");
		SetWeight(0.175);
		SetSize(1);
		SetValue(200);
		SetGravity(2);
		SetGroupable(25);
		if (!(true)) return;
		MY_XBOW = GetActiveItem("ent_expowner");
		if ((GetEntityName(MY_XBOW)).findFirst("Heavy") >= 0)
		{
			SetGravity(0);
		}
	}

}

}
