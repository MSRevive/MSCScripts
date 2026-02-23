#pragma context server

#include "items/polearms_base.as"

namespace MS
{

class PolearmsH : CGameScript
{
	PolearmsH()
	{
		const int BASE_LEVEL_REQ = 30;
		const int HOLY_CIRCLE_MP = 200;
		const float HOLY_CIRCLE_DURATION = 30.0;
		const int VMODEL_IDX = 4;
		const string PMODEL_FILE = "weapons/p_weapons4.mdl";
		const int PMODEL_IDX_FLOOR = 15;
		const int PMODEL_IDX_HANDS = 14;
		const int MELEE_DMG = 200;
		const int MELEE_RANGE = 120;
		const string MELEE_DMG_TYPE = "holy";
		const Vector3 MELEE_STARTPOS = Vector3(0, 0, 5);
		const int POLE_MIN_RANGE = 60;
		const float POLE_MIN_DMG_MULTI = 0.5;
		const float POLE_MAX_DMG_MULTI = 1.75;
		const int POLE_CAN_POKE1 = 1;
		const int POLE_CAN_POKE2 = 1;
		const int POLE_CAN_SWIPE = 0;
		const int POLE_CAN_BLOCK = 1;
		const int POLE_CAN_SPIN = 0;
		const int POLE_CAN_REPEL = 1;
		const int POLE_CAN_BACKHAND = 1;
		const int POLE_BACKHAND_DMG = 150;
		const int POLE_BACKHAND_DMG_RANGE = 10;
		const string POLE_BACKHAND_DMG_TYPE = "pierce";
		const int POLE_BACKHAND_RANGE = 40;
		const float POLE_BACKHAND_ACCURACY = 0.9;
		const int POLE_BACKHAND_REPEL = 500;
		const int POLE_CAN_POWER_THROW = 1;
		const int POLE_THROW_POWER = 800;
		const string POLE_THOW_PROJECTILE = "proj_pole_holy";
	}

	void polearm_spawn()
	{
		SetName("Holy Lance");
		SetDescription("A spear often wielded by Felewyn's Seekers");
		SetWeight(30);
		SetSize(2);
		SetValue(4000);
		SetHUDSprite("trade", 78);
	}

	void polearm_register_attacks()
	{
		int reg.attack.mpdrain = 0;
		string reg.attack.type = "strike-land";
		int reg.attack.range = 10;
		int reg.attack.dmg = 1;
		int reg.attack.dmg.range = 0;
		string reg.attack.dmg.type = "holy";
		int reg.attack.energydrain = 5;
		string reg.attack.stat = "spellcasting.divination";
		int reg.attack.hitchance = 100;
		int reg.attack.priority = 3;
		float reg.attack.delay.strike = 0.1;
		float reg.attack.delay.end = 0.2;
		int reg.attack.ofs.startpos = 0;
		int reg.attack.ofs.aimang = 0;
		int reg.attack.noise = 5000;
		string reg.attack.keys = "-attack1";
		string reg.attack.callback = "holy_circle";
		float reg.attack.chargeamt = 3.0;
		int reg.attack.reqskill = 34;
		RegisterAttack();
	}

	void holy_circle_start()
	{
		PlayViewAnim(VANIM_WIDE);
		PlayOwnerAnim("once", PANIM_SWIPE2);
		LogDebug("holy_circle_start");
	}

	void holy_circle_strike()
	{
		if (!(true)) return;
		if (GetEntityMP(GetOwner()) < HOLY_CIRCLE_MP)
		{
			SendColoredMessage(GetOwner(), "Holy Lance: Insufficient Mana for Holy Aura");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((GetEntityProperty(GetOwner(), "scriptvar")))
		{
			SendColoredMessage(GetOwner(), "Holy Lance: Holy aura already active");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		GiveMP(GetOwner());
		string HEAL_POWER = GetSkillLevel(GetOwner(), "spellcasting.divination");
		HEAL_POWER /= 4;
		CallExternal(GetOwner(), "ext_holy_aura", HOLY_CIRCLE_DURATION, 128, HEAL_POWER);
	}

	void bweapon_effect_remove()
	{
		LogDebug("bweapon_effect_remove");
		CallExternal(GetOwner(), "ext_end_holy_aura");
	}

	void bs_global_command()
	{
		if (!(param3 == "death")) return;
		if (!(param1 == GetEntityIndex(GetOwner()))) return;
		CallExternal(GetOwner(), "ext_end_holy_aura");
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		if (!(GetEntityProperty(GetOwner(), "scriptvar"))) return;
		if (GetEntityRace(param1) == "undead")
		{
			int REDUCE_DMG = 1;
		}
		if ((GetEntityProperty(param1, "scriptvar")))
		{
			int REDUCE_DMG = 1;
		}
		if (!(REDUCE_DMG)) return;
		string DMG_TAKEN = param3;
		DMG_TAKEN *= 0.5;
		SetDamage("dmg");
		return;
	}

}

}
