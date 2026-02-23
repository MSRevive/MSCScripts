#pragma context server

#include "items/magic_hand_summon_base.as"

namespace MS
{

class MagicHandSummonFangtooth : CGameScript
{
	int SPELL_SKILL_REQUIRED;

	MagicHandSummonFangtooth()
	{
		const string SPELL_NAME = "Summon Fangtooth";
		const string SPELL_DESC = "Summons a fast moving plague rat";
		const int MELEE_ATK_DURATION = 1;
		SPELL_SKILL_REQUIRED = 12;
		const int SPELL_PREPARE_TIME = 2;
		const string SPELL_DAMAGE_TYPE = "summon";
		const int SPELL_ENERGYDRAIN = 20;
		const int SPELL_MPDRAIN = 30;
		const int EFFECT_MAXDURATION = 180;
		const int EFFECT_MINDURATION = 10;
		const string EFFECT_DURATION_STAT = GetStat(GetOwner(), "concentration.ratio");
		const string EFFECT_DURATION = /* TODO: $get_skill_ratio */ $get_skill_ratio(EFFECT_DURATION_STAT, EFFECT_MINDURATION, EFFECT_MAXDURATION);
		const int EFFECT_MAX_DMG = 10;
		const float EFFECT_MIN_DMG = 0.1;
		const int EFFECT_DMG = 0;
		const string EFFECT_SCRIPT = "monsters/summon/fangtooth";
		Precache(EFFECT_SCRIPT);
	}

	void spell_casted()
	{
		if (CURRENT_SUMMONS >= MAX_SUMMONS)
		{
			SendPlayerMessage(GetOwner(), "Too many summoned monsters present, cannot create more.");
		}
		if (!(CURRENT_SUMMONS < MAX_SUMMONS)) return;
		string SUM_DMG = GetSkillLevel(GetOwner(), "spellcasting");
		SUM_DMG /= 2;
		string SUM_LEVEL = GetSkillLevel(GetOwner(), "spellcasting");
		string SUM_DURATION = EFFECT_DURATION;
		SUM_DURATION *= 2.0;
		string SPAWN_ORG = param2;
		SpawnNPC(EFFECT_SCRIPT, SPAWN_ORG, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), SUM_DURATION, SUM_DMG
		summon_check(SPAWN_ORG);
	}

}

}
