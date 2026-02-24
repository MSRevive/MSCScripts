#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowPoison : CGameScript
{
	float ARROW_BREAK_CHANCE;
	int ARROW_EXPIRE_DELAY;
	int ARROW_SOLIDIFY_ON_WALL;
	int ARROW_STICK_DURATION;
	int CLFX_ARROW;
	int MODEL_BODY_OFS;
	int PROJ_DAMAGE;
	string SPRITE_ARROW_TRADE;

	ProjArrowPoison()
	{
		CLFX_ARROW = 1;
		SPRITE_ARROW_TRADE = "firearrow";
		MODEL_BODY_OFS = 0;
		PROJ_DAMAGE = RandomInt(40, 50);
		ARROW_STICK_DURATION = 25;
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 0.5;
		ARROW_EXPIRE_DELAY = 10;
	}

	void arrow_spawn()
	{
		SetName("Envenomed Arrow");
		SetDescription("This sinister arrow has been laced with deadly poison.");
		SetWeight(0.125);
		SetSize(1);
		SetValue(100);
		SetGravity(0.8);
		SetGroupable(25);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		string MY_OWNER = GetEntityIndex("ent_expowner");
		ApplyEffect(param2, "effects/dot_poison", 15, MY_OWNER, Random(2, 3), "archery");
	}

}

}
