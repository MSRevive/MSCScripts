#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandBlizzard : CGameScript
{
	int SPELL_SKILL_REQUIRED;
	int baseitem.canidle;

	MagicHandBlizzard()
	{
		const string SOUND_CHARGE = "magic/fireball_powerup.wav";
		const string SOUND_SHOOT = "magic/fireball_strike.wav";
		const int ANIM_CAST = 11;
		const int RANGED_FORCE = 1000;
		const string RANGED_COF = "10;1";
		const int RANGED_ATK_DURATION = 1;
		const string RANGED_PROJECTILE = "proj_blizzard2";
		const float RANGED_DMG_DELAY = 0.5;
		SPELL_SKILL_REQUIRED = 8;
		const int SPELL_PREPARE_TIME = 3;
		const string SPELL_DAMAGE_TYPE = "cold";
		const int SPELL_ENERGYDRAIN = 5;
		const int SPELL_MPDRAIN = 20;
		const string SPELL_STAT = "spellcasting.ice";
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
