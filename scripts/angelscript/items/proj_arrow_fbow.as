#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowFbow : CGameScript
{
	int ARROW_BODY_OFS;
	int ARROW_EXPIRE_DELAY;
	int ARROW_SOLIDIFY_ON_WALL;
	int CLFX_ARROW;
	int FREEZE_MANA_COST;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;
	int PROJ_DAMAGE;
	string PROJ_DAMAGE_TYPE;
	string SPRITE_ARROW_TRADE;

	ProjArrowFbow()
	{
		CLFX_ARROW = 1;
		MODEL_WORLD = "weapons/projectiles.mdl";
		MODEL_HANDS = "weapons/projectiles.mdl";
		SPRITE_ARROW_TRADE = "silverarrow";
		ARROW_BODY_OFS = 47;
		MODEL_BODY_OFS = 47;
		PROJ_DAMAGE_TYPE = "cold";
		FREEZE_MANA_COST = 10;
		PROJ_DAMAGE = RandomInt(250, 325);
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_EXPIRE_DELAY = 10;
	}

	void arrow_spawn()
	{
		SetName("Frosty");
		SetDescription("Brrrr!");
		SetWeight(0.1);
		SetSize(1);
		SetValue(150);
		SetGravity(0.8);
		SetGroupable(25);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		string MY_OWNER = GetEntityIndex("ent_expowner");
		string CDOT_DMG = GetSkillLevel(MY_OWNER, "spellcasting.ice");
		string FDOT_DMG = CDOT_DMG;
		CDOT_DMG /= 1.8;
		FDOT_DMG /= 2;
		int PROJ_TYPE = 0;
		if (GetEntityMP(MY_OWNER) >= FREEZE_MANA_COST)
		{
			int PROJ_TYPE = RandomInt(0, 1);
		}
		if (!(PROJ_TYPE))
		{
			ApplyEffect(param2, "effects/dot_cold", RandomInt(5, 10), MY_OWNER, CDOT_DMG, "spellcasting.ice");
		}
		else
		{
			GiveMP(MY_OWNER);
			ApplyEffect(param2, "effects/dot_cold_freeze", 8.0, MY_OWNER, FDOT_DMG, "spellcasting.ice");
		}
	}

}

}
