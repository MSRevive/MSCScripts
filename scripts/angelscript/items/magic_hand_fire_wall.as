#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandFireWall : CGameScript
{
	int SPELL_SKILL_REQUIRED;

	MagicHandFireWall()
	{
		const string SOUND_SHOOT = "magic/fireball_powerup.wav";
		const string SOUND_CHARGE = "magic/fireball_strike.wav";
		const int MELEE_RANGE = 500;
		const float MELEE_HITCHANCE = 1.0;
		const int MELEE_ATK_DURATION = 4;
		SPELL_SKILL_REQUIRED = 13;
		const int SPELL_PREPARE_TIME = 2;
		const string SPELL_DAMAGE_TYPE = "fire";
		const int SPELL_ENERGYDRAIN = 50;
		const int SPELL_MPDRAIN = 30;
		const string SPELL_STAT = "spellcasting.fire";
		const int EFFECT_MAXDURATION = 30;
		const float EFFECT_MINDURATION = 0.5;
		const string EFFECT_DURATION_STAT = GetStat(GetOwner(), "concentration.ratio");
		const string EFFECT_DURATION = /* TODO: $get_skill_ratio */ $get_skill_ratio(EFFECT_DURATION_STAT, EFFECT_MINDURATION, EFFECT_MAXDURATION);
		const int EFFECT_MAX_DMG = 10;
		const float EFFECT_MIN_DMG = 0.1;
		const string EFFECT_DMG = GetSkillLevel(GetOwner(), "spellcasting.fire.ratio");
		const string EFFECT_SCRIPT = "monsters/summon/summon_fire_wall";
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
