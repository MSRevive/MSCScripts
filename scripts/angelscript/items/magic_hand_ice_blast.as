#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandIceBlast : CGameScript
{
	int SPELL_SKILL_REQUIRED;
	int baseitem.canidle;

	MagicHandIceBlast()
	{
		const int ANIM_CAST = 11;
		const string SOUND_SHOOT = "magic/frost_pulse.wav";
		const int MELEE_RANGE = 600;
		const float MELEE_HITCHANCE = 1.0;
		const int MELEE_ATK_DURATION = 1;
		SPELL_SKILL_REQUIRED = 18;
		const int SPELL_PREPARE_TIME = 1;
		const string SPELL_DAMAGE_TYPE = "cold";
		const int SPELL_ENERGYDRAIN = 1;
		const int MELEE_ATK_DURATION = 2;
		const int SPELL_MPDRAIN = 50;
		const string SPELL_STAT = "none";
		const string EFFECT_SCRIPT = "monsters/summon/ice_blast";
		Precache(EFFECT_SCRIPT);
	}

	void spell_spawn()
	{
		SetName("Freezing Sphere");
		SetDescription("A sphere of ice that freezes opponents");
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
		ScheduleDelayedEvent(0.7, "bitem_set_can_idle");
		PlayViewAnim(17);
	}

	void spell_casted()
	{
		string FREEZE_DURATION = GetSkillLevel(GetOwner(), "spellcasting.ice");
		if (FREEZE_DURATION < 10)
		{
			int FREEZE_DURATION = 10;
		}
		if (FREEZE_DURATION > 20)
		{
			int FREEZE_DURATION = 20;
		}
		string OWNER_ORG = GetEntityOrigin(GetOwner());
		string OWNER_ANG = GetEntityAngles(GetOwner());
		string OWNER_PITCH = /* TODO: $vec.pitch */ $vec.pitch(OWNER_ANG);
		string OWNER_PITCH = /* TODO: $neg */ $neg(OWNER_PITCH);
		string OWNER_YAW = /* TODO: $vec.yaw */ $vec.yaw(OWNER_ANG);
		string OWNER_ROLL = /* TODO: $vec.roll */ $vec.roll(OWNER_ANG);
		string OWNER_DEST = param2;
		OWNER_DEST += /* TODO: $relpos */ $relpos(Vector3(OWNER_PITCH, OWNER_YAW, OWNER_ROLL), Vector3(0, 20000, 0));
		SpawnNPC(EFFECT_SCRIPT, /* TODO: $relpos */ $relpos(0, 32, 32), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), FREEZE_DURATION, OWNER_DEST, "spellcasting.ice"
	}

}

}
