#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandFireDart : CGameScript
{
	int ANIM_CAST;
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

	MagicHandFireDart()
	{
		ANIM_CAST = 11;
		SOUND_CHARGE = "magic/fireball_powerup.wav";
		SOUND_SHOOT = "magic/fireball_strike.wav";
		RANGED_FORCE = 1000;
		RANGED_COF = "10;1";
		RANGED_ATK_DURATION = 1;
		RANGED_PROJECTILE = "proj_fire_dart";
		RANGED_DMG_DELAY = 0.5;
		SPELL_SKILL_REQUIRED = 0;
		SPELL_PREPARE_TIME = 4;
		SPELL_DAMAGE_TYPE = "fire";
		SPELL_ENERGYDRAIN = 5;
		SPELL_MPDRAIN = 1;
		SPELL_STAT = "spellcasting.fire";
	}

	void spell_spawn()
	{
		SetName("Fire Dart");
		SetDescription("A weak bolt of fire");
	}

	void spell_casted()
	{
		// svplaysound: svplaysound game.sound.item game.sound.maxvol SOUND_SHOOT
		EmitSound("game.sound.item", "game.sound.maxvol", SOUND_SHOOT);
	}

	void cast_start()
	{
		baseitem.canidle = 0;
		ScheduleDelayedEvent(1.65, "start_spell_anim");
	}

	void cast_toss()
	{
		spell_casted();
		PlayOwnerAnim("critical", PLAYERANIM_CAST);
	}

	void start_spell_anim()
	{
		ScheduleDelayedEvent(2.5, "bitem_set_can_idle");
		PlayViewAnim(12);
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
