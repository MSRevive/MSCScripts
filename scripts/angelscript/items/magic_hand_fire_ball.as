#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandFireBall : CGameScript
{
	int ANIM_CAST;
	string MAX_BURN_DAMAGE;
	int MIN_BURN_DAMAGE;
	int RANGED_ATK_DURATION;
	string RANGED_COF;
	float RANGED_DMG_DELAY;
	int RANGED_FORCE;
	string RANGED_PROJECTILE;
	string SOUND_CHARGE;
	string SOUND_SHOOT;
	string SPELL_DAMAGE_TYPE;
	int SPELL_ENERGYDRAIN;
	int SPELL_MPDRAIN;
	int SPELL_PREPARE_TIME;
	int SPELL_SKILL_REQUIRED;
	string SPELL_STAT;
	int baseitem.canidle;

	MagicHandFireBall()
	{
		ANIM_CAST = 11;
		SOUND_CHARGE = "magic/fireball_powerup.wav";
		SOUND_SHOOT = "magic/fireball_large.wav";
		RANGED_FORCE = 1500;
		RANGED_COF = "15;1";
		RANGED_ATK_DURATION = 1;
		RANGED_PROJECTILE = "proj_fire_ball";
		RANGED_DMG_DELAY = 0.5;
		SPELL_SKILL_REQUIRED = 7;
		SPELL_PREPARE_TIME = 2;
		SPELL_DAMAGE_TYPE = "fire";
		SPELL_ENERGYDRAIN = 5;
		SPELL_MPDRAIN = 5;
		SPELL_STAT = "spellcasting.fire";
		MIN_BURN_DAMAGE = 3;
		MAX_BURN_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.fire.ratio");
	}

	void spell_spawn()
	{
		SetName("Fire ball");
		SetDescription("Burn opponents over a large area");
	}

	void cast_start()
	{
		baseitem.canidle = 0;
		ScheduleDelayedEvent(1.45, "start_spell_anim");
	}

	void cast_toss()
	{
		spell_casted();
		PlayOwnerAnim("critical", PLAYERANIM_CAST);
	}

	void start_spell_anim()
	{
		// svplaysound: svplaysound 0 game.sound.maxvol SOUND_SHOOT
		EmitSound(0, "game.sound.maxvol", SOUND_SHOOT);
		ScheduleDelayedEvent(2, "bitem_set_can_idle");
		PlayViewAnim(13);
	}

	void fake_precache()
	{
		// svplaysound: svplaysound 0 0 SOUND_CHARGE
		EmitSound(0, 0, SOUND_CHARGE);
		// svplaysound: svplaysound 0 0 SOUND_SHOOT
		EmitSound(0, 0, SOUND_SHOOT);
	}

}

}
