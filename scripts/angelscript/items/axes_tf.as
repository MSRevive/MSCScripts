#pragma context server

#include "items/axes_td.as"

namespace MS
{

class AxesTf : CGameScript
{
	AxesTf()
	{
		const string MELEE_DMG_TYPE = "fire";
		const int TOM_SKIN = 0;
	}

	void weapon_spawn()
	{
		SetName("Fire Tomahawk");
		SetDescription("A mystic tomahawk of ancient times");
		SetWeight(90);
		SetSize(25);
		SetValue(2500);
		SetHUDSprite("hand", 130);
		SetHUDSprite("trade", 130);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (!(RandomInt(1, 5) == 1)) return;
		string BURN_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.fire");
		BURN_DAMAGE *= 0.75;
		BURN_DAMAGE += Random(1, 3);
		if (BURN_DAMAGE < 5)
		{
			int BURN_DAMAGE = 5;
		}
		ApplyEffect(param2, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), BURN_DAMAGE, "axehandling");
	}

}

}
