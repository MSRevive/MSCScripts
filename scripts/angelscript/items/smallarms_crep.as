#pragma context server

#include "items/smallarms_cre.as"

namespace MS
{

class SmallarmsCrep : CGameScript
{
	SmallarmsCrep()
	{
		const string BWEAPON_NAME = "Envenomed Crescent Blade";
		const string ATK1_DMG_TYPE = "poison";
		const string CRE_TYPE = "poison";
		const string CRE_EFFECT_SCRIPT = "effects/dot_poison";
		const float CRE_EFFECT_DURATION = 10.0;
		const string CRE_EFFECT_NAME = "DOT_poison";
		const string CRE_EFFECT_SKILL = "skill.spellcasting.affliction";
		const float CRE_EFFECT_RATIO = 0.3;
		const int VMODEL_IDX = 20;
		const int PMODEL_IDX_FLOOR = 73;
		const int PMODEL_IDX_HANDS = 75;
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
		ApplyEffect(param1, CRE_EFFECT_SCRIPT, CRE_EFFECT_DURATION, GetEntityIndex(GetOwner()), DOT_AMT);
	}

}

}
