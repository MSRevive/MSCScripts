#pragma context server

#include "items/magic_hand_summon_base.as"

namespace MS
{

class MagicHandSummonGuard : CGameScript
{
	string EFFECT_DURATION;
	string EFFECT_DURATION_STAT;
	int EFFECT_MAXDURATION;
	int EFFECT_MAX_DMG;
	int EFFECT_MINDURATION;
	int EFFECT_MIN_DMG;
	string EFFECT_SCRIPT;
	int MELEE_ATK_DURATION;
	string SPELL_DAMAGE_TYPE;
	string SPELL_DESC;
	int SPELL_ENERGYDRAIN;
	int SPELL_MPDRAIN;
	string SPELL_NAME;
	int SPELL_PREPARE_TIME;
	int SPELL_SKILL_REQUIRED;

	MagicHandSummonGuard()
	{
		SPELL_NAME = "Undead Guardian";
		SPELL_DESC = "Summons a slow but tough undead soldier";
		MELEE_ATK_DURATION = 3;
		SPELL_SKILL_REQUIRED = 13;
		SPELL_PREPARE_TIME = 5;
		SPELL_DAMAGE_TYPE = "summon";
		SPELL_ENERGYDRAIN = 20;
		SPELL_MPDRAIN = 100;
		EFFECT_MAXDURATION = 360;
		EFFECT_MINDURATION = 30;
		EFFECT_DURATION_STAT = GetStat(GetOwner(), "concentration.ratio");
		EFFECT_DURATION = /* TODO: $get_skill_ratio */ $get_skill_ratio(EFFECT_DURATION_STAT, EFFECT_MINDURATION, EFFECT_MAXDURATION);
		EFFECT_MAX_DMG = 20;
		EFFECT_MIN_DMG = 5;
		EFFECT_SCRIPT = "monsters/summon/skeleton_guard";
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
