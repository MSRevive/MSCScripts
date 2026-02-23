#pragma context server

#include "items/base_melee.as"

namespace MS
{

class SmallarmsBase : CGameScript
{
	int SMALLARMS_TURBO_ON;

	SmallarmsBase()
	{
		const int ANIM_LIFT1 = 9;
		const int ANIM_IDLE1 = 10;
		const int ANIM_IDLE_TOTAL = 1;
		const int ANIM_WIELD = 11;
		const int ANIM_UNWIELD = 12;
		const int ANIM_WIELDEDIDLE1 = 13;
		const int ANIM_ATTACK1 = 14;
		const int ANIM_ATTACK2 = 15;
		const int ANIM_IDLE_DELAY_LOW = 0;
		const int ANIM_IDLE_DELAY_HIGH = 0;
		const string MELEE_VIEWANIM_ATK = RandomInt(ANIM_ATTACK1, ANIM_ATTACK2);
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string SOUND_HITWALL1 = "weapons/dagger/daggermetal1.wav";
		const string SOUND_HITWALL2 = "weapons/dagger/daggermetal2.wav";
		const string SOUND_DRAW = "weapons/dagger/dagger2.wav";
		const string SOUND_SHOUT1 = GetEntityProperty(GetOwner(), "scriptvar");
		const string SOUND_SHOUT2 = GetEntityProperty(GetOwner(), "scriptvar");
		const string MELEE_DMG_TYPE = "pierce";
		const string MELEE_STAT = "smallarms";
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string PLAYERANIM_AIM = "knife";
		const string PLAYERANIM_SWING = "swing_knife";
		const float MELEE_ENERGY = 0.1;
	}

	void weapon_spawn()
	{
		SetHand("right");
		register_secondary();
	}

	void OnDeploy() override
	{
		if (!(true)) return;
		turbo_off();
	}

	void melee_start()
	{
		if ((CUSTOM_SWING)) return;
		string L_ANIM = MELEE_VIEWANIM_ATK;
		PlayViewAnim(L_ANIM);
	}

	void special_02_start()
	{
		if (!(true)) return;
		// svplaysound: svplaysound 2 10 $get(ent_owner,scriptvar,'PLR_SOUND_SWORDREADY')
		EmitSound(2, 10, GetEntityProperty(GetOwner(), "scriptvar"));
	}

	void special_02_strike()
	{
		if (!(true)) return;
		string NEXT_HASTE = GetEntityProperty(GetOwner(), "scriptvar");
		if (GetGameTime() < NEXT_HASTE)
		{
			string HASTE_DELAY = NEXT_HASTE;
			HASTE_DELAY -= GetGameTime();
			string HASTE_DELAY = int(HASTE_DELAY);
			SendColoredMessage(GetOwner(), "Cannot repeat haste attack yet. HASTE_DELAY");
			return;
		}
		string URDUAL_CHECK = GetEntityProperty(GetOwner(), "scriptvar");
		if (!(GetGameTime() > URDUAL_CHECK)) return;
		string SPEC_DURATION = /* TODO: $get_skill_ratio */ $get_skill_ratio(GetSkillLevel(GetOwner(), "smallarms.prof.ratio"), 15, 30);
		ApplyEffect(GetOwner(), "effects/specialattack_haste", SPEC_DURATION, GetEntityIndex(GetOwner()));
		turbo_on();
		CallExternal(GetOwner(), "ext_haste_cooldown", /* TODO: $math(add) */ SPEC_DURATION);
	}

	void turbo_on()
	{
		if (!(true)) return;
		LogDebug("turbo_on");
		if ((SMALLARMS_TURBO_ON)) return;
		SMALLARMS_TURBO_ON = 1;
		string NEW_MELEE_ATK_DURATION = MELEE_ATK_DURATION;
		string NEW_MELEE_DMG_DELAY = MELEE_DMG_DELAY;
		NEW_MELEE_ATK_DURATION /= 2;
		NEW_MELEE_DMG_DELAY /= 2;
		SetAttackProp("ent_me", 0);
		SetAttackProp("ent_me", 0);
	}

	void turbo_off()
	{
		if (!(true)) return;
		LogDebug("turbo_off");
		if (!(SMALLARMS_TURBO_ON)) return;
		SMALLARMS_TURBO_ON = 0;
		if ((GetEntityProperty(GetOwner(), "haseffect")))
		{
			RemoveEffect(GetOwner(), "player_haste");
		}
		SetAttackProp("ent_me", 0);
		SetAttackProp("ent_me", 0);
	}

	void register_secondary()
	{
		if ((CUSTOM_REGISTER_SECONDARY)) return;
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "-attack1";
		string reg.attack.range = MELEE_RANGE;
		string reg.attack.dmg = MELEE_DMG;
		string reg.attack.dmg.range = MELEE_DMG_RANGE;
		string reg.attack.dmg.type = MELEE_DMG_TYPE;
		string reg.attack.stat = MELEE_STAT;
		string reg.attack.hitchance = MELEE_ACCURACY;
		int reg.attack.priority = 2;
		float reg.attack.delay.strike = 1.0;
		float reg.attack.delay.end = 1.2;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "special_02";
		int reg.attack.noise = 1000;
		float reg.attack.chargeamt = 2.0;
		int reg.attack.reqskill = 4;
		int reg.attack.dmg.ignore = 1;
		if (BASE_LEVEL_REQ > reg.attack.reqskill)
		{
			reg.attack.reqskill += BASE_LEVEL_REQ;
		}
		RegisterAttack();
	}

	void bs_global_command()
	{
		if (!(true)) return;
		LogDebug("bs_global_command GetEntityName(param1) vs GetEntityName(GetOwner())");
		if (!(param1 == GetEntityIndex(GetOwner()))) return;
		ScheduleDelayedEvent(1.0, "turbo_off");
	}

	void activate_items()
	{
		if (!(true)) return;
		LogDebug("activate_items GetEntityName(param1) vs GetEntityName(GetOwner())");
		if (!(GetEntityName(param1) == GetEntityName(GetOwner()))) return;
		ScheduleDelayedEvent(1.0, "turbo_off");
	}

	void bweapon_effect_remove()
	{
		turbo_off();
	}

}

}
