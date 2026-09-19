#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandFireWall : CGameScript
{
	string EFFECT_DMG;
	string EFFECT_DURATION;
	string EFFECT_DURATION_STAT;
	int EFFECT_MAXDURATION;
	int EFFECT_MAX_DMG;
	float EFFECT_MINDURATION;
	float EFFECT_MIN_DMG;
	string EFFECT_SCRIPT;
	int MELEE_ATK_DURATION;
	float MELEE_HITCHANCE;
	int MELEE_RANGE;
	string SOUND_CHARGE;
	string SOUND_SHOOT;
	string SPELL_DAMAGE_TYPE;
	int SPELL_ENERGYDRAIN;
	int SPELL_MPDRAIN;
	int SPELL_PREPARE_TIME;
	int SPELL_SKILL_REQUIRED;
	string SPELL_STAT;

	MagicHandFireWall()
	{
		SOUND_SHOOT = "magic/fireball_powerup.wav";
		SOUND_CHARGE = "magic/fireball_strike.wav";
		MELEE_RANGE = 500;
		MELEE_HITCHANCE = 1.0;
		MELEE_ATK_DURATION = 4;
		SPELL_SKILL_REQUIRED = 13;
		SPELL_PREPARE_TIME = 2;
		SPELL_DAMAGE_TYPE = "fire";
		SPELL_ENERGYDRAIN = 50;
		SPELL_MPDRAIN = 30;
		SPELL_STAT = "spellcasting.fire";
		EFFECT_MAXDURATION = 30;
		EFFECT_MINDURATION = 0.5;
		EFFECT_DURATION_STAT = GetStat(GetOwner(), "concentration.ratio");
		EFFECT_DURATION = /* TODO: $get_skill_ratio */ $get_skill_ratio(EFFECT_DURATION_STAT, EFFECT_MINDURATION, EFFECT_MAXDURATION);
		EFFECT_MAX_DMG = 10;
		EFFECT_MIN_DMG = 0.1;
		EFFECT_DMG = GetSkillLevel(GetOwner(), "spellcasting.fire.ratio");
		EFFECT_SCRIPT = "monsters/summon/summon_fire_wall";
		Precache(EFFECT_SCRIPT);
	}

	void spell_spawn()
	{
		SetName("Fire wall");
		SetDescription("A wall of searing fire to trap your opponents");
	}

	void spell_casted()
	{
		string pos = param2;
		Vector3 pos = Vector3((pos).x, (pos).y, /* TODO: $get_ground_height */ $get_ground_height(pos));
		int FIRE_DURATION = 15;
		string FIRE_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.fire");
		FIRE_DAMAGE *= 0.5;
		SpawnNPC(EFFECT_SCRIPT, pos, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetEntityProperty(GetOwner(), "angles.yaw"), FIRE_DAMAGE, FIRE_DURATION, "spellcasting.fire"
		DeleteEntity(GetOwner());
	}

	void fake_precache()
	{
		// svplaysound: svplaysound 0 0 SOUND_CHARGE
		EmitSound(0, 0, SOUND_CHARGE);
	}

}

}
