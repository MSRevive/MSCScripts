#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandPoison : CGameScript
{
	int SPELL_SKILL_REQUIRED;

	MagicHandPoison()
	{
		const string SOUND_CHARGE = "bullchicken/bc_acid1.wav";
		const string SOUND_SHOOT = "bullchicken/bc_acid1.wav";
		const int RANGED_FORCE = 500;
		const int RANGED_COF = 1;
		const float RANGED_ATK_DURATION = 0.5;
		const string RANGED_PROJECTILE = "proj_poison_spell";
		const float RANGED_DMG_DELAY = 0.5;
		SPELL_SKILL_REQUIRED = 0;
		const int SPELL_PREPARE_TIME = 2;
		const string SPELL_DAMAGE_TYPE = "poison";
		const int SPELL_ENERGYDRAIN = 10;
		const int SPELL_MPDRAIN = 5;
		const string SPELL_STAT = "spellcasting.affliction";
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
