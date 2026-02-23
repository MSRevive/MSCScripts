#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandAcidBolt : CGameScript
{
	int SPELL_SKILL_REQUIRED;
	int baseitem.canidle;

	MagicHandAcidBolt()
	{
		const int ANIM_CAST = 11;
		const string SOUND_CHARGE = "bullchicken/bc_attack1.wav";
		const string SOUND_SHOOT = "bullchicken/bc_attack3.wav";
		const int RANGED_FORCE = 800;
		const int RANGED_COF = 1;
		const float RANGED_ATK_DURATION = 0.5;
		const float RANGED_DMG_DELAY = 0.25;
		const string RANGED_PROJECTILE = "proj_acid_bolt";
		SPELL_SKILL_REQUIRED = 15;
		const float SPELL_PREPARE_TIME = 0.5;
		const string SPELL_DAMAGE_TYPE = "acid";
		const int SPELL_MPDRAIN = 10;
		const string SPELL_STAT = "spellcasting.affliction";
		Precache("items/magic_hand_base");
	}

	void spell_spawn()
	{
		SetName("Acidic Bolt");
		SetDescription("Fires a bolt of corrosive bile");
	}

	void cast_start()
	{
		baseitem.canidle = 0;
		/* TODO: $math(add) */ /* TODO: $math(add) */ RANGED_ATK_DURATION("start_spell_anim");
	}

	void cast_toss()
	{
		spell_casted();
		PlayOwnerAnim("critical", PLAYERANIM_CAST);
	}

	void start_spell_anim()
	{
		ScheduleDelayedEvent(2, "bitem_set_can_idle");
		PlayViewAnim(13);
	}

	void spell_casted()
	{
		// svplaysound: svplaysound 0 10 SOUND_SHOOT
		EmitSound(0, 10, SOUND_SHOOT);
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
