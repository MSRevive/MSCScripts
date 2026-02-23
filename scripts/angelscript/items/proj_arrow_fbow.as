#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowFbow : CGameScript
{
	ProjArrowFbow()
	{
		const int CLFX_ARROW = 1;
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const string MODEL_HANDS = "weapons/projectiles.mdl";
		const string SPRITE_ARROW_TRADE = "silverarrow";
		const int ARROW_BODY_OFS = 47;
		const int MODEL_BODY_OFS = 47;
		const string PROJ_DAMAGE_TYPE = "cold";
		const int FREEZE_MANA_COST = 10;
		const string PROJ_DAMAGE = RandomInt(250, 325);
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const int ARROW_EXPIRE_DELAY = 10;
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
			string PROJ_TYPE = RandomInt(0, 1);
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
