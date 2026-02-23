#pragma context server

#include "items/shields_base.as"

namespace MS
{

class ShieldsF : CGameScript
{
	int BREATH_ON;
	string BURN_DAMAGE;
	string BURN_LIST;
	string CL_SCRIPT_DX;
	int EXIT_BLOCK;
	string GAME_PVP;
	string NEXT_MP_WARN;
	string NEXT_SCAN;
	string OWNER_ANG;
	string OWNER_ORG;
	int SCAN_KEYS;
	string TRACE_START;

	ShieldsF()
	{
		const float NOPUSH_CHANCE = 1.0;
		const int MP_DRAIN_RATE = 2;
		const float PARRY_MULTI = 1.5;
		const int SHIELD_BASE_PARRY = 35;
		const string MODEL_VIEW = "viewmodels/v_shields.mdl";
		const int MODEL_VIEW_IDX = 4;
		const string MODEL_WORLD = "weapons/p_weapons4.mdl";
		const string MODEL_HANDS = "weapons/p_weapons4.mdl";
		const string MODEL_WEAR = "weapons/p_weapons4.mdl";
		const int MODEL_BODY_OFS = 46;
		const int MELEE_ENERGY = 15;
		const float MELEE_ACCURACY = 0.9;
		const int BLOCK_CHANCE_UP = 100;
		const float DMG_BLOCK_UP = 0.5;
		const int BLOCK_CHANCE_DOWN = 10;
		const int SHIELD_IMMORTAL = 1;
		const string SOUND_BLOCK = "debris/metal3.wav";
		const string ANIM_PREFIX = "standard";
		const int SHIELD_PRE_BLOCK_EFFECT = 1;
		const string SOUND_BREATH_LOOP = "monsters/goblin/sps_fogfire.wav";
	}

	void shield_spawn()
	{
		SetName("Demon Shield");
		SetDescription("For when it s time to get out of the kitchen");
		SetWeight(120);
		SetSize(45);
		SetValue(5000);
		SetQuality(2000);
		SetHUDSprite("trade", 191);
	}

	void OnDeploy() override
	{
		GAME_PVP = "game.pvp";
	}

	void game_wear()
	{
		SendPlayerMessage("You", "sling a Demon Shield over your shoulder.");
	}

	void bweapon_effect_activate()
	{
		if ((SCAN_KEYS)) return;
		SCAN_KEYS = 1;
		scan_keys();
	}

	void bweapon_effect_remove()
	{
		SCAN_KEYS = 0;
		if (!(BREATH_ON)) return;
		end_breath();
	}

	void scan_keys()
	{
		if (!(SCAN_KEYS)) return;
		if (!("game.item.wielded")) return;
		ScheduleDelayedEvent(0.25, "scan_keys");
		int DO_BREATH = 0;
		if (("game.item.attacking"))
		{
			if ((IsKeyDown(GetOwner(), "use")))
			{
				int DO_BREATH = 1;
			}
			string L_ACTIVE = GetActiveItem(GetOwner());
			string L_ACTIVE = GetEntityProperty(L_ACTIVE, "itemname");
			if (L_ACTIVE == GetEntityProperty(GetOwner(), "itemname"))
			{
				if ((IsKeyDown(GetOwner(), "attack2")))
				{
				}
				int DO_BREATH = 1;
			}
			else
			{
				if ((IsKeyDown(GetOwner(), "attack1")))
				{
				}
				int DO_BREATH = 1;
			}
			LogDebug("scan_keys atk1 IsKeyDown(GetOwner(), "attack1") atk2 IsKeyDown(GetOwner(), "attack2") - L_ACTIVE vs GetEntityProperty(GetOwner(), "itemname")");
		}
		if (GetEntityMP(GetOwner()) < MP_DRAIN_RATE)
		{
			int DO_BREATH = 0;
			if (GetGameTime() > NEXT_MP_WARN)
			{
			}
			NEXT_MP_WARN = GetGameTime();
			NEXT_MP_WARN += 5.0;
			SendColoredMessage(GetOwner(), "Demonshield: Insufficient mana for fire breath");
		}
		if ((DO_BREATH))
		{
			if (!(BREATH_ON))
			{
			}
			start_breath();
		}
		else
		{
			if ((BREATH_ON))
			{
			}
			end_breath();
		}
	}

	void melee_end()
	{
		if (!(BREATH_ON)) return;
		end_breath();
	}

	void end_breath()
	{
		BREATH_ON = 0;
		ClientEvent("update", "all", CL_SCRIPT_DX, "end_fx");
		CL_SCRIPT_DX = "CL_SCRIPT_DX";
		// svplaysound: svplaysound 2 0 SOUND_BREATH_LOOP
		EmitSound(2, 0, SOUND_BREATH_LOOP);
	}

	void start_breath()
	{
		LogDebug("start_breath");
		if (!(GetSkillLevel(GetOwner(), "spellcasting.fire") >= 30)) return;
		if (CL_SCRIPT_DX == "CL_SCRIPT_DX")
		{
			ClientEvent("new", "all", "items/axes_dragon_cl", GetEntityIndex(GetOwner()));
			CL_SCRIPT_DX = "game.script.last_sent_id";
			// svplaysound: svplaysound 1 10 SOUND_BREATH_LOOP
			EmitSound(1, 10, SOUND_BREATH_LOOP);
		}
		BREATH_ON = 1;
		ScheduleDelayedEvent(0.1, "breath_loop");
	}

	void breath_loop()
	{
		if (!(BREATH_ON)) return;
		ScheduleDelayedEvent(0.1, "breath_loop");
		GiveMP(GetOwner());
		OWNER_ANG = GetEntityAngles(GetOwner());
		OWNER_ORG = GetEntityOrigin(GetOwner());
		string CLOUD_START = GetEntityProperty(GetOwner(), "svbonepos");
		CLOUD_START += /* TODO: $relpos */ $relpos(OWNER_ANG, Vector3(0, 32, -30));
		string CLOUD_ANG = OWNER_ANG;
		CLOUD_ANG = "x";
		if ("game.item.hand_index" == 0)
		{
			CLOUD_START += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(-10, 0, 0));
		}
		else
		{
			CLOUD_START += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(10, 0, 0));
		}
		ClientEvent("update", "all", CL_SCRIPT_DX, "make_clouds", CLOUD_START, CLOUD_ANG);
		if (!(GetGameTime() > NEXT_SCAN)) return;
		NEXT_SCAN = GetGameTime();
		NEXT_SCAN += 0.5;
		BURN_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.fire");
		BURN_DAMAGE /= 2;
		string SCAN_POS = CLOUD_START;
		SCAN_POS += /* TODO: $relpos */ $relpos(OWNER_ANG, Vector3(0, 128, 0));
		CallExternal(GetOwner(), "ext_box_token", "enemy", 96, SCAN_POS);
		BURN_LIST = GetEntityProperty(GetOwner(), "scriptvar");
		if (!(BURN_LIST != "none")) return;
		TRACE_START = CLOUD_START;
		for (int i = 0; i < GetTokenCount(BURN_LIST, ";"); i++)
		{
			burn_targets();
		}
	}

	void burn_targets()
	{
		string CUR_TARG = GetToken(BURN_LIST, i, ";");
		if ((IsValidPlayer(CUR_TARG)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(IsEntityAlive(CUR_TARG))) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		if (!(WithinCone2D(TARG_ORG, OWNER_ORG, OWNER_ANG))) return;
		if (!(GetEntityRange(CUR_TARG) < 256)) return;
		string TRACE_END = GetEntityOrigin(CUR_TARG);
		if (!(IsValidPlayer(CUR_TARG)))
		{
			string HALF_MON_HEIGHT = GetEntityHeight(CUR_TARG);
			HALF_MON_HEIGHT *= 0.5;
			TRACE_END += "z";
		}
		string TRACE_CHECK = TraceLine(TRACE_START, TRACE_END);
		if (!(TRACE_CHECK == TRACE_END)) return;
		ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), BURN_DAMAGE, "spellcasting.fire");
		if (!(GetEntityMaxHealth(CUR_TARG) < 10000)) return;
		if (!(GetEntityHeight(CUR_TARG) < 120)) return;
		if ((GetEntityProperty(CUR_TARG, "scriptvar"))) return;
		string PUSH_VEL = /* TODO: $relvel */ $relvel(0, 200, 110);
		AddVelocity(CUR_TARG, PUSH_VEL);
	}

	void shield_pre_block_effect()
	{
		if (!("game.item.attacking")) return;
		if (!((param4).findFirst("fire") >= 0)) return;
		SetDamage("dmg");
		EXIT_BLOCK = 1;
	}

}

}
