#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjBoltPoison : CGameScript
{
	ProjBoltPoison()
	{
		const int HITSCAN_BOLT = 1;
		const int MODEL_BODY_OFS = 0;
		const int PROJ_DAMAGE = 150;
		const int PROJ_STICK_DURATION = 25;
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 0.01;
		const string PROJ_DAMAGE_TYPE = "poison";
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
