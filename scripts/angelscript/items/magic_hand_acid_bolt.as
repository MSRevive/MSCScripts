#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandAcidBolt : CGameScript
{
	int ANIM_CAST;
	float RANGED_ATK_DURATION;
	int RANGED_COF;
	float RANGED_DMG_DELAY;
	int RANGED_FORCE;
	string RANGED_PROJECTILE;
	string SOUND_CHARGE;
	string SOUND_SHOOT;
	string SPELL_DAMAGE_TYPE;
	int SPELL_MPDRAIN;
	float SPELL_PREPARE_TIME;
	int SPELL_SKILL_REQUIRED;
	string SPELL_STAT;
	int baseitem.canidle;

	MagicHandAcidBolt()
	{
		ANIM_CAST = 11;
		SOUND_CHARGE = "bullchicken/bc_attack1.wav";
		SOUND_SHOOT = "bullchicken/bc_attack3.wav";
		RANGED_FORCE = 800;
		RANGED_COF = 1;
		RANGED_ATK_DURATION = 0.5;
		RANGED_DMG_DELAY = 0.25;
		RANGED_PROJECTILE = "proj_acid_bolt";
		SPELL_SKILL_REQUIRED = 15;
		SPELL_PREPARE_TIME = 0.5;
		SPELL_DAMAGE_TYPE = "acid";
		SPELL_MPDRAIN = 10;
		SPELL_STAT = "spellcasting.affliction";
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
		((RANGED_ATK_DURATION + RANGED_DMG_DELAY) + 0_75)("start_spell_anim");
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
