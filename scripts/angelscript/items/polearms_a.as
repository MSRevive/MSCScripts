#pragma context server

#include "items/polearms_base.as"

namespace MS
{

class PolearmsA : CGameScript
{
	int BASE_LEVEL_REQ;
	int MELEE_DMG;
	string MELEE_DMG_TYPE;
	int MELEE_RANGE;
	string MELEE_STARTPOS;
	string PMODEL_FILE;
	int PMODEL_IDX_FLOOR;
	int PMODEL_IDX_HANDS;
	float POLE_BACKHAND_ACCURACY;
	int POLE_BACKHAND_DMG;
	int POLE_BACKHAND_DMG_RANGE;
	string POLE_BACKHAND_DMG_TYPE;
	int POLE_BACKHAND_RANGE;
	int POLE_BACKHAND_REPEL;
	int POLE_CAN_BACKHAND;
	int POLE_CAN_BLOCK;
	int POLE_CAN_POKE1;
	int POLE_CAN_POKE2;
	int POLE_CAN_POWER_THROW;
	int POLE_CAN_REPEL;
	int POLE_CAN_SPIN;
	int POLE_CAN_SWIPE;
	float POLE_MAX_DMG_MULTI;
	float POLE_MIN_DMG_MULTI;
	int POLE_MIN_RANGE;
	string POLE_THOW_PROJECTILE;
	int POLE_THROW_POWER;
	int VENOM_BURST_MP;
	int VMODEL_IDX;

	PolearmsA()
	{
		BASE_LEVEL_REQ = 30;
		VENOM_BURST_MP = 50;
		VMODEL_IDX = 14;
		PMODEL_FILE = "weapons/p_weapons4.mdl";
		PMODEL_IDX_FLOOR = 31;
		PMODEL_IDX_HANDS = 30;
		MELEE_DMG = 350;
		MELEE_RANGE = 120;
		MELEE_DMG_TYPE = "acid";
		MELEE_STARTPOS = Vector3(0, 0, 5);
		POLE_MIN_RANGE = 60;
		POLE_MIN_DMG_MULTI = 0.5;
		POLE_MAX_DMG_MULTI = 2.0;
		POLE_CAN_POKE1 = 1;
		POLE_CAN_POKE2 = 1;
		POLE_CAN_SWIPE = 0;
		POLE_CAN_BLOCK = 1;
		POLE_CAN_SPIN = 0;
		POLE_CAN_REPEL = 1;
		POLE_CAN_BACKHAND = 1;
		POLE_BACKHAND_DMG = 150;
		POLE_BACKHAND_DMG_RANGE = 10;
		POLE_BACKHAND_DMG_TYPE = "pierce";
		POLE_BACKHAND_RANGE = 40;
		POLE_BACKHAND_ACCURACY = 0.9;
		POLE_BACKHAND_REPEL = 500;
		POLE_CAN_POWER_THROW = 1;
		POLE_THROW_POWER = 700;
		POLE_THOW_PROJECTILE = "proj_pole_a";
	}

	void polearm_spawn()
	{
		SetName("Lance of Affliction");
		SetDescription("An accursed lance of profane magic");
		SetWeight(30);
		SetSize(2);
		SetValue(5000);
		SetHUDSprite("trade", 57);
	}

	void OnDeploy() override
	{
		CallExternal(GetOwner(), "ext_alance_init");
	}

	void polearm_register_attacks()
	{
		int reg.attack.mpdrain = 0;
		string reg.attack.type = "strike-land";
		int reg.attack.range = 10;
		int reg.attack.dmg = 1;
		int reg.attack.dmg.range = 0;
		string reg.attack.dmg.type = "acid";
		int reg.attack.energydrain = 5;
		string reg.attack.stat = "spellcasting.affliction";
		int reg.attack.hitchance = 100;
		int reg.attack.priority = 3;
		float reg.attack.delay.strike = 0.1;
		float reg.attack.delay.end = 0.2;
		int reg.attack.ofs.startpos = 0;
		int reg.attack.ofs.aimang = 0;
		int reg.attack.noise = 5000;
		string reg.attack.keys = "-attack1";
		string reg.attack.callback = "venom_burst";
		float reg.attack.chargeamt = 3.0;
		int reg.attack.reqskill = 30;
		RegisterAttack();
	}

	void venom_burst_start()
	{
		PlayViewAnim(VANIM_WIDE);
		PlayOwnerAnim("once", PANIM_SWIPE2);
		LogDebug("holy_circle_start");
	}

	void venom_burst_strike()
	{
		if (!(true)) return;
		if (GetEntityMP(GetOwner()) < VENOM_BURST_MP)
		{
			SendColoredMessage(GetOwner(), "Affliction Lance: Insufficient Mana for Venom Burst");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		GiveMP(GetOwner());
		string BURST_TARG_ORG = GetEntityOrigin(GetOwner());
		ClientEvent("new", "all", "effects/sfx_poison_explode", BURST_TARG_ORG, 256);
		XDoDamage(BURST_TARG_ORG, 512, GetSkillLevel(GetOwner(), "spellcasting.affliction"), 0.1, GetOwner(), GetOwner(), "spellcasting.affliction", "poison", "dmgevent:alance");
	}

	void attack_poke1_damaged_other()
	{
		if (!(RandomInt(1, 4) == 1)) return;
		if (!(GAME_PVP))
		{
			if ((IsValidPlayer(param1)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string DOT_BURN = GetSkillLevel(GetOwner(), "spellcasting.affliction");
		DOT_BURN *= 0.25;
		ApplyEffect(param1, "effects/dot_acid", 5.0, GetEntityIndex(GetOwner()), DOT_BURN, "none");
	}

	void attack_poke2_damaged_other()
	{
		if (!(GAME_PVP))
		{
			if ((IsValidPlayer(param1)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string DOT_BURN = GetSkillLevel(GetOwner(), "spellcasting.affliction");
		DOT_BURN *= 0.5;
		ApplyEffect(param1, "effects/dot_acid", 5.0, GetEntityIndex(GetOwner()), DOT_BURN, "none");
	}

}

}
