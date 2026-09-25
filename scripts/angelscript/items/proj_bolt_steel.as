#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjBoltSteel : CGameScript
{
	float ARROW_BREAK_CHANCE;
	int ARROW_SOLIDIFY_ON_WALL;
	float HEAVY_BOLT;
	int HEAVY_ONLY;
	int HITSCAN_BOLT;
	int MODEL_BODY_OFS;
	string MY_XBOW;
	int PROJ_DAMAGE;
	int PROJ_STICK_DURATION;

	ProjBoltSteel()
	{
		HITSCAN_BOLT = 1;
		HEAVY_ONLY = 1;
		MODEL_BODY_OFS = 0;
		PROJ_DAMAGE = 400;
		PROJ_STICK_DURATION = 25;
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 0.2;
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
