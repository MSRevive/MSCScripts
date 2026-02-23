#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandFireBall : CGameScript
{
	int SPELL_SKILL_REQUIRED;
	int baseitem.canidle;

	MagicHandFireBall()
	{
		const int ANIM_CAST = 11;
		const string SOUND_CHARGE = "magic/fireball_powerup.wav";
		const string SOUND_SHOOT = "magic/fireball_large.wav";
		const int RANGED_FORCE = 1500;
		const string RANGED_COF = "15;1";
		const int RANGED_ATK_DURATION = 1;
		const string RANGED_PROJECTILE = "proj_fire_ball";
		const float RANGED_DMG_DELAY = 0.5;
		SPELL_SKILL_REQUIRED = 7;
		const int SPELL_PREPARE_TIME = 2;
		const string SPELL_DAMAGE_TYPE = "fire";
		const int SPELL_ENERGYDRAIN = 5;
		const int SPELL_MPDRAIN = 5;
		const string SPELL_STAT = "spellcasting.fire";
		const int MIN_BURN_DAMAGE = 3;
		const string MAX_BURN_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.fire.ratio");
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
