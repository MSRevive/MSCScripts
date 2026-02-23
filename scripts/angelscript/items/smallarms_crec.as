#pragma context server

#include "items/smallarms_cre.as"

namespace MS
{

class SmallarmsCrec : CGameScript
{
	SmallarmsCrec()
	{
		const string BWEAPON_NAME = "Icy Crescent Blade";
		const string ATK1_DMG_TYPE = "cold";
		const string CRE_TYPE = "cold";
		const string CRE_EFFECT_SCRIPT = "effects/dot_cold";
		const float CRE_EFFECT_DURATION = 5.0;
		const string CRE_EFFECT_NAME = "DOT_cold";
		const string CRE_EFFECT_SKILL = "skill.spellcasting.ice";
		const float CRE_EFFECT_RATIO = 0.25;
		const int VMODEL_IDX = 18;
		const int PMODEL_IDX_FLOOR = 67;
		const int PMODEL_IDX_HANDS = 69;
	}

	void atk1_damaged_other()
	{
		if ((GetEntityProperty(param1, "haseffect"))) return;
		if ((IsValidPlayer(param1)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string DOT_AMT = GetEntityProperty(GetOwner(), "cre_effect_skill");
		DOT_AMT *= CRE_EFFECT_RATIO;
		LogDebug("atk1_damaged_other burn GetEntityName(param1) at DOT_AMT for CRE_EFFECT_DURATION");
		ApplyEffect(param1, CRE_EFFECT_SCRIPT, CRE_EFFECT_DURATION, GetEntityIndex(GetOwner()), DOT_AMT, "smallarms");
	}

}

}
