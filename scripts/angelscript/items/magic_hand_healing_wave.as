#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandHealingWave : CGameScript
{
	int MELEE_ATK_DURATION;
	int MELEE_RANGE;
	int SPELL_MPDRAIN;
	int SPELL_PREPARE_TIME;
	int SPELL_SKILL_REQUIRED;

	MagicHandHealingWave()
	{
		SPELL_SKILL_REQUIRED = 10;
		MELEE_RANGE = 1;
		MELEE_ATK_DURATION = 3;
		SPELL_PREPARE_TIME = 1;
		SPELL_MPDRAIN = 20;
	}

	void game_precache()
	{
		Precache("effects/sfx_wave");
	}

	void spell_spawn()
	{
		SetName("Healing Wave");
		SetDescription("A holy wave of Felewyn to bless your allies.");
	}

	void spell_casted()
	{
		string OWNER_LOC = GetEntityOrigin(GetOwner());
		OWNER_LOC = "z";
		string L_OWNER_YAW = GetEntityProperty(GetOwner(), "viewangles");
		string L_OWNER_YAW = /* TODO: $vec.yaw */ $vec.yaw(L_OWNER_YAW);
		SpawnNPC("effects/sfx_wave", OWNER_LOC, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), L_OWNER_YAW, GetSkillLevel(GetOwner(), "spellcasting.divination"), "spellcasting.divination"
	}

}

}
