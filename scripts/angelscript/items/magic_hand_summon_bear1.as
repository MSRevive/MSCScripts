#pragma context server

#include "items/magic_hand_summon_base.as"

namespace MS
{

class MagicHandSummonBear1 : CGameScript
{
	int EFFECT_DMG;
	string EFFECT_DURATION;
	string EFFECT_DURATION_STAT;
	int EFFECT_MAXDURATION;
	int EFFECT_MAX_DMG;
	int EFFECT_MINDURATION;
	float EFFECT_MIN_DMG;
	string EFFECT_SCRIPT;
	int MELEE_ATK_DURATION;
	string SPELL_DAMAGE_TYPE;
	string SPELL_DESC;
	int SPELL_ENERGYDRAIN;
	int SPELL_MPDRAIN;
	string SPELL_NAME;
	int SPELL_PREPARE_TIME;
	int SPELL_SKILL_REQUIRED;
	string SUMMON_UNIQUE_NAME;
	string SUMMON_UNIQUE_TAG;
	int SUMMON_UNQIUE;

	MagicHandSummonBear1()
	{
		SUMMON_UNQIUE = 1;
		SUMMON_UNIQUE_TAG = "bear1";
		SUMMON_UNIQUE_NAME = "Bear Guardian";
		SPELL_NAME = "Summon Bear";
		SPELL_DESC = "Summons a Bear Guardian";
		MELEE_ATK_DURATION = 1;
		SPELL_SKILL_REQUIRED = 20;
		SPELL_PREPARE_TIME = 2;
		SPELL_DAMAGE_TYPE = "summon";
		SPELL_ENERGYDRAIN = 20;
		SPELL_MPDRAIN = 30;
		EFFECT_MAXDURATION = 180;
		EFFECT_MINDURATION = 10;
		EFFECT_DURATION_STAT = GetStat(GetOwner(), "concentration.ratio");
		EFFECT_DURATION = /* TODO: $get_skill_ratio */ $get_skill_ratio(EFFECT_DURATION_STAT, EFFECT_MINDURATION, EFFECT_MAXDURATION);
		EFFECT_MAX_DMG = 10;
		EFFECT_MIN_DMG = 0.1;
		EFFECT_DMG = 0;
		EFFECT_SCRIPT = "monsters/summon/bear1";
		Precache(EFFECT_SCRIPT);
	}

	void spell_casted()
	{
		if (CURRENT_SUMMONS >= MAX_SUMMONS)
		{
			SendPlayerMessage(GetOwner(), "Too many summoned monsters present, cannot create more.");
		}
		if (!(CURRENT_SUMMONS < MAX_SUMMONS)) return;
		if ((SUMMON_UNQIUE))
		{
			if ((GetEntityProperty(GetOwner(), "scriptvar")).findFirst(SUMMON_UNIQUE_TAG) >= 0)
			{
			}
			SendColoredMessage(GetOwner(), "You may only summon one " + SUMMON_UNIQUE_NAME + " at a time.");
			GiveMP(GetOwner());
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string SUM_DURATION = EFFECT_DURATION;
		SUM_DURATION *= 2.0;
		string SPAWN_ORG = param2;
		SPAWN_ORG = "z";
		SPAWN_ORG += "z";
		SpawnNPC(EFFECT_SCRIPT, SPAWN_ORG, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), SUM_DURATION
		summon_check(SPAWN_ORG);
	}

}

}
