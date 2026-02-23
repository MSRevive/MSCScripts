#pragma context server

#include "items/bows_base.as"

namespace MS
{

class BowsFrost : CGameScript
{
	string ABORT_PREP;
	int BOW_PREPPING;
	string BOW_PREP_SCRIPT_ID;
	int NOT_BOGUS_SCRIPT;
	string REMOVE_LOOP_ACTIVE;
	int RESIST_ACTIVE;

	BowsFrost()
	{
		const int BASE_LEVEL_REQ = 25;
		const int MODEL_VIEW_IDX = 8;
		const string MODEL_VIEW = "viewmodels/v_bows.mdl";
		const string MODEL_HANDS = "weapons/p_weapons3.mdl";
		const string MODEL_WORLD = "weapons/p_weapons3.mdl";
		const string MODEL_WEAR = "weapons/p_weapons3.mdl";
		const string SOUND_SHOOT = "weapons/bow/bow.wav";
		const string ITEM_NAME = "longbow";
		const string ANIM_PREFIX = "standard";
		const int MODEL_BODY_OFS = 44;
		const Vector3 RANGED_AIMANGLE = Vector3(0, 0, 0);
		const string SOUND_RESISTUP = "magic/frost_reverse.wav";
		const int CUSTOM_ATTACK = 1;
		const string SOUND_RESIST_PREP = "magic/gaus_warmup.wav";
		const string SOUND_RESIST_LOOP = "ambience/pulsemachine.wav";
		const string SOUND_RESIST_LOCK = "weapons/egon_off1.wav";
	}

	void bow_spawn()
	{
		SetName("Frost Bow");
		SetDescription("An icy bow that fires icy projectiles.");
		SetWeight(100);
		SetValue(1500);
		SetHUDSprite("trade", 135);
		custom_register();
	}

	void custom_register()
	{
		string reg.attack.type = "charge-throw-projectile";
		string reg.attack.keys = "+attack1";
		string reg.attack.hold_min&max = "1.1;1.3";
		string reg.attack.dmg.type = "magic";
		int reg.attack.range = 1500;
		int reg.attack.energydrain = 1;
		string reg.attack.stat = "archery";
		string reg.attack.COF = "1;1";
		string reg.attack.projectile = "proj_arrow_fbow";
		int reg.attack.priority = 0;
		float reg.attack.delay.strike = 1.2;
		float reg.attack.delay.end = 1.2;
		Vector3 reg.attack.ofs.startpos = Vector3(0, 0, 10);
		string reg.attack.ofs.aimang = RANGED_AIMANGLE;
		int reg.attack.ammodrain = 0;
		string reg.attack.callback = "ranged";
		int reg.attack.noise = 1000;
		RegisterAttack();
	}

	void bweapon_effect_activate()
	{
		if (!(true)) return;
		LogDebug("bweapon_effect_activate BOW_PREPPING RESIST_ACTIVE");
		if ((BOW_PREPPING)) return;
		if ((RESIST_ACTIVE)) return;
		NOT_BOGUS_SCRIPT = 1;
		setup_bow();
	}

	void setup_bow()
	{
		if (!(true)) return;
		if ((BOW_PREPPING)) return;
		ScheduleDelayedEvent(0.1, "prep_bow");
		if (!(REMOVE_LOOP_ACTIVE))
		{
			ABORT_PREP = 0;
			REMOVE_LOOP_ACTIVE = 1;
			check_to_remove_loop();
		}
	}

	void prep_bow()
	{
		if (!(true)) return;
		if ((RESIST_ACTIVE)) return;
		BOW_PREPPING = 1;
		EmitSound(GetOwner(), 0, SOUND_RESIST_PREP, 10);
		ScheduleDelayedEvent(10.0, "activate_resistance");
		ClientEvent("new", "all", "items/bows_frost_cl", GetEntityIndex(GetOwner()));
		BOW_PREP_SCRIPT_ID = "game.script.last_sent_id";
		ScheduleDelayedEvent(3.0, "play_resist_loop");
	}

	void play_resist_loop()
	{
		if (!(true)) return;
		if (!(BOW_PREPPING)) return;
		// svplaysound: svplaysound 1 10 SOUND_RESIST_LOOP
		EmitSound(1, 10, SOUND_RESIST_LOOP);
	}

	void activate_resistance()
	{
		if (!(true)) return;
		if (!(BOW_PREPPING)) return;
		BOW_PREPPING = 0;
		if ((RESIST_ACTIVE)) return;
		RESIST_ACTIVE = 1;
		CallExternal(GetOwner(), "ext_register_weapon", GetEntityIndex(GetOwner()), "cbow", "cold", 75);
		EmitSound(GetOwner(), 2, SOUND_RESIST_LOCK, 10);
		// svplaysound: svplaysound 1 0 SOUND_RESIST_LOOP
		EmitSound(1, 0, SOUND_RESIST_LOOP);
	}

	void check_to_remove_loop()
	{
		if (!(true)) return;
		if (!(REMOVE_LOOP_ACTIVE)) return;
		ScheduleDelayedEvent(1.0, "check_to_remove_loop");
		if (!(IsEntityAlive(GetOwner())))
		{
			bweapon_effect_remove();
		}
	}

	void bweapon_effect_remove()
	{
		if (!(true)) return;
		LogDebug("bweapon_effect_remove BOW_PREPPING RESIST_ACTIVE");
		REMOVE_LOOP_ACTIVE = 0;
		if ((BOW_PREPPING))
		{
			abort_prep();
		}
		if (!(RESIST_ACTIVE)) return;
		CallExternal(GetOwner(), "ext_register_weapon", GetEntityIndex(GetOwner()), "cbow", "remove");
		RESIST_ACTIVE = 0;
	}

	void abort_prep()
	{
		if (!(true)) return;
		LogDebug("abort_prep BOW_PREP_SCRIPT_ID");
		// svplaysound: svplaysound 1 0 SOUND_RESIST_LOOP
		EmitSound(1, 0, SOUND_RESIST_LOOP);
		REMOVE_LOOP_ACTIVE = 0;
		RESIST_ACTIVE = 0;
		BOW_PREPPING = 0;
		ClientEvent("update", "all", BOW_PREP_SCRIPT_ID, "remove_sprites");
	}

}

}
