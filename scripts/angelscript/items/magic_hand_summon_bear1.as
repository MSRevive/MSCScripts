#pragma context server

#include "items/magic_hand_summon_base.as"

namespace MS
{

class MagicHandSummonBear1 : CGameScript
{
	int SPELL_SKILL_REQUIRED;

	MagicHandSummonBear1()
	{
		const int SUMMON_UNQIUE = 1;
		const string SUMMON_UNIQUE_TAG = "bear1";
		const string SUMMON_UNIQUE_NAME = "Bear Guardian";
		const string SPELL_NAME = "Summon Bear";
		const string SPELL_DESC = "Summons a Bear Guardian";
		const int MELEE_ATK_DURATION = 1;
		SPELL_SKILL_REQUIRED = 20;
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
		const string EFFECT_SCRIPT = "monsters/summon/bear1";
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
			SendColoredMessage(GetOwner(), "You may only summon one SUMMON_UNIQUE_NAME at a time.");
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
