#pragma context server

#include "items/base_weapon.as"

namespace MS
{

class BaseMelee : CGameScript
{
	string BITEM_UNDERSKILLED;
	string BWEAPON_CHARGE_PERCENT;
	string NOOB_LOOP;
	string PARRY_MULTI_OUT;
	string PARRY_VALUE;
	string WEAPON_PRIMARY_SKILL;

	BaseMelee()
	{
		const int MELEE_NOISE = 650;
		const string SPECIAL01_SND = GetEntityProperty(GetOwner(), "scriptvar");
		const float FREQ_NUB = 30.0;
		const string MELEE_CALLBACK = "melee";
		const string MELEE_CALLBACK_CHARGED = "melee";
		const float BWEAPON_DBL_CHARGE_ADJ = 2.0;
	}

	void weapon_spawn()
	{
		register_normal();
	}

	void register_normal()
	{
		if ((CUSTOM_REGISTER_NORMAL)) return;
		string F_BASE_LEVEL_REQ = BASE_LEVEL_REQ;
		if (BASE_LEVEL_REQ == "BASE_LEVEL_REQ")
		{
			int F_BASE_LEVEL_REQ = 0;
		}
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "+attack1";
		string reg.attack.range = MELEE_RANGE;
		string reg.attack.dmg = MELEE_DMG;
		string reg.attack.dmg.range = MELEE_DMG_RANGE;
		string reg.attack.dmg.type = MELEE_DMG_TYPE;
		string reg.attack.energydrain = MELEE_ENERGY;
		string reg.attack.stat = MELEE_STAT;
		string reg.attack.hitchance = MELEE_ACCURACY;
		int reg.attack.priority = 0;
		string reg.attack.delay.strike = MELEE_DMG_DELAY;
		string reg.attack.delay.end = MELEE_ATK_DURATION;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = MELEE_CALLBACK;
		string reg.attack.noise = MELEE_NOISE;
		string reg.attack.reqskill = F_BASE_LEVEL_REQ;
		WEAPON_PRIMARY_SKILL = reg.attack.stat;
		RegisterAttack();
		register_charge1();
	}

	void OnDeploy() override
	{
		if (!(true)) return;
		weapon_equip();
		string FIND_MELEE_STAT = "skill.";
		FIND_MELEE_STAT += MELEE_STAT;
		if (GetEntityProperty(GetOwner(), "find_melee_stat") < BASE_LEVEL_REQ)
		{
			ScheduleDelayedEvent(5.0, "nub_loop");
			BITEM_UNDERSKILLED = 1;
			SendColoredMessage(GetOwner(), "You lack the skill to properly wield this weapon!");
			string OUT_STR = "You lack the proficiency to wield this weapon. ( requires: ";
			OUT_STR += MELEE_STAT;
			OUT_STR += " proficiency ";
			OUT_STR += BASE_LEVEL_REQ;
			OUT_STR += " )";
			SendInfoMsg(GetOwner(), "Insufficient Skill OUT_STR");
			NOOB_LOOP = 1;
		}
	}

	void register_charge1()
	{
		if ((CUSTOM_REGISTER_CHARGE1)) return;
		if ((IS_TWO_HANDED_SWORD)) return;
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "+attack1";
		string reg.attack.range = MELEE_RANGE;
		string reg.attack.dmg = MELEE_DMG;
		string reg.attack.dmg.range = MELEE_DMG_RANGE;
		string reg.attack.dmg.type = MELEE_DMG_TYPE;
		string reg.attack.energydrain = MELEE_ENERGY;
		string reg.attack.stat = MELEE_STAT;
		string reg.attack.hitchance = MELEE_ACCURACY;
		int reg.attack.priority = 0;
		string reg.attack.delay.strike = MELEE_DMG_DELAY;
		string reg.attack.delay.end = MELEE_ATK_DURATION;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = MELEE_CALLBACK_CHARGED;
		string reg.attack.noise = MELEE_NOISE;
		int reg.attack.priority = 1;
		string reg.attack.keys = "-attack1";
		string reg.attack.callback = "special_01";
		reg.attack.dmg *= BWEAPON_DBL_CHARGE_ADJ;
		reg.attack.energydrain *= BWEAPON_DBL_CHARGE_ADJ;
		float reg.attack.chargeamt = 1.0;
		int reg.attack.reqskill = 2;
		if (BASE_LEVEL_REQ > reg.attack.reqskill)
		{
			reg.attack.reqskill += BASE_LEVEL_REQ;
		}
		RegisterAttack();
	}

	void melee_start()
	{
		if ((MELEE_OVERRIDE)) return;
		bm_attack_start();
	}

	void bm_attack_start()
	{
		PlayViewAnim(MELEE_VIEWANIM_ATK);
		if (PLAYERANIM_SWING != "PLAYERANIM_SWING")
		{
			PlayOwnerAnim("once", PLAYERANIM_SWING);
		}
		MELEE_SOUND_DELAY("melee_playsound");
	}

	void melee_playsound()
	{
		EmitSound(GetOwner(), "const.snd.weapon", SOUND_SWIPE, "const.snd.maxvol");
	}

	void game_attack_done()
	{
		item_idle();
	}

	void special_01_start()
	{
		if ((SPECIAL1_OVERRIDE)) return;
		melee_start();
		if (!(true)) return;
		// svplaysound: svplaysound 1 10 SPECIAL01_SND
		EmitSound(1, 10, SPECIAL01_SND);
	}

	void hitwall()
	{
		if ((OVERRIDE_HITWALL)) return;
		if (!(SOUND_HITWALL1 != "SOUND_HITWALL1")) return;
		// PlayRandomSound from: SOUND_HITWALL1, SOUND_HITWALL2
		array<string> sounds = {SOUND_HITWALL1, SOUND_HITWALL2};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void nub_loop()
	{
		if (!(true)) return;
		if (!(NOOB_LOOP))
		{
			BITEM_UNDERSKILLED = 0;
		}
		if (!(NOOB_LOOP)) return;
		BITEM_UNDERSKILLED = 1;
		string FIND_MELEE_STAT = "skill.";
		FIND_MELEE_STAT += MELEE_STAT;
		if (!(GetEntityProperty(GetOwner(), "find_melee_stat") < BASE_LEVEL_REQ)) return;
		FREQ_NUB("nub_loop");
		string OUT_STR = "You lack the proficiency to wield this weapon. ( requires: ";
		OUT_STR += MELEE_STAT;
		OUT_STR += " proficiency ";
		OUT_STR += BASE_LEVEL_REQ;
		OUT_STR += " )";
		SendInfoMsg(GetOwner(), "Insufficient Skill OUT_STR");
		SendColoredMessage(GetOwner(), "You lack the skill to wield this weapon.");
	}

	void game_wear()
	{
		weapon_equip();
		NOOB_LOOP = 0;
	}

	void game_removefromowner()
	{
		NOOB_LOOP = 0;
	}

	void weapon_equip()
	{
		if ((AM_SHIELD))
		{
			PARRY_VALUE = "am_shield";
			PARRY_MULTI_OUT = PARRY_MULTI;
		}
		if (!(AM_SHIELD))
		{
			string FIND_MELEE_STAT = "skill.";
			FIND_MELEE_STAT += MELEE_STAT;
			PARRY_VALUE = GetEntityProperty(GetOwner(), "find_melee_stat");
		}
		if ((NO_PARRY))
		{
			PARRY_VALUE = 0;
		}
	}

	void game_setchargepercent()
	{
		BWEAPON_CHARGE_PERCENT = param1;
	}

	void melee_damaged_other()
	{
		if ((BITEM_UNDERSKILLED))
		{
			SetDamage("dmg");
			return;
		}
		if ((BWEAPON_NO_PERCENT_CHARGE)) return;
		if (!(BWEAPON_CHARGE_PERCENT < 1)) return;
		if (BWEAPON_CHARGE_PERCENT > 0.25)
		{
			BWEAPON_CHARGE_PERCENT -= 0.25;
			string L_CHARGE_RATIO = /* TODO: $ratio */ $ratio(BWEAPON_CHARGE_PERCENT, 1.25, BWEAPON_DBL_CHARGE_ADJ);
			string NEW_DMG = param2;
			NEW_DMG *= L_CHARGE_RATIO;
			SetDamage("dmg");
			return;
			LogDebug("Adjusted dmg x L_CHARGE_RATIO");
			BWEAPON_CHARGE_PERCENT = 0;
			string CUR_DRAIN = MELEE_ENERGY;
			CUR_DRAIN *= BWEAPON_CHARGE_PERCENT;
			DrainStamina(GetOwner());
		}
	}

}

}
