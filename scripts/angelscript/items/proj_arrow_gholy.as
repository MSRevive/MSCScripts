#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowGholy : CGameScript
{
	int DID_HIT;

	ProjArrowGholy()
	{
		const int CLFX_ARROW = 1;
		const string SPRITE_ARROW_TRADE = "firearrow";
		const int MODEL_BODY_OFS = 0;
		const string PROJ_DAMAGE_TYPE = "holy";
		const int PROJ_DAMAGE = 400;
		const int ARROW_STICK_DURATION = 5;
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 0.5;
		const int ARROW_EXPIRE_DELAY = 5;
	}

	void arrow_spawn()
	{
		SetName("Greater Holy Arrow");
		SetDescription("An arrow imbued with fantastic divine energies");
		SetWeight(0.175);
		SetSize(1);
		SetValue(500);
		SetGravity(0.8);
		SetGroupable(25);
	}

	void game_projectile_hitnpc()
	{
		LogDebug("strike_target GetEntityName(param1)");
		if ((DID_HIT)) return;
		DID_HIT = 1;
		string L_TARG = param1;
		string MY_OWNER = GetEntityIndex("ent_expowner");
		string HOLY_DMG = GetSkillLevel("ent_expowner", "spellcasting.divination");
		HOLY_DMG += 5;
		if (HOLY_DMG <= 5)
		{
			int HOLY_DMG = 5;
		}
		CallExternal(L_TARG, "turn_undead", HOLY_DMG, MY_OWNER);
	}

}

}
