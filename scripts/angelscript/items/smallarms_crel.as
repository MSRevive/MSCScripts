#pragma context server

#include "items/smallarms_cre.as"

namespace MS
{

class SmallarmsCrel : CGameScript
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

	SmallarmsCrel()
	{
		BWEAPON_NAME = "Electrified Crescent Blade";
		ATK1_DMG_TYPE = "lightning";
		CRE_TYPE = "lightning";
		CRE_EFFECT_SCRIPT = "effects/dot_lightning";
		CRE_EFFECT_DURATION = 5.0;
		CRE_EFFECT_NAME = "DOT_lightning";
		CRE_EFFECT_SKILL = "skill.spellcasting.lightning";
		CRE_EFFECT_RATIO = 0.4;
		VMODEL_IDX = 19;
		PMODEL_IDX_FLOOR = 76;
		PMODEL_IDX_HANDS = 78;
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
