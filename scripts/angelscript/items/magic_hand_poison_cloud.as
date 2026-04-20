#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandPoisonCloud : CGameScript
{
	int CLOUD_COUNT;
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

	MagicHandPoisonCloud()
	{
		SOUND_CHARGE = "magic/fireball_powerup.wav";
		SOUND_SHOOT = "magic/fireball_strike.wav";
		RANGED_FORCE = 1500;
		RANGED_COF = "1;1";
		RANGED_ATK_DURATION = 1;
		RANGED_PROJECTILE = "proj_poison_cloud";
		RANGED_DMG_DELAY = 0.5;
		SPELL_SKILL_REQUIRED = 15;
		SPELL_PREPARE_TIME = 2;
		SPELL_DAMAGE_TYPE = "poison";
		SPELL_ENERGYDRAIN = 5;
		SPELL_MPDRAIN = 40;
		SPELL_STAT = "spellcasting.affliction";
	}

	void spell_spawn()
	{
		SetName("Poison Cloud");
		SetDescription("Creates a cloud of extremely deadly poison");
		CLOUD_COUNT = 0;
	}

	void spell_casted()
	{
		CLOUD_COUNT += 1;
		// svplaysound: svplaysound game.sound.item game.sound.maxvol SOUND_SHOOT
		EmitSound("game.sound.item", "game.sound.maxvol", SOUND_SHOOT);
	}

	void remove_hands()
	{
		DeleteEntity(GetOwner());
	}

	void fake_precache()
	{
		// svplaysound: svplaysound 0 0 SOUND_SHOOT
		EmitSound(0, 0, SOUND_SHOOT);
		// svplaysound: svplaysound 0 0 SOUND_CHARGE
		EmitSound(0, 0, SOUND_CHARGE);
	}

}

}
