#pragma context server

#include "items/axes_td.as"

namespace MS
{

class AxesTi : CGameScript
{
	string MELEE_DMG_TYPE;
	int TOM_SKIN;

	AxesTi()
	{
		MELEE_DMG_TYPE = "cold";
		TOM_SKIN = 1;
	}

	void weapon_spawn()
	{
		SetName("Ice Tomahawk");
		SetDescription("A mystic tomahawk of ancient times");
		SetWeight(90);
		SetSize(25);
		SetValue(2500);
		SetHUDSprite("hand", "axe");
		SetHUDSprite("trade", 172);
	}

	void game_dodamage()
	{
		if (!(true)) return;
		if (!(param1)) return;
		if (!(RandomInt(1, 5) == 1)) return;
		string BURN_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.ice");
		BURN_DAMAGE /= 3;
		BURN_DAMAGE += Random(1, 3);
		if (BURN_DAMAGE < 5)
		{
			int BURN_DAMAGE = 5;
		}
		LogDebug("game_dodamage BURN_DAMAGE");
		ApplyEffect(param2, "effects/dot_cold", 5, GetEntityIndex(GetOwner()), BURN_DAMAGE, "axehandling");
	}

}

}
