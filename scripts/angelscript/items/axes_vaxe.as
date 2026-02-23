#pragma context server

#include "items/axes_greataxe.as"
#include "items/base_vampire.as"

namespace MS
{

class AxesVaxe : CGameScript
{
	AxesVaxe()
	{
		const int BASE_LEVEL_REQ = 15;
		const int MODEL_VIEW_IDX = 3;
		const string MODEL_HANDS = "weapons/p_weapons2.mdl";
		const string MODEL_WORLD = "weapons/p_weapons2.mdl";
		const int MODEL_BODY_OFS = 118;
		const int MELEE_DMG = 280;
		const int MELEE_DMG_RANGE = 100;
		const float MELEE_ACCURACY = 0.3;
	}

	void weapon_spawn()
	{
		SetName("Blood Axe");
		SetDescription("A sinister breed of axe forged with the blood of vampires and demons");
		SetWeight(90);
		SetSize(25);
		SetValue(2000);
		SetHUDSprite("hand", 120);
		SetHUDSprite("trade", 120);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		string HEAL_AMT = GetEntityProperty(m_hLastStruckByMe, "scriptvar");
		HEAL_AMT /= 3;
		try_vampire_target(GetEntityIndex(GetOwner()), GetEntityIndex(param2), HEAL_AMT);
	}

}

}
