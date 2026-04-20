#pragma context server

#include "items/smallarms_cre.as"

namespace MS
{

class SmallarmsCrep : CGameScript
{
	string ATK1_DMG_TYPE;
	string BWEAPON_NAME;
	float CRE_EFFECT_DURATION;
	string CRE_EFFECT_NAME;
	float CRE_EFFECT_RATIO;
	string CRE_EFFECT_SCRIPT;
	string CRE_EFFECT_SKILL;
	string CRE_TYPE;
	int PMODEL_IDX_FLOOR;
	int PMODEL_IDX_HANDS;
	int VMODEL_IDX;

	SmallarmsCrep()
	{
		BWEAPON_NAME = "Envenomed Crescent Blade";
		ATK1_DMG_TYPE = "poison";
		CRE_TYPE = "poison";
		CRE_EFFECT_SCRIPT = "effects/dot_poison";
		CRE_EFFECT_DURATION = 10.0;
		CRE_EFFECT_NAME = "DOT_poison";
		CRE_EFFECT_SKILL = "skill.spellcasting.affliction";
		CRE_EFFECT_RATIO = 0.3;
		VMODEL_IDX = 20;
		PMODEL_IDX_FLOOR = 73;
		PMODEL_IDX_HANDS = 75;
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
