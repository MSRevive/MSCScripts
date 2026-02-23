#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandIceLance : CGameScript
{
	MagicHandIceLance()
	{
		const int ANIM_PREPARE = 7;
		const int ANIM_CAST = 17;
		const string SOUND_CHARGE = "none";
		const string SOUND_SHOOT = "magic/ice_strike.wav";
		const int MELEE_RANGE = 0;
		const float MELEE_DMG_DELAY = 0.5;
		const float MELEE_ATK_DURATION = 1.0;
		const int RANGED_FORCE = 800;
		const string RANGED_PROJECTILE = "proj_icelance";
		const int SPELL_DAMAGE = 400;
		const int SPELL_NOISE = 500;
		const float SPELL_PREPARE_TIME = 1.5;
		const int SPELL_MPDRAIN = 15;
		const string SPELL_STAT = "spellcasting.ice";
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
