#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandVolcano : CGameScript
{
	string EFFECT_DMG;
	string EFFECT_DURATION;
	string EFFECT_DURATION_STAT;
	int EFFECT_MAXDURATION;
	int EFFECT_MINDURATION;
	string EFFECT_SCRIPT;
	int MELEE_ATK_DURATION;
	float MELEE_HITCHANCE;
	int MELEE_RANGE;
	string SOUND_SHOOT;
	string SPELL_DAMAGE_TYPE;
	int SPELL_ENERGYDRAIN;
	int SPELL_MPDRAIN;
	int SPELL_PREPARE_TIME;
	int SPELL_SKILL_REQUIRED;
	string SPELL_STAT;
	int baseitem.canidle;

	MagicHandVolcano()
	{
		SOUND_SHOOT = "magic/cast.wav";
		MELEE_RANGE = 600;
		MELEE_HITCHANCE = 1.0;
		MELEE_ATK_DURATION = 4;
		SPELL_SKILL_REQUIRED = 15;
		SPELL_PREPARE_TIME = 2;
		SPELL_DAMAGE_TYPE = "fire";
		SPELL_ENERGYDRAIN = 200;
		SPELL_MPDRAIN = 80;
		SPELL_STAT = "spellcasting.fire";
		EFFECT_MAXDURATION = 30;
		EFFECT_MINDURATION = 8;
		EFFECT_DURATION_STAT = GetStat(GetOwner(), "concentration.ratio");
		EFFECT_DURATION = /* TODO: $get_skill_ratio */ $get_skill_ratio(EFFECT_DURATION_STAT, EFFECT_MINDURATION, EFFECT_MAXDURATION);
		EFFECT_SCRIPT = "monsters/summon/summon_volcano";
		EFFECT_DMG = GetSkillLevel(GetOwner(), "spellcasting.fire");
		EFFECT_DMG += 100;
	}

	void game_precache()
	{
		Precache(EFFECT_SCRIPT);
	}

	void spell_spawn()
	{
		SetName("Summon Volcano");
		SetDescription("A magical weapon of mass destruction");
	}

	void spell_casted()
	{
		string pos = param2;
		string temp = /* TODO: $get_ground_height */ $get_ground_height(pos);
		string x = (pos).x;
		string y = (pos).y;
		Vector3 pos = Vector3(x, y, temp);
		SpawnNPC(EFFECT_SCRIPT, pos, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), EFFECT_DMG, EFFECT_DURATION, "spellcasting.fire"
	}

	void cast_start()
	{
		baseitem.canidle = 0;
		start_spell_anim();
	}

	void cast_toss()
	{
		spell_casted();
		PlayOwnerAnim("critical", PLAYERANIM_CAST);
	}

	void start_spell_anim()
	{
		ScheduleDelayedEvent(1, "bitem_set_can_idle");
		PlayViewAnim(16);
	}

	void bitem_set_can_idle()
	{
		DeleteEntity(GetOwner());
	}

}

}
