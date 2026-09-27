#pragma context server

#include "monsters/base_propelled.as"

namespace MS
{

class BloodDrinker : CGameScript
{
	int AM_HOVERING;
	int AM_RETURNING;
	int BEAM_BRIGHTNESS;
	string BEAM_ID;
	string BLADE_DURATION;
	string CUR_DEST;
	string CUR_TARGET;
	string DMG_BASE;
	string FIRST_TARGET;
	float FREQ_GLOW;
	float FREQ_NEW_TARGET;
	float FREQ_SOUND;
	int FWD_SPEED;
	string GAME_PVP;
	int GLOW_DELAY;
	int IS_ACTIVE;
	int MOVE_RANGE;
	string MY_OWNER;
	string MY_SKILL;
	int NEW_TARG_DELAY;
	string NEXT_TOUCH;
	int NPC_HACKED_MOVE_SPEED;
	string OWNER_HEIGHT;
	string OWNER_ISPLAYER;
	int PLAYING_DEAD;
	string RETURN_ID;
	string SOUND_SPIN;
	string TARG_HEIGHT;

	BloodDrinker()
	{
		NPC_HACKED_MOVE_SPEED = 1;
		FWD_SPEED = 20;
		MOVE_RANGE = 40;
		FREQ_NEW_TARGET = 5.0;
		FREQ_SOUND = 0.5;
		FREQ_GLOW = 1.0;
		SOUND_SPIN = "zombie/claw_miss2.wav";
		BEAM_BRIGHTNESS = 50;
		SetCallback("touch", "enable");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(2.0);
		if ((IS_ACTIVE))
		{
		}
		CUR_DEST = GetEntityOrigin(CUR_TARGET);
		CUR_DEST += "z";
		SetMoveDest(CUR_DEST);
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(0.1);
		if ((IS_ACTIVE))
		{
		}
		string MY_ORG = GetMonsterProperty("origin");
		MY_ORG += /* TODO: $relvel */ $relvel(0, FWD_SPEED, 0);
		if ((IsEntityAlive(CUR_TARGET)))
		{
			SetEntityOrigin(GetOwner(), MY_ORG);
		}
		else
		{
			string MY_ORG = GetEntityOrigin(GetOwner());
			string DEST_DIR = (CUR_DEST - MY_ORG).Normalize();
			DEST_DIR *= 100;
			SetVelocity(GetOwner(), DEST_DIR);
		}
		string MASTER_ORG = GetEntityOrigin(MY_OWNER);
		if ((AM_RETURNING))
		{
			SetMoveDest(MY_OWNER);
			if (Distance(GetMonsterProperty("origin"), MASTER_ORG) < OWNER_HEIGHT)
			{
			}
			notify_return();
		}
		if (!(AM_RETURNING))
		{
		}
		if (Distance(GetMonsterProperty("origin"), CUR_DEST) < 64)
		{
			if (Distance(GetMonsterProperty("origin"), MASTER_ORG) > 1024)
			{
				return_to_owner("too_far");
			}
			if (!(AM_RETURNING))
			{
			}
			MY_ORG += /* TODO: $relvel */ $relvel(0, 512, 0);
			SetMoveDest(MY_ORG);
		}
		if (!(IsEntityAlive(CUR_TARGET)))
		{
			find_new_target();
		}
		string CUR_TARG_ORIGIN = GetEntityOrigin(CUR_TARGET);
		if (!(Distance(CUR_TARG_ORIGIN, MASTER_ORG) > 1024))
		{
			find_new_target();
		}
	}

	void OnRepeatTimer_2()
	{
		SetRepeatDelay(FREQ_SOUND);
		if ((IS_ACTIVE))
		{
		}
		EmitSound(GetOwner(), 0, "zombie/claw_miss2.wav", 10);
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		FIRST_TARGET = param2;
		DMG_BASE = param3;
		BLADE_DURATION = param4;
		GAME_PVP = "game.pvp";
		LogDebug("bladedur BLADE_DURATION PARAM4");
		OWNER_HEIGHT = GetEntityHeight(MY_OWNER);
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		MY_SKILL = "none";
		if ((OWNER_ISPLAYER))
		{
			RETURN_ID = param5;
			MY_SKILL = "swordsmanship";
		}
		SetRace(GetEntityRace(MY_OWNER));
		CUR_TARGET = FIRST_TARGET;
		set_target(FIRST_TARGET);
		SetMoveDest(CUR_TARGET);
		BLADE_DURATION("return_to_owner");
		IS_ACTIVE = 1;
		ScheduleDelayedEvent(0.1, "damage_loop");
	}

	void OnSpawn() override
	{
		SetName("Blood Drinker");
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 30);
		SetIdleAnim("spin_horizontal_norm");
		SetMoveAnim("spin_horizontal_norm");
		SetSolid("trigger");
		SetWidth(64);
		SetHeight(64);
		SetFly(true);
		SetBloodType("none");
		SetInvincible(true);
		SetMonsterClip(0);
		PLAYING_DEAD = 1;
		Effect("glow", GetOwner(), Vector3(255, 0, 0), 32, -1, 0);
		ScheduleDelayedEvent(0.1, "init_beam");
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("lightning", 0.0);
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if (!(GetGameTime() > NEXT_TOUCH)) return;
		NEXT_TOUCH = GetGameTime();
		NEXT_TOUCH += 0.1;
		if (!(GetRelationship(param1) == "enemy")) return;
		XDoDamage(param1, "direct", DMG_BASE, 1.0, MY_OWNER, GetOwner(), MY_SKILL, "dark");
		if (!(GetEntityProperty(param1, "scriptvar")))
		{
			if (GetEntityRace(param1) != "undead")
			{
			}
			if ((OWNER_ISPLAYER))
			{
				if (!(GAME_PVP))
				{
					if ((IsValidPlayer(param1)))
					{
					}
					SetDamage("hit");
					SetDamage("dmg");
					return;
					int EXIT_SUB = 1;
				}
				if (!(EXIT_SUB))
				{
				}
				LogDebug("PARAM1 healowner");
				HealEntity(MY_OWNER, 4.0);
			}
			else
			{
				string DMG_DONE = param2;
				HealEntity(MY_OWNER, DMG_DONE);
				if (!(GLOW_DELAY))
				{
				}
				GLOW_DELAY = 1;
				FREQ_GLOW("reset_glow_delay");
				Effect("glow", MY_OWNER, Vector3(0, 255, 0), 128, 0.25, 0.25);
			}
		}
		if ((NEW_TARG_DELAY)) return;
		if ((AM_RETURNING)) return;
		if (!(param1 == CUR_TARGET)) return;
		NEW_TARG_DELAY = 1;
		FREQ_NEW_TARGET("reset_new_targ_delay");
		find_new_target();
	}

	void reset_new_targ_delay()
	{
		NEW_TARG_DELAY = 0;
	}

	void game_reached_dest()
	{
		if ((AM_RETURNING)) return;
	}

	void find_new_target()
	{
		if ((AM_RETURNING)) return;
		if ((IsEntityAlive(CUR_TARGET)))
		{
			if (GetEntityRange(CUR_TARGET) < 1024)
			{
				set_target(CUR_TARGET);
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		string OLD_TARGET = CUR_TARGET;
		string MASTER_ORG = GetEntityOrigin(MY_OWNER);
		string TARGET_LIST = FindEntitiesInSphere("enemy", 1024);
		if (GetTokenCount(TARGET_LIST, ";") > 0)
		{
			ScrambleTokens(TARGET_LIST, ";");
			set_target(GetToken(TARGET_LIST, 0, ";"));
		}
	}

	void set_target()
	{
		CUR_TARGET = param1;
		if ((IsEntityAlive(CUR_TARGET)))
		{
			if (!(AM_RETURNING))
			{
			}
			if (CUR_TARGET != MY_OWNER)
			{
				string TRACE_START = GetEntityOrigin(GetOwner());
				string TRACE_END = GetEntityOrigin(CUR_TARGET);
				string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
				if (TRACE_LINE == TRACE_END)
				{
					Effect("beam", "update", BEAM_ID, "end_target", CUR_TARGET);
					Effect("beam", "update", BEAM_ID, "brightness", BEAM_BRIGHTNESS);
				}
				else
				{
					Effect("beam", "update", BEAM_ID, "brightness", BEAM_ID, 0);
					CUR_TARGET = "unset";
				}
			}
		}
		else
		{
			Effect("beam", "update", BEAM_ID, "brightness", BEAM_ID, 0);
		}
		TARG_HEIGHT = GetEntityHeight(CUR_TARGET);
		if ((IsValidPlayer(CUR_TARGET)))
		{
			TARG_HEIGHT /= 2;
		}
		CUR_DEST = GetEntityOrigin(CUR_TARGET);
		CUR_DEST += "z";
		if (!(AM_RETURNING))
		{
			if (!(IsEntityAlive(CUR_TARGET)))
			{
			}
			string OWNER_YAW = GetEntityProperty(MY_OWNER, "angles.yaw");
			CUR_DEST = GetEntityOrigin(MY_OWNER);
			CUR_DEST += /* TODO: $relpos */ $relpos(Vector3(0, OWNER_YAW, 0), Vector3(0, 128, 64));
		}
		SetMoveDest(CUR_DEST);
		AM_HOVERING = 0;
	}

	void return_to_owner()
	{
		LogDebug("return_to_owner PARAM1");
		Effect("beam", "update", BEAM_ID, "remove", 0);
		AM_RETURNING = 1;
		AM_HOVERING = 0;
		FWD_SPEED *= 2.0;
		CUR_TARGET = MY_OWNER;
		set_target(MY_OWNER);
		SetMoveDest(MY_OWNER);
	}

	void notify_return()
	{
		if (!(OWNER_ISPLAYER))
		{
			CallExternal(MY_OWNER, "sword_return");
		}
		else
		{
			CallExternal(RETURN_ID, "sword_return");
		}
		SetProp(GetOwner(), "rendermode", 2);
		SetProp(GetOwner(), "renderamt", 0);
		Effect("glow", GetOwner(), Vector3(0, 0, 0), 0, -1, 0);
		IS_ACTIVE = 0;
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

	void reset_glow_delay()
	{
		GLOW_DELAY = 0;
	}

	void init_beam()
	{
		Effect("beam", "ents", "laserbeam.spr", 300, GetOwner(), 0, CUR_TARGET, 0, Vector3(255, 0, 0), BEAM_BRIGHTNESS, 1, -1);
		BEAM_ID = m_hLastCreated;
	}

	void ext_remove()
	{
		Effect("beam", "update", BEAM_ID, "remove", 0);
		ScheduleDelayedEvent(0.1, "remove_me");
	}

}

}
