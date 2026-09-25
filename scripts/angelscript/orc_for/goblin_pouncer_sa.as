#pragma context server

#include "orc_for/goblin_base.as"

namespace MS
{

class GoblinPouncerSa : CGameScript
{
	int AM_LATCHED;
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_LEAP;
	string ANIM_LEAP_READY;
	string ANIM_LEAP_RIDE;
	string ANIM_RUN;
	string ANIM_WALK;
	int AS_CUSTOM_UNSTUCK;
	float ATTACK_HITCHANCE;
	string DID_WARNING;
	int DMG_POUND;
	int DMG_SWORD;
	float FREQ_LAUGH;
	float FREQ_LEAP;
	int GOBLIN_SELF_ADJUST;
	int IN_LEAP;
	string LATCH_END;
	string LATCH_TARGET;
	int LEAP_MODE;
	int LEAP_RANGE;
	string LEAP_TARGET;
	string NEXT_LATCH_ATTEMPT;
	string NEXT_LAUGH;
	string NPC_ADJ_DMG_MUTLI_TOKENS;
	string NPC_ADJ_HP_MUTLI_TOKENS;
	string NPC_ADJ_TIERS;
	int NPC_BASE_EXP;
	int NPC_FORCED_MOVEDEST;
	string NPC_SELF_ADJUST;
	int PICKED_RANDOM;
	string SOUND_LAUGH;
	string SOUND_LEAP_GO;
	string SOUND_LEAP_READY;
	int WAS_LATCHED;

	GoblinPouncerSa()
	{
		ANIM_LEAP_READY = "pounce_ready";
		ANIM_LEAP = "pounce_fly";
		ANIM_LEAP_RIDE = "pounce_latch";
		ANIM_ATTACK = "swordswing1_L";
		AS_CUSTOM_UNSTUCK = 1;
		GOBLIN_SELF_ADJUST = 1;
		NPC_SELF_ADJUST = GOBLIN_SELF_ADJUST;
		NPC_ADJ_TIERS = "0;750;1500;2000;3000;5000";
		NPC_ADJ_DMG_MUTLI_TOKENS = "1.0;1.5;2.0;5.0;7.5;10.0;";
		NPC_ADJ_HP_MUTLI_TOKENS = "1.0;2.0;3.0;5.0;7.5;10.0;";
		NPC_BASE_EXP = 200;
		ATTACK_HITCHANCE = 0.9;
		LEAP_RANGE = 500;
		FREQ_LEAP = 15.0;
		DMG_SWORD = 15;
		DMG_POUND = 5;
		FREQ_LAUGH = Random(5.0, 10.0);
		SOUND_LEAP_READY = "monsters/goblin/c_gargoyle_bat1.wav";
		SOUND_LEAP_GO = "monsters/goblin/c_gargoyle_atk3.wav";
		SOUND_LAUGH = "monsters/goblin/c_gargoyle_bat2.wav";
	}

	void goblin_spawn()
	{
		SetName("Goblin Pouncer");
		SetModel("monsters/goblin_new.mdl");
		SetHealth(50);
		SetWidth(24);
		SetHeight(50);
		SetRace("goblin");
		SetBloodType("red");
		SetRoam(true);
		SetHearingSensitivity(2);
		SetModelBody(0, 0);
		SetModelBody(1, 0);
		SetModelBody(2, 0);
		SetModelBody(3, 0);
		SetProp(GetOwner(), "skin", 3);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
	}

	void npc_targetsighted()
	{
		if ((LEAP_MODE)) return;
		if (!(GetGameTime() > NEXT_LATCH_ATTEMPT)) return;
		if (!(GetEntityRange(m_hAttackTarget) < LEAP_RANGE)) return;
		if ((GetEntityProperty(m_hAttackTarget, "haseffect"))) return;
		LEAP_MODE = 1;
		NEXT_LATCH_ATTEMPT = GetGameTime();
		NEXT_LATCH_ATTEMPT += FREQ_LEAP;
		leap_ready();
	}

	void leap_ready()
	{
		EmitSound(GetOwner(), 0, SOUND_LEAP_READY, 10);
		LEAP_TARGET = m_hAttackTarget;
		if (!(DID_WARNING))
		{
			DID_WARNING = 1;
			SendInfoMsg(LEAP_TARGET, "Beware the Goblin Pouncer If he pounces you, you'll have to be rescued by another player!");
		}
		ready_leap_mode();
		leap_target_loop();
		ScheduleDelayedEvent(3.0, "do_leap");
	}

	void leap_target_loop()
	{
		LogDebug("leap_target_loop");
		if (!(LEAP_MODE)) return;
		if ((IN_LEAP)) return;
		SetMoveDest(LEAP_TARGET);
		ScheduleDelayedEvent(0.1, "leap_target_loop");
	}

	void do_leap()
	{
		LogDebug("do_leap");
		if ((false))
		{
			if ((GetEntityProperty(LEAP_TARGET, "scriptvar")))
			{
				exit_leap_mode();
				NEXT_LATCH_ATTEMPT = GetGameTime();
				NEXT_LATCH_ATTEMPT += 2.0;
				LEAP_MODE = 0;
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if (GetEntityRange(LEAP_TARGET) < LEAP_RANGE)
			{
				EmitSound(GetOwner(), 0, SOUND_LEAP_GO, 10);
				PlayAnim("hold", ANIM_LEAP);
				if (!(I_R_FROZEN))
				{
					AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 1000, 200));
				}
				IN_LEAP = 1;
				ScheduleDelayedEvent(1.0, "end_leap_scan");
				leap_scan();
			}
			else
			{
				exit_leap_mode();
				NEXT_LATCH_ATTEMPT = GetGameTime();
				NEXT_LATCH_ATTEMPT += 2.0;
				LEAP_MODE = 0;
			}
		}
		else
		{
			exit_leap_mode();
			NEXT_LATCH_ATTEMPT = GetGameTime();
			NEXT_LATCH_ATTEMPT += 5.0;
			LEAP_MODE = 0;
		}
	}

	void leap_scan()
	{
		if (!(IN_LEAP)) return;
		LogDebug("leap_scan");
		if (GetEntityRange(LEAP_TARGET) < 64)
		{
			if (!(I_R_FROZEN))
			{
			}
			latch_target(LEAP_TARGET);
		}
		else
		{
			string SCAN_TOKENS = FindEntitiesInSphere("enemy", 64);
			if (SCAN_TOKENS != "none")
			{
			}
			string SCAN_NME = GetToken(SCAN_TOKENS, 0, ";");
			if ((IsEntityAlive(SCAN_NME)))
			{
			}
			LEAP_TARGET = SCAN_NME;
			latch_target(LEAP_TARGET);
		}
		if ((AM_LATCHED)) return;
		if (!(IN_LEAP)) return;
		ScheduleDelayedEvent(0.1, "leap_scan");
	}

	void end_leap_scan()
	{
		LogDebug("end_leap_scan");
		IN_LEAP = 0;
		if ((AM_LATCHED)) return;
		LEAP_MODE = 0;
		exit_leap_mode();
		NEXT_LATCH_ATTEMPT = GetGameTime();
		NEXT_LATCH_ATTEMPT += FREQ_LEAP;
	}

	void latch_target()
	{
		if ((GetEntityProperty(param1, "haseffect"))) return;
		LogDebug("latch_target");
		AM_LATCHED = 1;
		LATCH_TARGET = param1;
		PlayAnim("once", "break");
		ride_mode();
		string LATCH_POS = GetEntityOrigin(LATCH_TARGET);
		string TARG_YAW = GetEntityProperty(LATCH_TARGET, "angles.yaw");
		LATCH_POS += /* TODO: $relpos */ $relpos(Vector3(0, TARG_YAW, 0), Vector3(0, -16, 32));
		SetEntityOrigin(GetOwner(), LATCH_POS);
		SetAngles("face");
		SetFollow(LATCH_TARGET);
		LATCH_END = GetGameTime();
		LATCH_END += 20.0;
		latch_think();
		ApplyEffect(LATCH_TARGET, "effects/goblin_latch", 20, GetEntityIndex(GetOwner()));
		if (!(IsValidPlayer(LATCH_TARGET))) return;
		string OUT_TITLE = GetEntityName(LATCH_TARGET);
		string OUT_MSG = "Has been pounced!";
		SendInfoMsg("all", OUT_TITLE + OUT_MSG);
	}

	void player_left()
	{
		if (!(AM_LATCHED)) return;
		if (!(param1 == LATCH_TARGET)) return;
		end_latch();
	}

	void latch_think()
	{
		LogDebug("latch_think");
		if (!(AM_LATCHED)) return;
		ScheduleDelayedEvent(0.25, "latch_think");
		if (!(IsEntityAlive(LATCH_TARGET)))
		{
			end_latch();
		}
		if (!(AM_LATCHED)) return;
		if (GetGameTime() > LATCH_END)
		{
			end_latch();
		}
	}

	void end_latch()
	{
		LogDebug("end_latch");
		WAS_LATCHED = 1;
		PICKED_RANDOM = 0;
		AM_LATCHED = 0;
		LEAP_MODE = 0;
		IN_LEAP = 0;
		SetFollow("none");
		NEXT_LATCH_ATTEMPT = GetGameTime();
		NEXT_LATCH_ATTEMPT += FREQ_LEAP;
		exit_ride_mode();
		EmitSound(GetOwner(), 0, SOUND_LAUGH, 10);
		if ((IsEntityAlive(LATCH_TARGET)))
		{
			npcatk_flee(LATCH_TARGET, 1024, 3.0);
			AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, -600, 110));
		}
	}

	void bs_global_command()
	{
		if (!(AM_LATCHED)) return;
		if (!(param1 == LATCH_TARGET)) return;
		if (!(param3 == "death")) return;
		end_latch();
	}

	void OnDamage(int damage) override
	{
		if (!(AM_LATCHED)) return;
		LogDebug("game_damaged AM_LATCHED by GetEntityName(param1) vs GetEntityName(LATCH_TARGET)");
		if (!(IsEntityAlive(LATCH_TARGET))) return;
		if (!(param1 == LATCH_TARGET)) return;
		if (!((param3).findFirst("effect") >= 0)) return;
		SetDamage("hit");
		SetDamage("dmg");
		return;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((AM_LATCHED))
		{
			SetFollow("none");
			if ((IsValidPlayer(m_hLastStruck)))
			{
			}
			if ((IsValidPlayer(LATCH_TARGET)))
			{
			}
			if (GetEntityIndex(m_hLastStruck) != LATCH_TARGET)
			{
			}
			string BONUS_MSG = "for rescuing ";
			BONUS_MSG += GetEntityName(LATCH_TARGET);
			CallExternal(m_hLastStruck, "ext_dmgpoint_bonus", 1000, BONUS_MSG);
			CallExternal(LATCH_TARGET, "ext_goblin_died");
		}
	}

	void ride_mode()
	{
		ANIM_RUN = ANIM_LEAP_RIDE;
		ANIM_WALK = ANIM_LEAP_RIDE;
		ANIM_IDLE = ANIM_LEAP_RIDE;
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
		PlayAnim("critical", ANIM_LEAP_RIDE);
		npcatk_suspend_ai();
	}

	void ready_leap_mode()
	{
		ANIM_RUN = ANIM_LEAP_READY;
		ANIM_WALK = ANIM_LEAP_READY;
		ANIM_IDLE = ANIM_LEAP_READY;
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
		PlayAnim("hold", ANIM_LEAP_READY);
		npcatk_suspend_ai();
	}

	void exit_leap_mode()
	{
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle1";
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
		PlayAnim("once", "break");
		PlayAnim("critical", ANIM_RUN);
		npcatk_resume_ai();
	}

	void exit_ride_mode()
	{
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle1";
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
		PlayAnim("once", "break");
		PlayAnim("critical", ANIM_RUN);
		npcatk_resume_ai();
	}

	void frame_pounce_pound()
	{
		if (!(AM_LATCHED)) return;
		if (!(IsEntityAlive(LATCH_TARGET))) return;
		DoDamage(LATCH_TARGET, "direct", DMG_POUND, 1.0, GetOwner());
		if (GetGameTime() > NEXT_LAUGH)
		{
			NEXT_LAUGH = GetGameTime();
			NEXT_LAUGH += FREQ_LAUGH;
			int DO_LAUGH = 1;
		}
		if (!(DO_LAUGH))
		{
			CallExternal(LATCH_TARGET, "ext_playrandomsound", 2, 5, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3);
		}
		else
		{
			CallExternal(LATCH_TARGET, "ext_playsound_kiss", 1, 10, SOUND_LAUGH);
		}
	}

	void npc_stuck()
	{
		if (!(SUSPEND_AI))
		{
			as_npcatk_suspend_ai(AS_WIGGLE_DURATION);
		}
		NPC_FORCED_MOVEDEST = 1;
		string MOVE_DEST = MY_ORG;
		AS_UNSTUCK_ANG += 36;
		if (AS_UNSTUCK_ANG > 359)
		{
			AS_UNSTUCK_ANG -= 359;
		}
		MOVE_DEST += /* TODO: $relpos */ $relpos(Vector3(0, AS_UNSTUCK_ANG, 0), Vector3(0, 1000, 0));
		SetMoveDest(MOVE_DEST);
		PlayAnim("once", ANIM_RUN);
		LogDebug("npc_stuck STUCK_COUNT");
		if (!(WAS_LATCHED)) return;
		if (!(STUCK_COUNT > 3)) return;
		ext_wink_out(NPC_SPAWN_LOC, 1.0);
		WAS_LATCHED = 0;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(m_hAttackTarget == "unset")) return;
		if ((PICKED_RANDOM)) return;
		if (!(WAS_LATCHED)) return;
		if ((HUNTING_PLAYER)) return;
		GetAllPlayers(TARG_LIST);
		ScrambleTokens(TARG_LIST, ";");
		string RND_PLR = GetToken(TARG_LIST, 0, ";");
		if (!(IsEntityAlive(RND_PLR))) return;
		PICKED_RANDOM = 1;
		npcatk_settarget(RND_PLR, "random_select");
	}

}

}
