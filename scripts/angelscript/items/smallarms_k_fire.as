#pragma context server

#include "items/smallarms_base.as"

namespace MS
{

class SmallarmsKFire : CGameScript
{
	int KNIFE_RESTORED;

	SmallarmsKFire()
	{
		const int BASE_LEVEL_REQ = 15;
		const int CUSTOM_REGISTER_CHARGE1 = 1;
		const int CUSTOM_REGISTER_SECONDARY = 1;
		const string RANGED_ATK_DURATION = "0.1s";
		const string RANGED_DMG_TYPE = "fire";
		const string RANGED_STAT = "smallarms";
		const string RANGED_PROJECTILE = "proj_k_knife";
		const Vector3 RANGED_AIMANGLE = Vector3(0, 0, 0);
		const Vector3 RANGED_STARTPOS = Vector3(0, 0, -20);
		const float RANGED_PULLTIME = 0.1;
		const string SOUND_RETURN = "weapons/dagger/dagger2.wav";
		const string EFFECT_TYPE = "effects/dot_fire";
		const string EFFECT_SKILL = "skill.spellcasting.fire";
		const int EFFECT_DURATION = 5;
		const string MODEL_VIEW = "viewmodels/v_smallarms.mdl";
		const int MODEL_VIEW_IDX = 5;
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_IDLE_TOTAL = 1;
		const int ANIM_WIELD = 2;
		const int ANIM_UNWIELD = 3;
		const int ANIM_WIELDEDIDLE1 = 4;
		const int ANIM_ATTACK1 = 5;
		const int ANIM_ATTACK2 = 6;
		const string MODEL_HANDS = "weapons/p_weapons2.mdl";
		const string MODEL_WORLD = "weapons/p_weapons2.mdl";
		const int MELEE_RANGE = 50;
		const float MELEE_DMG_DELAY = 0.2;
		const float MELEE_ATK_DURATION = 0.9;
		const float MELEE_ENERGY = 0.6;
		const int MELEE_DMG = 225;
		const int MELEE_DMG_RANGE = 75;
		const float MELEE_ACCURACY = 0.8;
		const float MELEE_ALIGN_BASE = 3.6;
		const int MELEE_ALIGN_TIP = 0;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.25;
		const string PLAYERANIM_AIM = "knife";
		const string PLAYERANIM_SWING = "swing_knife";
		const string SOUND_HITWALL2 = "ambience/steamburst1.wav";
		const int MODEL_BODY_OFS = 32;
		const string ANIM_PREFIX = "firedagger";
	}

	void weapon_spawn()
	{
		SetName("Kharaztorant Fire Blade");
		SetDescription("A enchanted throwing knife used by the Kharaztorant cult");
		SetWeight(3);
		SetSize(3);
		SetValue(800);
		SetHUDSprite("trade", 107);
	}

	void OnDeploy() override
	{
		CallExternal(GetOwner(), "ext_set_alco_type", "fire", GetEntityIndex(GetOwner()));
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (!(RandomInt(1, 5) == 1)) return;
		string BURN_DAMAGE = GetEntityProperty(GetOwner(), "effect_skill");
		BURN_DAMAGE /= 3;
		BURN_DAMAGE += Random(1, 3);
		if (BURN_DAMAGE < 5)
		{
			int BURN_DAMAGE = 5;
		}
		if (!(true)) return;
		if ((IsValidPlayer(param2)))
		{
			if ("game.pvp" < 1)
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ApplyEffect(param2, EFFECT_TYPE, EFFECT_DURATION, GetEntityIndex(GetOwner()), BURN_DAMAGE, "smallarms");
	}

	void register_charge1()
	{
		string reg.attack.type = "charge-throw-projectile";
		string reg.attack.dmg.type = "fire";
		string reg.attack.energydrain = MELEE_ENERGY;
		string reg.attack.stat = "smallarms";
		string reg.attack.noise = MELEE_NOISE;
		int reg.attack.mpdrain = 0;
		int reg.attack.ammodrain = 0;
		string reg.attack.projectile = "proj_k_knife";
		string reg.attack.type = "charge-throw-projectile";
		string reg.attack.hold_min&max = "0.1;0.1";
		string reg.attack.dmg.type = "fire";
		int reg.attack.range = 600;
		int reg.attack.COF = 0;
		int reg.attack.priority = 1;
		float reg.attack.delay.strike = 0.1;
		float reg.attack.delay.end = 0.1;
		string reg.attack.ofs.startpos = RANGED_STARTPOS;
		string reg.attack.ofs.aimang = RANGED_AIMANGLE;
		int reg.attack.priority = 1;
		string reg.attack.keys = "-attack1";
		string reg.attack.callback = "tossknife";
		float reg.attack.chargeamt = 1.0;
		int reg.attack.reqskill = 17;
		RegisterAttack();
	}

	void tossknife_start()
	{
		SetModel("none");
		SetWorldModel("none");
		SetViewModel("none");
		PlayViewAnim(4);
		KNIFE_RESTORED = 0;
		if ((true))
		{
			EmitSound(GetOwner(), 0, GetEntityProperty(GetOwner(), "scriptvar"), 8);
			ScheduleDelayedEvent(0.1, "lock_weapon");
		}
		if (!(false)) return;
		ScheduleDelayedEvent(0.25, "knife_restore_cl");
	}

	void lock_weapon()
	{
		ApplyEffect(GetOwner(), "effects/effect_templock");
		ScheduleDelayedEvent(0.25, "knife_return");
	}

	void tossknife_strike()
	{
		PlayOwnerAnim("critical", "bow_release");
	}

	void knife_return()
	{
		SetViewModel(MODEL_VIEW);
		SetModel(MODEL_WORLD);
		SetWorldModel(MODEL_WORLD);
		EmitSound(GetOwner(), 2, SOUND_RETURN, 8);
		CallExternal(GetOwner(), "ext_end_templock");
	}

	void knife_restore_cl()
	{
		SetViewModel(MODEL_VIEW);
		SetModel(MODEL_WORLD);
		SetWorldModel(MODEL_WORLD);
		if ((KNIFE_RESTORED)) return;
		PlayViewAnim(ANIM_LIFT1);
	}

	void melee_start()
	{
		SetViewModel(MODEL_VIEW);
		SetModel(MODEL_WORLD);
		SetWorldModel(MODEL_WORLD);
		KNIFE_RESTORED = 1;
	}

}

}
