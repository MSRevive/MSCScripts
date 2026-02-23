#pragma context server

#include "items/magic_hand_summon_base.as"

namespace MS
{

class MagicHandSummonGuard : CGameScript
{
	int SPELL_SKILL_REQUIRED;

	MagicHandSummonGuard()
	{
		const string SPELL_NAME = "Undead Guardian";
		const string SPELL_DESC = "Summons a slow but tough undead soldier";
		const int MELEE_ATK_DURATION = 3;
		SPELL_SKILL_REQUIRED = 13;
		const int SPELL_PREPARE_TIME = 5;
		const string SPELL_DAMAGE_TYPE = "summon";
		const int SPELL_ENERGYDRAIN = 20;
		const int SPELL_MPDRAIN = 100;
		const int EFFECT_MAXDURATION = 360;
		const int EFFECT_MINDURATION = 30;
		const string EFFECT_DURATION_STAT = GetStat(GetOwner(), "concentration.ratio");
		const string EFFECT_DURATION = /* TODO: $get_skill_ratio */ $get_skill_ratio(EFFECT_DURATION_STAT, EFFECT_MINDURATION, EFFECT_MAXDURATION);
		const int EFFECT_MAX_DMG = 20;
		const int EFFECT_MIN_DMG = 5;
		const string EFFECT_SCRIPT = "monsters/summon/skeleton_guard";
	}

	void spell_casted()
	{
		if (CURRENT_SUMMONS >= MAX_SUMMONS)
		{
			SendPlayerMessage(GetOwner(), "Too many summoned monsters present, cannot create more.");
		}
		if (!(CURRENT_SUMMONS < MAX_SUMMONS)) return;
		string SUM_DMG = GetSkillLevel(GetOwner(), "spellcasting");
		SUM_DMG /= 8;
		string SUM_DURATION = EFFECT_DURATION;
		SUM_DURATION *= 4.0;
		string SUM_LEVEL = GetSkillLevel(GetOwner(), "spellcasting");
		string SPAWN_ORG = param2;
		SpawnNPC(EFFECT_SCRIPT, SPAWN_ORG, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), SUM_DURATION, SUM_DMG
		summon_check(SPAWN_ORG);
	}

}

}
