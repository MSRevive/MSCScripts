#pragma context server

#include "items/polearms_base.as"

namespace MS
{

class PolearmsTi : CGameScript
{
	int FREEZE_COUNT;
	string FREEZE_TARGS;
	string ICE_WAVE_YAW;
	string OLD_REPEAT_TARGET;
	string REPEAT_TARGET;

	PolearmsTi()
	{
		const int BASE_LEVEL_REQ = 25;
		const int ICE_BURST_MP = 75;
		const int VMODEL_IDX = 5;
		const string PMODEL_FILE = "weapons/p_weapons4.mdl";
		const int PMODEL_IDX_FLOOR = 13;
		const int PMODEL_IDX_HANDS = 12;
		const int MELEE_DMG = 250;
		const int MELEE_RANGE = 100;
		const string MELEE_DMG_TYPE = "cold";
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
		const int POLE_BACKHAND_DMG = 300;
		const int POLE_BACKHAND_DMG_RANGE = 10;
		const string POLE_BACKHAND_DMG_TYPE = "pierce";
		const int POLE_BACKHAND_RANGE = 40;
		const float POLE_BACKHAND_ACCURACY = 0.9;
		const int POLE_BACKHAND_REPEL = 400;
		const int POLE_CAN_POWER_THROW = 1;
		const int POLE_THROW_MP = 0;
		const int POLE_THROW_POWER = 1000;
		const string POLE_THOW_PROJECTILE = "proj_pole_ti";
		const int POLE_POKE1_ENHANCED = 1;
		const string SOUND_HITWALL1 = "debris/glass1.wav";
		const string SOUND_HITWALL2 = "debris/glass2.wav";
	}

	void polearm_spawn()
	{
		SetName("Ice Typhoon");
		SetDescription("A polearm tipped with elemental ice");
		SetWeight(60);
		SetSize(2);
		SetValue(3000);
		SetHUDSprite("trade", 184);
		if (!(true)) return;
		FREEZE_COUNT = 0;
	}

	void pole_poke1_enhance()
	{
		if (!(true)) return;
		if (!(RandomInt(1, 3) == 1)) return;
		string TARG_HIT = param1;
		if ((IsValidPlayer(TARG_HIT)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string L_DOT = GetSkillLevel(GetOwner(), "spellcasting.ice");
		L_DOT *= 0.5;
		ApplyEffect(TARG_HIT, "effects/dot_cold", 5.0, GetEntityIndex(GetOwner()), L_DOT);
	}

	void polearm_register_attacks()
	{
		int reg.attack.mpdrain = 0;
		string reg.attack.type = "strike-land";
		int reg.attack.range = 10;
		int reg.attack.dmg = 1;
		int reg.attack.dmg.range = 0;
		string reg.attack.dmg.type = "cold";
		int reg.attack.energydrain = 5;
		string reg.attack.stat = "spellcasting.ice";
		int reg.attack.hitchance = 100;
		int reg.attack.priority = 3;
		float reg.attack.delay.strike = 0.1;
		float reg.attack.delay.end = 0.2;
		int reg.attack.ofs.startpos = 0;
		int reg.attack.ofs.aimang = 0;
		int reg.attack.noise = 5000;
		string reg.attack.keys = "-attack1";
		string reg.attack.callback = "attack_ice_burst";
		float reg.attack.chargeamt = 3.0;
		int reg.attack.reqskill = 25;
		RegisterAttack();
	}

	void attack_ice_burst_start()
	{
		PlayViewAnim(VANIM_WIDE);
		PlayOwnerAnim("once", PANIM_SWIPE2);
		LogDebug("attack_ice_burst_start");
	}

	void attack_ice_burst_strike()
	{
		LogDebug("attack_ice_burst_strike");
		if (!(true)) return;
		if (GetEntityMP(GetOwner()) < ICE_BURST_MP)
		{
			SendColoredMessage(GetOwner(), "Ice Typhoon: Insufficient mana for freezing burst");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		GiveMP(GetOwner());
		string BURST_POS = GetEntityOrigin(GetOwner());
		BURST_POS = "z";
		ICE_WAVE_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		ClientEvent("new", "all", "effects/sfx_ice_wave2", BURST_POS, ICE_WAVE_YAW, 45);
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
		string MAX_FREEZE_HP = GetEntityMaxHealth(GetOwner());
		MAX_FREEZE_HP *= 4.0;
		if (GetEntityHealth(CUR_TARG) < MAX_FREEZE_HP)
		{
			int DO_FREEZE = 1;
		}
		if (GetEntityHealth(CUR_TARG) < 1500)
		{
			int DO_FREEZE = 1;
		}
		if (!(DO_FREEZE))
		{
			string L_DOT = GetSkillLevel(GetOwner(), "spellcasting.ice");
			ApplyEffect(CUR_TARG, "effects/dot_cold", 5.0, GetEntityIndex(GetOwner()), L_DOT);
		}
		else
		{
			ApplyEffect(CUR_TARG, "effects/dot_cold_freeze", Random(5.0, 8.0), GetEntityIndex(GetOwner()), 0, "spellcasting.ice", 1500);
		}
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		if (!(GetEntityProperty(GetOwner(), "scriptvar") == GetEntityIndex(GetOwner()))) return;
		if (!((param4).findFirst("ice") >= 0)) return;
		string IN_DMG = param3;
		IN_DMG *= 0.5;
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
		REPEAT_TARGET = param2;
		if (OLD_REPEAT_TARGET == REPEAT_TARGET)
		{
			FREEZE_COUNT += 1;
		}
		else
		{
			FREEZE_COUNT = 0;
		}
		OLD_REPEAT_TARGET = param2;
		string DOT_BURN = GetSkillLevel(GetOwner(), "spellcasting.ice");
		DOT_BURN *= 0.25;
		if (FREEZE_COUNT < 4)
		{
			ApplyEffect(param2, "effects/dot_cold", 5.0, GetEntityIndex(GetOwner()), DOT_BURN);
			if ((GetEntityProperty(param2, "scriptvar")))
			{
				FREEZE_COUNT = 0;
			}
		}
		else
		{
			FREEZE_COUNT = 0;
			if ((GetEntityProperty(param2, "scriptvar")))
			{
				ApplyEffect(param2, "effects/dot_cold", 5.0, GetEntityIndex(GetOwner()), DOT_BURN);
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			DOT_BURN *= 0.25;
			if (GetEntityHealth(param2) < 2000)
			{
			}
			ApplyEffect(param2, "effects/dot_cold_freeze", 5.0, GetEntityIndex(GetOwner()), DOT_BURN, "spellcasting.ice", 2000);
		}
	}

}

}
