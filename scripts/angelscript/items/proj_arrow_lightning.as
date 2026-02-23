#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowLightning : CGameScript
{
	ProjArrowLightning()
	{
		const int CLFX_ARROW = 1;
		const string SPRITE_ARROW_TRADE = "firearrow";
		const int MODEL_BODY_OFS = 0;
		const string PROJ_DAMAGE = RandomInt(40, 80);
		const int ARROW_STICK_DURATION = 25;
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 0.5;
		const int ARROW_EXPIRE_DELAY = 10;
	}

	void arrow_spawn()
	{
		SetName("Lightning Arrow");
		SetDescription("This arrow has been enchanted by a lightning wizard");
		SetWeight(0.125);
		SetSize(1);
		SetValue(100);
		SetGravity(0.8);
		SetGroupable(25);
		Effect("glow", GetOwner(), Vector3(255, 255, 0), 64, -1, 0);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		string MY_OWNER = GetEntityIndex("ent_expowner");
		ApplyEffect(param2, "effects/dot_lightning", RandomInt(5, 10), MY_OWNER, Random(10, 25), "archery");
	}

}

}
