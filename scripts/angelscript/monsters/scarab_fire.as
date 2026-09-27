#pragma context server

#include "monsters/base_stripped_ai.as"
#include "monsters/debug.as"

namespace MS
{

class ScarabFire : CGameScript
{
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_MOVE;
	int DMG_BURN_DOT;
	int DMG_CHEW;
	float EFFECT_DURATION;
	string EFFECT_SCRIPT;
	float FREQ_CHITTER;
	int FREQ_LEAP;
	int JUMP_SCAN_ACTIVE;
	int LATCHED_ON;
	float LATCH_DURATION;
	string LATCH_TARGET;
	string NEXT_LEAP;
	string NPCATK_TARGET;
	int NPC_GIVE_EXP;
	int NPC_HACKED_MOVE_SPEED;
	int NPC_PROPELLED;
	string NPC_SPAWN_TIME;
	int RANGE_LEAP_LONG;
	int RANGE_LEAP_MAX;
	int RANGE_LEAP_SHORT;
	int RUN_AWAY;
	int SKEL_RESPAWN_TIMES;
	string SOUND_CHITTER;
	string SOUND_DEATH;
	string SOUND_LATCH_HISS;
	string SOUND_LATCH_JUMP;
	string SOUND_LATCH_PLYR;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;

	ScarabFire()
	{
		ANIM_MOVE = "walk";
		ANIM_DEATH = "die";
		ANIM_IDLE = "idle";
		RANGE_LEAP_MAX = 512;
		RANGE_LEAP_LONG = 256;
		RANGE_LEAP_SHORT = 64;
		FREQ_LEAP = 15;
		NPC_GIVE_EXP = 100;
		FREQ_CHITTER = 3.6;
		DMG_BURN_DOT = 50;
		DMG_CHEW = 25;
		EFFECT_SCRIPT = "effects/dot_fire";
		EFFECT_DURATION = 5.0;
		LATCH_DURATION = 10.0;
		SOUND_CHITTER = "monsters/spider/spideridle.wav";
		SOUND_STRUCK1 = "body/flesh1.wav";
		SOUND_STRUCK2 = "body/flesh2.wav";
		SOUND_STRUCK3 = "body/flesh3.wav";
		SOUND_PAIN1 = "monsters/spider/spiderhiss.wav";
		SOUND_PAIN2 = "monsters/spider/spiderhiss.wav";
		SOUND_DEATH = "monsters/spider/spiderdie.wav";
		SOUND_LATCH_HISS = "monsters/spider/spiderhiss2.wav";
		SOUND_LATCH_JUMP = "monsters/spider/spiderjump.wav";
		SOUND_LATCH_PLYR = "monsters/spider/spiderlatch.wav";
		NPC_PROPELLED = 1;
		NPC_HACKED_MOVE_SPEED = 25;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.5);
		if ((true))
		{
		}
		if ((IsEntityAlive(GetOwner())))
		{
		}
		if (m_hAttackTarget != "unset")
		{
			if (!(IsEntityAlive(m_hAttackTarget)))
			{
			}
			NPCATK_TARGET = "unset";
		}
		if ((IsEntityAlive(GetOwner())))
		{
		}
		if (!(JUMP_SCAN_ACTIVE))
		{
		}
		if (!(I_R_FROZEN))
		{
		}
		if ((RUN_AWAY))
		{
			if ((IsEntityAlive(LATCH_TARGET)))
			{
				SetMoveDest(LATCH_TARGET);
				if (GetEntityRange(LATCH_TARGET) < 32)
				{
					AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 110, 110));
				}
			}
			else
			{
				run_away_end();
			}
		}
		if (!(RUN_AWAY))
		{
		}
		if (!(LATCHED_ON))
		{
			if (m_hAttackTarget != "unset")
			{
			}
			if ((IsEntityAlive(m_hAttackTarget)))
			{
			}
			if (GetEntityRange(m_hAttackTarget) < 1024)
			{
				SetMoveDest(m_hAttackTarget);
				LogDebug("move to GetEntityName(m_hAttackTarget)");
			}
			else
			{
				NPCATK_TARGET = "unset";
			}
			if (!(IsEntityAlive(m_hAttackTarget)))
			{
				NPCATK_TARGET = "unset";
				// svplaysound: svplaysound 2 0 SOUND_CHITTER
				EmitSound(2, 0, SOUND_CHITTER);
			}
			if ((IsEntityAlive(m_hAttackTarget)))
			{
			}
			if (GetGameTime() > NEXT_LEAP)
			{
			}
			if (GetEntityRange(m_hAttackTarget) < RANGE_LEAP_MAX)
			{
			}
			NEXT_LEAP = GetGameTime();
			NEXT_LEAP += FREQ_LEAP;
			SetMoveDest(m_hAttackTarget);
			ScheduleDelayedEvent(0.1, "leap_boost");
		}
		else
		{
			if (!(IsEntityAlive(LATCH_TARGET)))
			{
				do_dismount();
			}
			else
			{
				ApplyEffect(LATCH_TARGET, "effects/scarab_latch", 2.0, GetEntityIndex(GetOwner()), DMG_CHEW);
			}
		}
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(FREQ_CHITTER);
		if ((true))
		{
		}
		if ((IsEntityAlive(GetOwner())))
		{
		}
		if (!(LATCHED_ON))
		{
		}
		if ((IsEntityAlive(m_hAttackTarget)))
		{
		}
		// svplaysound: svplaysound 2 5 SOUND_CHITTER
		EmitSound(2, 5, SOUND_CHITTER);
	}

	void OnSpawn() override
	{
		NPCATK_TARGET = "unset";
		scarab_spawn();
	}

	void scarab_spawn()
	{
		SetName("Golden Scarab");
		SetModel("monsters/scarab.mdl");
		SetBloodType("red");
		SetHealth(150);
		SetWidth(16);
		SetHeight(16);
		SetRoam(true);
		SetRace("spider");
		SetHearingSensitivity(8);
		SetDamageResistance("holy", 0.0);
		SetDamageResistance("fire", 0.0);
		SetMoveAnim(ANIM_MOVE);
		SetIdleAnim(ANIM_IDLE);
		SetSolid("none");
		if (!(true)) return;
		NPC_SPAWN_TIME = GetGameTime();
	}

	void OnDamage(int damage) override
	{
		float SINCE_SPAWN = GetGameTime();
		SINCE_SPAWN -= NPC_SPAWN_TIME;
		if (SINCE_SPAWN < 2.0)
		{
			if (GetRelationship(param1) == "enemy")
			{
				int BLOCK_PREMATURE_DAMAGE = 1;
			}
			if ((IsValidPlayer(param1)))
			{
				int BLOCK_PREMATURE_DAMAGE = 1;
			}
			if ((BLOCK_PREMATURE_DAMAGE))
			{
			}
			SetDamage("dmg");
			SetDamage("hit");
			return;
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN1, SOUND_PAIN2
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN1, SOUND_PAIN2};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if ((LATCHED_ON)) return;
		if (!(m_hAttackTarget == "unset")) return;
		scarab_set_target(GetEntityIndex(m_hLastStruck));
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if (!(true)) return;
		if ((LATCHED_ON)) return;
		if ((RUN_AWAY)) return;
		string HEARD_ID = GetEntityIndex("ent_lastheard");
		if (!((HEARD_ID !is null))) return;
		if (!(IsEntityAlive(HEARD_ID))) return;
		if (!(GetRelationship(HEARD_ID) == "enemy")) return;
		if (m_hAttackTarget != "unset")
		{
			if (GetEntityRange(m_hAttackTarget) > GetEntityRange(HEARD_ID))
			{
				scarab_set_target(HEARD_ID);
			}
		}
		else
		{
			scarab_set_target(HEARD_ID);
		}
		if (m_hAttackTarget == HEARD_ID)
		{
			SetMoveDest(m_hAttackTarget);
		}
	}

	void scarab_set_target()
	{
		string OLD_TARG = m_hAttackTarget;
		if ((GetEntityProperty(m_hAttackTarget, "scriptvar")))
		{
			NPCATK_TARGET = "unset";
			if (OLD_TARG != "unset")
			{
			}
			if ((IsEntityAlive(OLD_TARG)))
			{
				NPCATK_TARGET = OLD_TARG;
			}
		}
		NPCATK_TARGET = param1;
	}

	void leap_boost()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		EmitSound(GetOwner(), 0, SOUND_LATCH_HISS, 10);
		if (GetEntityRange(m_hAttackTarget) >= RANGE_LEAP_LONG)
		{
			string JUMP_VEL = /* TODO: $relvel */ $relvel(0, 800, 300);
		}
		if (GetEntityRange(m_hAttackTarget) < RANGE_LEAP_LONG)
		{
			string JUMP_VEL = /* TODO: $relvel */ $relvel(0, 400, 200);
		}
		if (GetEntityRange(m_hAttackTarget) <= RANGE_LEAP_SHORT)
		{
			string JUMP_VEL = /* TODO: $relvel */ $relvel(0, 200, 50);
		}
		string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
		string TARG_Z = GetEntityProperty(m_hAttackTarget, "origin.z");
		if ((IsValidPlayer(m_hAttackTarget)))
		{
			TARG_Z -= 38;
		}
		string Z_DIFF = TARG_Z;
		Z_DIFF -= MY_Z;
		if (Z_DIFF > 64)
		{
			Z_DIFF *= 4;
			JUMP_VEL += "z";
		}
		AddVelocity(GetOwner(), JUMP_VEL);
		JUMP_SCAN_ACTIVE = 1;
		ScheduleDelayedEvent(0.1, "jump_scan");
		ScheduleDelayedEvent(1.0, "end_jump_scan");
	}

	void jump_scan()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if (!(JUMP_SCAN_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "jump_scan");
		string IN_BOX = /* TODO: $get_tbox */ $get_tbox("enemy", 32);
		if (!(IN_BOX != "none")) return;
		string IN_BOX = /* TODO: $sort_entlist */ $sort_entlist(IN_BOX, "range");
		latch_onto(GetToken(IN_BOX, 0, ";"));
	}

	void end_jump_scan()
	{
		JUMP_SCAN_ACTIVE = 0;
	}

	void latch_onto()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		SetSolid("box");
		LATCHED_ON = 1;
		JUMP_SCAN_ACTIVE = 0;
		LATCH_TARGET = param1;
		PlayAnim("once", "break");
		PlayAnim("critical", "chew");
		SetIdleAnim("chew");
		SetMoveAnim("chew");
		SetAngles("face.pitch");
		ApplyEffect(LATCH_TARGET, EFFECT_SCRIPT, EFFECT_DURATION, GetEntityIndex(GetOwner()), DMG_BURN_DOT);
		spider_latch_think();
		LATCH_DURATION("do_dismount");
	}

	void spider_latch_think()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if (!(LATCHED_ON)) return;
		if ((IsValidPlayer(LATCH_TARGET)))
		{
			string TARG_ORG = GetEntityProperty(LATCH_TARGET, "eyepos");
		}
		else
		{
			string TARG_ORG = GetEntityOrigin(LATCH_TARGET);
			string TARG_HEIGHT = GetEntityHeight(LATCH_TARGET);
			TARG_ORG += "z";
		}
		int RND_V_POS = RandomInt(-64, 0);
		string TARG_YAW = GetEntityProperty(LATCH_TARGET, "angles.yaw");
		TARG_ORG += /* TODO: $relpos */ $relpos(Vector3(0, TARG_YAW, 0), Vector3(0, 5, RND_V_POS));
		string TARG_GROUND = /* TODO: $get_ground_height */ $get_ground_height(TARG_ORG);
		if ((TARG_ORG).z < TARG_GROUND)
		{
			TARG_ORG = "z";
			TARG_ORG += "z";
		}
		SetEntityOrigin(GetOwner(), TARG_ORG);
	}

	void do_dismount()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if (!(LATCHED_ON)) return;
		SetSolid("none");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_MOVE);
		roll_away();
		LATCHED_ON = 0;
	}

	void roll_away()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		string TARGET_ORG = GetEntityOrigin(LATCH_TARGET);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARGET_ORG);
		SetMoveDest(LATCH_TARGET);
		SetProp(GetOwner(), "movetype", 8);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(Vector3(0, GetMonsterProperty("angles.yaw"), 0), Vector3(10, 500, 10)));
		RUN_AWAY = 1;
		NPC_HACKED_MOVE_SPEED = 50;
		SetAnimFrameRate(2.0);
		ScheduleDelayedEvent(5.0, "run_away_end");
		ScheduleDelayedEvent(0.1, "fix_bbox");
	}

	void fix_bbox()
	{
		SetProp(GetOwner(), "movetype", 4);
	}

	void run_away_end()
	{
		NPC_HACKED_MOVE_SPEED = 25;
		SetAnimFrameRate(1.0);
		RUN_AWAY = 0;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		PlayAnim("hold", ANIM_DEATH);
		if (!(true)) return;
		// svplaysound: svplaysound 2 0 SOUND_CHITTER
		EmitSound(2, 0, SOUND_CHITTER);
		EmitSound(GetOwner(), 1, SOUND_DEATH, 10);
	}

	void game_movingto_dest()
	{
		if ((I_R_FROZEN)) return;
		if ((LATCHED_ON)) return;
		SetAnimMoveSpeed(NPC_HACKED_MOVE_SPEED);
	}

	void game_stopmoving()
	{
		SetAnimMoveSpeed(0);
	}

	void npc_suicide()
	{
		if (param1 == "no_pets")
		{
			if ((I_R_PET))
			{
			}
			int EXIT_SUB = 1;
		}
		if (param1 == "only_bad")
		{
			if (GetEntityRace(GetOwner()) == "human")
			{
				int EXIT_SUB = 1;
			}
			if (GetEntityRace(GetOwner()) == "hguard")
			{
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		SetInvincible(false);
		SetRace("hated");
		SKEL_RESPAWN_TIMES = 99;
		DoDamage(GetOwner(), "direct", 30000, 100, GAME_MASTER);
	}

}

}
