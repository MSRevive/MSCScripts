#pragma context server

#include "items/smallarms_cre.as"

namespace MS
{

class SmallarmsCref : CGameScript
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

	SmallarmsCref()
	{
		BWEAPON_NAME = "Flaming Crescent Blade";
		ATK1_DMG_TYPE = "fire";
		CRE_TYPE = "fire";
		CRE_EFFECT_SCRIPT = "effects/dot_fire";
		CRE_EFFECT_DURATION = 5.0;
		CRE_EFFECT_NAME = "DOT_fire";
		CRE_EFFECT_SKILL = "skill.spellcasting.fire";
		CRE_EFFECT_RATIO = 0.5;
		VMODEL_IDX = 17;
		PMODEL_IDX_FLOOR = 70;
		PMODEL_IDX_HANDS = 72;
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
