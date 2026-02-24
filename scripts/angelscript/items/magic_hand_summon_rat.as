#pragma context server

#include "items/magic_hand_summon_base.as"

namespace MS
{

class MagicHandSummonRat : CGameScript
{
	int EFFECT_DMG;
	string EFFECT_DURATION;
	string EFFECT_DURATION_STAT;
	int EFFECT_MAXDURATION;
	int EFFECT_MAX_DMG;
	int EFFECT_MINDURATION;
	float EFFECT_MIN_DMG;
	string EFFECT_SCRIPT;
	string EFFECT_SCRIPT2;
	int MELEE_ATK_DURATION;
	string SPELL_DAMAGE_TYPE;
	string SPELL_DESC;
	int SPELL_ENERGYDRAIN;
	int SPELL_MPDRAIN;
	string SPELL_NAME;
	int SPELL_PREPARE_TIME;
	int SPELL_SKILL_REQUIRED;

	MagicHandSummonRat()
	{
		SPELL_NAME = "Summon Rat";
		SPELL_DESC = "Summon a giant rat";
		MELEE_ATK_DURATION = 1;
		SPELL_SKILL_REQUIRED = 3;
		SPELL_PREPARE_TIME = 2;
		SPELL_DAMAGE_TYPE = "summon";
		SPELL_ENERGYDRAIN = 20;
		SPELL_MPDRAIN = 1;
		EFFECT_MAXDURATION = 180;
		EFFECT_MINDURATION = 10;
		EFFECT_DURATION_STAT = GetStat(GetOwner(), "concentration.ratio");
		EFFECT_DURATION = /* TODO: $get_skill_ratio */ $get_skill_ratio(EFFECT_DURATION_STAT, EFFECT_MINDURATION, EFFECT_MAXDURATION);
		EFFECT_MAX_DMG = 10;
		EFFECT_MIN_DMG = 0.1;
		EFFECT_DMG = 0;
		EFFECT_SCRIPT = "monsters/summon/rat";
		EFFECT_SCRIPT2 = "monsters/summon/giant_rat";
		Precache(EFFECT_SCRIPT2);
	}

	void spell_casted()
	{
		if (CURRENT_SUMMONS >= MAX_SUMMONS)
		{
			SendPlayerMessage(GetOwner(), "Too many summoned monsters present, cannot create more.");
		}
		if (!(CURRENT_SUMMONS < MAX_SUMMONS)) return;
		string SUM_DMG = GetSkillLevel(GetOwner(), "spellcasting");
		SUM_DMG /= 5;
		string SUM_LEVEL = GetSkillLevel(GetOwner(), "spellcasting");
		string SPAWN_ORG = param2;
		if (SUM_LEVEL < 8)
		{
			SpawnNPC(EFFECT_SCRIPT, SPAWN_ORG, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), EFFECT_DURATION, SUM_DMG
		}
		if (SUM_LEVEL >= 8)
		{
			SpawnNPC("monsters/summon/giant_rat", SPAWN_ORG, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), EFFECT_DURATION, SUM_DMG
		}
		summon_check(SPAWN_ORG);
	}

}

}
