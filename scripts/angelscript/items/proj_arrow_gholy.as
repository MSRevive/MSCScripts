#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowGholy : CGameScript
{
	float ARROW_BREAK_CHANCE;
	int ARROW_EXPIRE_DELAY;
	int ARROW_SOLIDIFY_ON_WALL;
	int ARROW_STICK_DURATION;
	int CLFX_ARROW;
	int DID_HIT;
	int MODEL_BODY_OFS;
	int PROJ_DAMAGE;
	string PROJ_DAMAGE_TYPE;
	string SPRITE_ARROW_TRADE;

	ProjArrowGholy()
	{
		CLFX_ARROW = 1;
		SPRITE_ARROW_TRADE = "firearrow";
		MODEL_BODY_OFS = 0;
		PROJ_DAMAGE_TYPE = "holy";
		PROJ_DAMAGE = 400;
		ARROW_STICK_DURATION = 5;
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 0.5;
		ARROW_EXPIRE_DELAY = 5;
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
