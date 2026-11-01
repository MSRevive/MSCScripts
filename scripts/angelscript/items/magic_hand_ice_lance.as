#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandIceLance : CGameScript
{
	int ANIM_CAST;
	int ANIM_PREPARE;
	float MELEE_ATK_DURATION;
	float MELEE_DMG_DELAY;
	int MELEE_RANGE;
	int RANGED_FORCE;
	string RANGED_PROJECTILE;
	string SOUND_CHARGE;
	string SOUND_SHOOT;
	int SPELL_DAMAGE;
	int SPELL_MPDRAIN;
	int SPELL_NOISE;
	float SPELL_PREPARE_TIME;
	string SPELL_STAT;

	MagicHandIceLance()
	{
		ANIM_PREPARE = 7;
		ANIM_CAST = 17;
		SOUND_CHARGE = "none";
		SOUND_SHOOT = "magic/ice_strike.wav";
		MELEE_RANGE = 0;
		MELEE_DMG_DELAY = 0.5;
		MELEE_ATK_DURATION = 1.0;
		RANGED_FORCE = 800;
		RANGED_PROJECTILE = "proj_icelance";
		SPELL_DAMAGE = 400;
		SPELL_NOISE = 500;
		SPELL_PREPARE_TIME = 1.5;
		SPELL_MPDRAIN = 15;
		SPELL_STAT = "spellcasting.ice";
	}

	void spell_spawn()
	{
		SetName("Ice Lance");
		SetDescription("Fires deep freezing icicles.");
	}

	void spell_casted()
	{
		CallExternal(GetOwner(), "ext_tossprojectile", RANGED_PROJECTILE, "view", "none", RANGED_FORCE, SPELL_DAMAGE, 0, "spellcasting.ice");
		// svplaysound: svplaysound game.sound.item game.sound.maxvol SOUND_SHOOT
		EmitSound("game.sound.item", "game.sound.maxvol", SOUND_SHOOT);
	}

	void fake_precache()
	{
		// svplaysound: svplaysound 0 0 SOUND_SHOOT
		EmitSound(0, 0, SOUND_SHOOT);
	}

}

}
