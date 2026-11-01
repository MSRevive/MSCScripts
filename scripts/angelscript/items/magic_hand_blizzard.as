#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandBlizzard : CGameScript
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

	MagicHandBlizzard()
	{
		SOUND_CHARGE = "magic/fireball_powerup.wav";
		SOUND_SHOOT = "magic/fireball_strike.wav";
		ANIM_CAST = 11;
		RANGED_FORCE = 1000;
		RANGED_COF = "10;1";
		RANGED_ATK_DURATION = 1;
		RANGED_PROJECTILE = "proj_blizzard2";
		RANGED_DMG_DELAY = 0.5;
		SPELL_SKILL_REQUIRED = 8;
		SPELL_PREPARE_TIME = 3;
		SPELL_DAMAGE_TYPE = "cold";
		SPELL_ENERGYDRAIN = 5;
		SPELL_MPDRAIN = 20;
		SPELL_STAT = "spellcasting.ice";
	}

	void spell_spawn()
	{
		SetName("Blizzard");
		SetDescription("Slows and damages multiple opponents");
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

	void spell_casted()
	{
		// svplaysound: svplaysound game.sound.item game.sound.maxvol SOUND_SHOOT
		EmitSound("game.sound.item", "game.sound.maxvol", SOUND_SHOOT);
	}

	void start_spell_anim()
	{
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
