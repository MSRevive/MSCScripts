#pragma context server

#include "items/axes_greataxe.as"

namespace MS
{

class AxesDragon : CGameScript
{
	string ANIM_PREFIX;
	int BASE_LEVEL_REQ;
	string BURN_DAMAGE;
	int BURN_LEVEL_REQ;
	string BURN_LIST;
	string CAN_BURN;
	string CL_IDX;
	string CL_SCRIPT;
	string GAME_PVP;
	int MELEE_ACCURACY;
	int MELEE_DMG;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	int MP_DRAIN_RATE;
	string NEXT_FLAME;
	string NEXT_MSG;
	string NEXT_SCAN;
	string OWNER_ANG;
	string OWNER_ORG;
	string SOUND_FLAME_ON;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	string TRACE_START;

	AxesDragon()
	{
		BASE_LEVEL_REQ = 20;
		BURN_LEVEL_REQ = 20;
		MP_DRAIN_RATE = -2;
		MODEL_VIEW_IDX = 4;
		MODEL_HANDS = "weapons/p_weapons3.mdl";
		MODEL_WORLD = "weapons/p_weapons3.mdl";
		ANIM_PREFIX = "standard";
		MODEL_BODY_OFS = 34;
		MELEE_ENERGY = 2;
		MELEE_DMG = 400;
		MELEE_DMG_RANGE = 25;
		MELEE_DMG_TYPE = "fire";
		MELEE_ACCURACY = 50;
		SOUND_FLAME_ON = "monsters/goblin/sps_fogfire.wav";
		CL_SCRIPT = "items/axes_dragon_cl";
		SOUND_HITWALL1 = "weapons/axemetal1.wav";
		SOUND_HITWALL2 = "weapons/axemetal2.wav";
	}

	void game_precache()
	{
		Precache("items/axes_dragon_cl");
	}

	void weapon_spawn()
	{
		SetName("Dragon Axe");
		SetDescription("An axe enchanted with fire");
		SetWeight(90);
		SetSize(25);
		SetValue(2500);
		SetHUDSprite("hand", 133);
		SetHUDSprite("trade", 133);
	}

	void OnDeploy() override
	{
		GAME_PVP = "game.pvp";
		if (GetSkillLevel(GetOwner(), "spellcasting.fire") >= BURN_LEVEL_REQ)
		{
			CAN_BURN = 1;
		}
		BURN_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.fire");
		BURN_DAMAGE /= 2;
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		if ((IsValidPlayer(param2)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ApplyEffect(param2, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), BURN_DAMAGE, "spellcasting.fire");
	}

	void game_putinpack()
	{
		if (!(CL_IDX != "CL_IDX")) return;
		ClientEvent("update", "all", CL_IDX, "end_fx");
		// svplaysound: svplaysound 1 0 SOUND_FLAME_ON
		EmitSound(1, 0, SOUND_FLAME_ON);
	}

	void game_+attack2()
	{
		if (!(true)) return;
		if (!(GetGameTime() > NEXT_FLAME)) return;
		if (!(CanAttack(GetOwner())))
		{
			int EXIT_SUB = 1;
			if (GetGameTime() > NEXT_MSG)
			{
			}
			SendColoredMessage(GetOwner(), "Fire Breath: Can't attack now.");
			NEXT_MSG = GetGameTime();
			NEXT_MSG += 1.0;
		}
		if ((EXIT_SUB)) return;
		if (GetEntityMP(GetOwner()) <= /* TODO: $neg */ $neg(MP_DRAIN_RATE))
		{
			SendColoredMessage(GetOwner(), "Dragon Axe - Fire Breath: Not enough mana.");
			int EXIT_SUB = 1;
			NEXT_FLAME = GetGameTime();
			NEXT_FLAME += 1.0;
		}
		if ((EXIT_SUB)) return;
		if (!(CAN_BURN))
		{
			SendColoredMessage(GetOwner(), "Dragon Axe - Fire Breath: Insufficient fire skill.");
			int EXIT_SUB = 1;
			NEXT_FLAME = GetGameTime();
			NEXT_FLAME += 1.0;
		}
		if ((EXIT_SUB)) return;
		NEXT_FLAME = GetGameTime();
		NEXT_FLAME += 0.1;
		OWNER_ANG = GetEntityAngles(GetOwner());
		if (CL_IDX == "CL_IDX")
		{
			ClientEvent("new", "all", CL_SCRIPT, GetEntityIndex(GetOwner()));
			CL_IDX = "game.script.last_sent_id";
			// svplaysound: svplaysound 1 10 SOUND_FLAME_ON
			EmitSound(1, 10, SOUND_FLAME_ON);
		}
		else
		{
			string CLOUD_START = GetEntityProperty(GetOwner(), "svbonepos");
			CLOUD_START += /* TODO: $relpos */ $relpos(OWNER_ANG, Vector3(0, 32, -30));
			string CLOUD_ANG = OWNER_ANG;
			CLOUD_ANG = "x";
			CLOUD_START += "z";
			ClientEvent("update", "all", CL_IDX, "make_clouds", CLOUD_START, CLOUD_ANG);
		}
		OWNER_ORG = GetEntityOrigin(GetOwner());
		GiveMP(GetOwner());
		if (!(GetGameTime() > NEXT_SCAN)) return;
		NEXT_SCAN = GetGameTime();
		NEXT_SCAN += 0.5;
		BURN_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.fire");
		BURN_DAMAGE /= 2;
		string SCAN_POS = GetEntityOrigin(GetOwner());
		SCAN_POS += /* TODO: $relpos */ $relpos(OWNER_ANG, Vector3(0, 128, 0));
		CallExternal(GetOwner(), "ext_box_token", "enemy", 96, SCAN_POS);
		BURN_LIST = GetEntityProperty(GetOwner(), "scriptvar");
		if (!(BURN_LIST != "none")) return;
		TRACE_START = GetEntityProperty(GetOwner(), "svbonepos");
		for (int i = 0; i < GetTokenCount(BURN_LIST, ";"); i++)
		{
			burn_targets();
		}
	}

	void burn_targets()
	{
		string CUR_TARGET = GetToken(BURN_LIST, i, ";");
		if ((IsValidPlayer(CUR_TARGET)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(IsEntityAlive(CUR_TARGET))) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARGET);
		if (!(WithinCone2D(TARG_ORG, OWNER_ORG, OWNER_ANG))) return;
		if (!(GetEntityRange(CUR_TARGET) < 256)) return;
		string TRACE_END = GetEntityOrigin(CUR_TARGET);
		if (!(IsValidPlayer(CUR_TARGET)))
		{
			string HALF_MON_HEIGHT = GetEntityHeight(CUR_TARGET);
			HALF_MON_HEIGHT /= 2;
			TRACE_END += "z";
		}
		string TRACE_CHECK = TraceLine(TRACE_START, TRACE_END);
		if (!(TRACE_CHECK == TRACE_END)) return;
		ApplyEffect(CUR_TARGET, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), BURN_DAMAGE, "spellcasting.fire");
		if (!(GetEntityMaxHealth(CUR_TARGET) < 10000)) return;
		if (!(GetEntityHeight(CUR_TARGET) < 120)) return;
		if ((GetEntityProperty(CUR_TARG, "scriptvar"))) return;
		string PUSH_VEL = /* TODO: $relvel */ $relvel(0, 300, 120);
		AddVelocity(CUR_TARGET, PUSH_VEL);
	}

	void game__attack2()
	{
		if (!(CL_IDX != "CL_IDX")) return;
		ClientEvent("update", "all", CL_IDX, "end_fx");
		CL_IDX = "CL_IDX";
		// svplaysound: svplaysound 1 0 SOUND_FLAME_ON
		EmitSound(1, 0, SOUND_FLAME_ON);
	}

}

}
