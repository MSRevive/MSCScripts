#pragma context server

#include "items/polearms_base.as"

namespace MS
{

class PolearmsDra : CGameScript
{
	int BASE_LEVEL_REQ;
	int FIRE_BURST_MP;
	int FREEZE_COUNT;
	string FREEZE_TARGS;
	string ICE_WAVE_YAW;
	int MELEE_DMG;
	string MELEE_DMG_TYPE;
	int MELEE_RANGE;
	string PMODEL_FILE;
	int PMODEL_IDX_FLOOR;
	int PMODEL_IDX_HANDS;
	float POLE_BACKHAND_ACCURACY;
	int POLE_BACKHAND_DMG;
	int POLE_BACKHAND_DMG_RANGE;
	string POLE_BACKHAND_DMG_TYPE;
	int POLE_BACKHAND_RANGE;
	int POLE_BACKHAND_REPEL;
	int POLE_BACKHAND_STUN;
	float POLE_BACKHAND_STUN_CHANCE;
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
	int POLE_POKE1_ENHANCED;
	string POLE_THOW_PROJECTILE;
	int POLE_THROW_MP;
	int POLE_THROW_POWER;
	int VMODEL_IDX;

	PolearmsDra()
	{
		BASE_LEVEL_REQ = 15;
		FIRE_BURST_MP = 25;
		VMODEL_IDX = 12;
		PMODEL_FILE = "weapons/p_weapons4.mdl";
		PMODEL_IDX_FLOOR = 21;
		PMODEL_IDX_HANDS = 20;
		MELEE_DMG = 210;
		MELEE_RANGE = 110;
		MELEE_DMG_TYPE = "fire";
		POLE_MIN_RANGE = 60;
		POLE_MIN_DMG_MULTI = 0.5;
		POLE_MAX_DMG_MULTI = 1.75;
		POLE_CAN_POKE1 = 1;
		POLE_CAN_POKE2 = 1;
		POLE_CAN_SWIPE = 0;
		POLE_CAN_BLOCK = 1;
		POLE_CAN_SPIN = 0;
		POLE_CAN_REPEL = 1;
		POLE_CAN_BACKHAND = 1;
		POLE_BACKHAND_DMG = 300;
		POLE_BACKHAND_DMG_RANGE = 10;
		POLE_BACKHAND_DMG_TYPE = "blunt";
		POLE_BACKHAND_RANGE = 40;
		POLE_BACKHAND_ACCURACY = 0.9;
		POLE_BACKHAND_REPEL = 400;
		POLE_BACKHAND_STUN = 1;
		POLE_BACKHAND_STUN_CHANCE = 0.9;
		POLE_CAN_POWER_THROW = 1;
		POLE_THROW_MP = 0;
		POLE_THROW_POWER = 1000;
		POLE_THOW_PROJECTILE = "proj_pole_dra";
		POLE_POKE1_ENHANCED = 1;
	}

	void polearm_spawn()
	{
		SetName("Dragon Lance");
		SetDescription("A footman's lance imbued with elemental fire");
		SetWeight(60);
		SetSize(2);
		SetValue(3000);
		SetHUDSprite("trade", 189);
		if (!(true)) return;
		FREEZE_COUNT = 0;
	}

	void pole_poke1_enhance()
	{
		if (!(true)) return;
		string TARG_HIT = param1;
		if ((IsValidPlayer(TARG_HIT)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string L_DOT = GetSkillLevel(GetOwner(), "spellcasting.fire");
		L_DOT *= 0.5;
		ApplyEffect(TARG_HIT, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), L_DOT, "polearms");
	}

	void polearm_register_attacks()
	{
		int reg.attack.mpdrain = 0;
		string reg.attack.type = "strike-land";
		int reg.attack.range = 10;
		int reg.attack.dmg = 1;
		int reg.attack.dmg.range = 0;
		string reg.attack.dmg.type = "fire";
		int reg.attack.energydrain = 5;
		string reg.attack.stat = "spellcasting.fire";
		int reg.attack.hitchance = 100;
		int reg.attack.priority = 3;
		float reg.attack.delay.strike = 0.1;
		float reg.attack.delay.end = 0.2;
		int reg.attack.ofs.startpos = 0;
		int reg.attack.ofs.aimang = 0;
		int reg.attack.noise = 5000;
		string reg.attack.keys = "-attack1";
		string reg.attack.callback = "attack_fire_burst";
		float reg.attack.chargeamt = 3.0;
		int reg.attack.reqskill = 15;
		RegisterAttack();
	}

	void attack_fire_burst_start()
	{
		PlayViewAnim(VANIM_WIDE);
		PlayOwnerAnim("once", PANIM_SWIPE2);
		LogDebug("attack_ice_burst_start");
	}

	void attack_fire_burst_strike()
	{
		LogDebug("attack_ice_burst_strike");
		if (!(true)) return;
		if (GetEntityMP(GetOwner()) < FIRE_BURST_MP)
		{
			SendColoredMessage(GetOwner(), "Dragon Lance: Insufficient mana for fire burst");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		GiveMP(GetOwner());
		string BURST_POS = GetEntityOrigin(GetOwner());
		BURST_POS = "z";
		ICE_WAVE_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		ClientEvent("new", "all", "effects/sfx_fire_wave2", BURST_POS, ICE_WAVE_YAW, 45);
		string SCAN_POS = GetEntityOrigin(GetOwner());
		SCAN_POS += /* TODO: $relpos */ $relpos(Vector3(0, ICE_WAVE_YAW, 0), Vector3(0, 128, 32));
		CallExternal(GetOwner(), "ext_sphere_token", "enemy", 512, SCAN_POS);
		FREEZE_TARGS = GetEntityProperty(GetOwner(), "scriptvar");
		if (!(FREEZE_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(FREEZE_TARGS, ";"); i++)
		{
			ice_burst_affect_targs();
		}
	}

	void ice_burst_affect_targs()
	{
		string CUR_TARG = GetToken(FREEZE_TARGS, i, ";");
		if ((IsValidPlayer(CUR_TARG)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string OWNER_ORG = GetEntityOrigin(GetOwner());
		Vector3 OWNER_ANG = Vector3(0, ICE_WAVE_YAW, 0);
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		if (!(WithinCone2D(TARG_ORG, OWNER_ORG, OWNER_ANG))) return;
		string TRACE_START = OWNER_ORG;
		string TRACE_END = TARG_ORG;
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		if (!(TRACE_LINE == TRACE_END)) return;
		string L_DOT = GetSkillLevel(GetOwner(), "spellcasting.fire");
		L_DOT *= 0.5;
		ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), L_DOT, "polearms");
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		if (!(POLE_IN_BLOCK)) return;
		if (!(GetEntityProperty(GetOwner(), "scriptvar") == GetEntityIndex(GetOwner()))) return;
		if (!((param4).findFirst("fire") >= 0)) return;
		string IN_DMG = param3;
		IN_DMG *= 0.1;
		SetDamage("dmg");
		return;
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if ((IsValidPlayer(param2)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(RandomInt(1, 5) == 1)) return;
		string L_DOT = GetSkillLevel(GetOwner(), "spellcasting.fire");
		if (!(L_DOT > 15)) return;
		L_DOT *= 0.5;
		ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), L_DOT, "polearms");
	}

}

}
