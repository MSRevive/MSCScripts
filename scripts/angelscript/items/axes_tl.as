#pragma context server

#include "items/axes_td.as"

namespace MS
{

class AxesTl : CGameScript
{
	AxesTl()
	{
		const string MELEE_DMG_TYPE = "lightning";
		const int TOM_SKIN = 2;
	}

	void weapon_spawn()
	{
		SetName("Lightning Tomahawk");
		SetDescription("A mystic tomahawk of ancient times");
		SetWeight(90);
		SetSize(25);
		SetValue(2500);
		SetHUDSprite("hand", "axe");
		SetHUDSprite("trade", 173);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (!(RandomInt(1, 5) == 1)) return;
		string BURN_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.lightning");
		BURN_DAMAGE /= 2;
		BURN_DAMAGE += Random(1, 3);
		if (BURN_DAMAGE < 5)
		{
			int BURN_DAMAGE = 5;
		}
		ApplyEffect(param2, "effects/dot_lightning", 5, GetEntityIndex(GetOwner()), BURN_DAMAGE, "axehandling");
	}

}

}
