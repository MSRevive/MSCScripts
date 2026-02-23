#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowGpoison : CGameScript
{
	ProjArrowGpoison()
	{
		const int CLFX_ARROW = 1;
		const string SPRITE_ARROW_TRADE = "firearrow";
		const int MODEL_BODY_OFS = 0;
		const string PROJ_DAMAGE = RandomInt(60, 80);
		const int ARROW_STICK_DURATION = 25;
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 0.5;
		const int ARROW_EXPIRE_DELAY = 10;
	}

	void arrow_spawn()
	{
		SetName("Deadly Envenomed Arrow");
		SetDescription("This poison on this arrow is amongst the most deadly known.");
		SetWeight(0.175);
		SetSize(1);
		SetValue(200);
		SetGravity(0.8);
		SetGroupable(25);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		string MY_OWNER = GetEntityIndex("ent_expowner");
		if ((IsValidPlayer(MY_OWNER)))
		{
			string L_DOT = GetSkillLevel("ent_expowner", "spellcasting.affliction");
			if (L_DOT < 12)
			{
				string L_DOT = Random(12, 33);
			}
		}
		else
		{
			string L_DOT = Random(12, 33);
		}
		ApplyEffect(param2, "effects/dot_poison", 10.0, MY_OWNER, L_DOT, "archery");
	}

}

}
