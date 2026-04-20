#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandPoison : CGameScript
{
	float RANGED_ATK_DURATION;
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

	MagicHandPoison()
	{
		SOUND_CHARGE = "bullchicken/bc_acid1.wav";
		SOUND_SHOOT = "bullchicken/bc_acid1.wav";
		RANGED_FORCE = 500;
		RANGED_COF = 1;
		RANGED_ATK_DURATION = 0.5;
		RANGED_PROJECTILE = "proj_poison_spell";
		RANGED_DMG_DELAY = 0.5;
		SPELL_SKILL_REQUIRED = 0;
		SPELL_PREPARE_TIME = 2;
		SPELL_DAMAGE_TYPE = "poison";
		SPELL_ENERGYDRAIN = 10;
		SPELL_MPDRAIN = 5;
		SPELL_STAT = "spellcasting.affliction";
		Precache("bullchicken/bc_acid1.wav");
	}

	void spell_spawn()
	{
		SetName("Poison");
		SetDescription("Poison - Afflicts your enemies with slow acting poison");
		Precache(SOUND_SHOOT1);
		Precache(SOUND_SHOOT2);
	}

	void cast_start()
	{
		SetGlobalVar("PASS_SPELL", "poison");
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
