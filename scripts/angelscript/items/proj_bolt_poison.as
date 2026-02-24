#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjBoltPoison : CGameScript
{
	float ARROW_BREAK_CHANCE;
	int ARROW_SOLIDIFY_ON_WALL;
	int HITSCAN_BOLT;
	int MODEL_BODY_OFS;
	int PROJ_DAMAGE;
	string PROJ_DAMAGE_TYPE;
	int PROJ_STICK_DURATION;

	ProjBoltPoison()
	{
		HITSCAN_BOLT = 1;
		MODEL_BODY_OFS = 0;
		PROJ_DAMAGE = 150;
		PROJ_STICK_DURATION = 25;
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 0.01;
		PROJ_DAMAGE_TYPE = "poison";
	}

	void arrow_spawn()
	{
		SetName("Poison Gas Bolt");
		SetDescription("This crossbow bolt explodes into a cloud of poisonous gas.");
		SetWeight(0.15);
		SetSize(1);
		SetValue(0);
		SetGravity(0);
		SetGroupable(25);
	}

	void bolt_dodamage()
	{
		LogDebug("bolt_dodamage PARAM1 PARAM2 PARAM3 PARAM4");
		string L_PASS = BOLT_TRACE_END;
		do_explode(L_PASS);
	}

	void strike_target()
	{
		string L_PASS = GetEntityOrigin(param1);
		do_explode(L_PASS);
	}

	void do_explode()
	{
		string L_PASS = param1;
		CallExternal("ent_expowner", "ext_poison_bolt", L_PASS);
	}

}

}
