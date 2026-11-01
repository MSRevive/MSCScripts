#pragma context server

#include "items/polearms_base.as"

namespace MS
{

class PolearmsSl : CGameScript
{
	int BASE_LEVEL_REQ;
	int MELEE_DMG;
	string MELEE_DMG_TYPE;
	int MELEE_RANGE;
	string MELEE_STARTPOS;
	int MP_SHADOWBURST;
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
	int POLE_THROW_MP;
	int POLE_THROW_POWER;
	int VMODEL_IDX;

	PolearmsSl()
	{
		BASE_LEVEL_REQ = 35;
		MP_SHADOWBURST = 100;
		VMODEL_IDX = 16;
		PMODEL_FILE = "weapons/p_weapons4.mdl";
		PMODEL_IDX_HANDS = 60;
		PMODEL_IDX_FLOOR = 61;
		MELEE_DMG = 250;
		MELEE_RANGE = 120;
		MELEE_DMG_TYPE = "dark";
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
		POLE_BACKHAND_DMG = 100;
		POLE_BACKHAND_DMG_RANGE = 10;
		POLE_BACKHAND_DMG_TYPE = "dark";
		POLE_BACKHAND_RANGE = 40;
		POLE_BACKHAND_ACCURACY = 0.9;
		POLE_BACKHAND_REPEL = 500;
		POLE_CAN_POWER_THROW = 1;
		POLE_THROW_POWER = 700;
		POLE_THOW_PROJECTILE = "proj_pole_sl";
		POLE_THROW_MP = 10;
	}

	void polearm_spawn()
	{
		SetName("Shadow Lance");
		SetDescription("A sinuous lance of destructive energies");
		SetWeight(30);
		SetSize(2);
		SetValue(5000);
		SetHUDSprite("trade", 196);
	}

	void polearm_register_attacks()
	{
		string reg.attack.mpdrain = MP_SHADOWBURST;
		string reg.attack.type = "strike-land";
		int reg.attack.range = 10;
		int reg.attack.dmg = 1;
		int reg.attack.dmg.range = 0;
		string reg.attack.dmg.type = "dark";
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
		string reg.attack.callback = "shadow_burst";
		float reg.attack.chargeamt = 3.0;
		int reg.attack.reqskill = 30;
		RegisterAttack();
	}

	void shadow_burst_start()
	{
		if (!(true)) return;
		int REQS_MET = 1;
		if (GetEntityMP(GetOwner()) < MP_SHADOWBURST)
		{
			int REQS_MET = 0;
		}
		if (GetSkillLevel(GetOwner(), "spellcasting.affliction") < 15)
		{
			SendColoredMessage(GetOwner(), "Shadowlance: Insufficient Affliction skill for Defiling Burst.");
			int REQS_MET = 0;
		}
		if ((REQS_MET))
		{
			// TODO: splayviewanim ent_me VANIM_WIDE
			PlayOwnerAnim("once", PANIM_SWIPE2);
		}
		else
		{
			CancelAttack();
		}
	}

	void shadow_burst_strike()
	{
		string L_BURST_ORG = GetEntityOrigin(GetOwner());
		L_BURST_ORG += "z";
		if ((IsDucking(GetOwner())))
		{
			L_BURST_ORG += "z";
		}
		CallExternal(GetOwner(), "ext_dburst", L_BURST_ORG, 170, 1, 1);
	}

	void attack_poke2_damaged_other()
	{
		LogDebug("attack_poke2_damaged_other");
		string L_CUR_TARG = param1;
		if ((IsValidPlayer(L_CUR_TARG)))
		{
			if (!(GAME_PVP))
			{
			}
			return;
		}
		string L_DOT_SKILL = GetSkillLevel(GetOwner(), "spellcasting.affliction");
		L_DOT_SKILL *= 0.5;
		ApplyEffect(L_CUR_TARG, "effects/dot_dark", 5.0, GetEntityIndex(GetOwner()), L_DOT_SKILL, "polearms");
	}

}

}
