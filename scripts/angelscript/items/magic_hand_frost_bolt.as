#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandFrostBolt : CGameScript
{
	int SPELL_SKILL_REQUIRED;

	MagicHandFrostBolt()
	{
		const string SOUND_CHARGE = "magic/lightprep.wav";
		const string SOUND_SHOOT = "magic/ice_strike.wav";
		const int RANGED_FORCE = 600;
		const int RANGED_COF = 1;
		const int RANGED_ATK_DURATION = 1;
		const string RANGED_PROJECTILE = "proj_ice_bolt";
		const float RANGED_DMG_DELAY = 0.25;
		SPELL_SKILL_REQUIRED = 0;
		const int SPELL_PREPARE_TIME = 1;
		const string SPELL_DAMAGE_TYPE = "cold";
		const int SPELL_ENERGYDRAIN = 10;
		const int SPELL_MPDRAIN = 2;
		const string SPELL_STAT = "spellcasting.ice";
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
