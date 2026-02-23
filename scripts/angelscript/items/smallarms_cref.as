#pragma context server

#include "items/smallarms_cre.as"

namespace MS
{

class SmallarmsCref : CGameScript
{
	SmallarmsCref()
	{
		const string BWEAPON_NAME = "Flaming Crescent Blade";
		const string ATK1_DMG_TYPE = "fire";
		const string CRE_TYPE = "fire";
		const string CRE_EFFECT_SCRIPT = "effects/dot_fire";
		const float CRE_EFFECT_DURATION = 5.0;
		const string CRE_EFFECT_NAME = "DOT_fire";
		const string CRE_EFFECT_SKILL = "skill.spellcasting.fire";
		const float CRE_EFFECT_RATIO = 0.5;
		const int VMODEL_IDX = 17;
		const int PMODEL_IDX_FLOOR = 70;
		const int PMODEL_IDX_HANDS = 72;
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
		ApplyEffect(param1, CRE_EFFECT_SCRIPT, CRE_EFFECT_DURATION, GetEntityIndex(GetOwner()), DOT_AMT, "smallarms");
	}

}

}
