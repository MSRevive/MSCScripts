#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowFrost : CGameScript
{
	float ARROW_BREAK_CHANCE;
	int ARROW_EXPIRE_DELAY;
	int ARROW_SOLIDIFY_ON_WALL;
	int ARROW_STICK_DURATION;
	int CLFX_ARROW;
	int MODEL_BODY_OFS;
	int PROJ_DAMAGE;
	string PROJ_DAMAGE_TYPE;
	string SPRITE_ARROW_TRADE;

	ProjArrowFrost()
	{
		CLFX_ARROW = 1;
		SPRITE_ARROW_TRADE = "silverarrow";
		MODEL_BODY_OFS = 6;
		PROJ_DAMAGE_TYPE = "cold";
		PROJ_DAMAGE = "$rand(60,100)";
		ARROW_STICK_DURATION = 25;
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 0.5;
		ARROW_EXPIRE_DELAY = 10;
	}

	void arrow_spawn()
	{
		SetName("Frost Arrow");
		SetDescription("These arrows have been enchanted with ice magics.");
		SetWeight(0.125);
		SetSize(1);
		SetValue(150);
		SetGravity(0.8);
		SetGroupable(25);
		SetUseable(1);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		string MY_OWNER = GetEntityIndex("ent_expowner");
		if ((IsValidPlayer(MY_OWNER)))
		{
			string L_DOT = GetSkillLevel(MY_OWNER, "spellcasting.ice");
			L_DOT *= 0.5;
			if (L_DOT < 5)
			{
				int L_DOT = RandomInt(5, 10);
			}
		}
		else
		{
			int L_DOT = RandomInt(5, 10);
		}
		ApplyEffect(param2, "effects/dot_cold", L_DOT, MY_OWNER, 5, "archery");
	}

}

}
