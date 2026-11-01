#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandFrostBolt : CGameScript
{
	int RANGED_ATK_DURATION;
	int RANGED_COF;
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

	MagicHandFrostBolt()
	{
		SOUND_CHARGE = "magic/lightprep.wav";
		SOUND_SHOOT = "magic/ice_strike.wav";
		RANGED_FORCE = 600;
		RANGED_COF = 1;
		RANGED_ATK_DURATION = 1;
		RANGED_PROJECTILE = "proj_ice_bolt";
		RANGED_DMG_DELAY = 0.25;
		SPELL_SKILL_REQUIRED = 0;
		SPELL_PREPARE_TIME = 1;
		SPELL_DAMAGE_TYPE = "cold";
		SPELL_ENERGYDRAIN = 10;
		SPELL_MPDRAIN = 2;
		SPELL_STAT = "spellcasting.ice";
		Precache("items/magic_hand_base");
	}

	void spell_spawn()
	{
		SetName("Frost Bolt");
		SetDescription("Fires a shard of ice to slow a single enemy.");
		Precache(SOUND_SHOOT1);
		Precache(SOUND_SHOOT2);
	}

	void cast_start()
	{
		SetGlobalVar("PASS_SPELL", "frostbolt");
		PlayViewAnim("lift");
		PlayOwnerAnim("critical", PLAYERANIM_PREPARE);
		EmitSound(GetOwner(), "game.sound.item", SOUND_CHARGE, "game.sound.maxvol");
	}

	void spell_casted()
	{
		// svplaysound: svplaysound game.sound.item game.sound.maxvol SOUND_SHOOT
		EmitSound("game.sound.item", "game.sound.maxvol", SOUND_SHOOT);
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
