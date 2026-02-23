#pragma context server

namespace MS
{

class BaseGuardFriendlyNew : CGameScript
{
	int CHECKING_CLEAR;
	string HOME_YAW;
	int MADE_IT_HOME;
	string MY_GUARD_POST;
	string MY_ORG_ANGLES;
	int NO_STUCK_CHECKS;
	string NPC_MOVEDEST_TARGET;
	int OH_IT_IS_ON;

	BaseGuardFriendlyNew()
	{
		const float BG_BASESPEED = 1.0;
		const int BG_ROAM = 0;
		const int BG_NO_GO_HOME = 0;
		const int BG_MAX_HEAR_CIV = 2048;
		const int BG_HOME_RANGE = 10;
		NO_STUCK_CHECKS = 1;
	}

	void OnSpawn() override
	{
		SetRoam(BG_ROAM);
		if (!(BG_ROAM))
		{
			SetMoveSpeed(0.0);
			NO_STUCK_CHECKS = 1;
		}
		if (BG_ROAM > 0)
		{
			SetMoveAnim(ANIM_WALK);
			SetMoveSpeed(BG_BASESPEED);
		}
		ScheduleDelayedEvent(1.0, "set_guard_post");
	}

	void set_guard_post()
	{
		MY_GUARD_POST = GetMonsterProperty("origin");
		MY_ORG_ANGLES = GetMonsterProperty("angles");
		HOME_YAW = /* TODO: $vec.yaw */ $vec.yaw(MY_ORG_ANGLES);
		guard_loop();
	}

	void guard_loop()
	{
		ScheduleDelayedEvent(1.0, "guard_loop");
		if ((OH_IT_IS_ON)) return;
		if (!(false)) return;
		baseguard_tobattle();
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if ((OH_IT_IS_ON)) return;
		baseguard_tobattle(GetEntityIndex(m_hLastStruck));
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if ((OH_IT_IS_ON)) return;
		baseguard_tobattle();
	}

	void baseguard_tobattle()
	{
		NO_STUCK_CHECKS = 0;
		MADE_IT_HOME = 0;
		OH_IT_IS_ON = 1;
		SetMoveSpeed(BG_BASESPEED);
		SetRoam(true);
		SetMoveAnim(ANIM_RUN);
		if ((CHECKING_CLEAR)) return;
		CHECKING_CLEAR = 1;
		ScheduleDelayedEvent(5.0, "baseguard_check_clear");
	}

	void npcatk_clear_targets()
	{
		baseguard_check_clear();
	}

	void baseguard_check_clear()
	{
		if ((false)) return;
		if ((false)) return;
		if ((NPC_MOVING_LAST_KNOWN)) return;
		OH_IT_IS_ON = 0;
		if ((MADE_IT_HOME))
		{
			SetAngles("face");
		}
		if (!(BG_NO_GO_HOME))
		{
			npcatk_setmovedest(MY_GUARD_POST, 1);
			if (!(MADE_IT_HOME))
			{
			}
			going_home("check_clear");
			LogDebug("baseguard_check_clear going_home");
		}
	}

	void going_home()
	{
		LogDebug("going_home PARAM1");
		if ((false)) return;
		if ((MADE_IT_HOME)) return;
		if ((OH_IT_IS_ON)) return;
		if ((BG_NO_GO_HOME)) return;
		ScheduleDelayedEvent(1.0, "going_home");
		string MY_POS = GetEntityOrigin(GetOwner());
		if (GetMonsterProperty("movedest.origin") != MY_GUARD_POST)
		{
			npcatk_setmovedest(MY_GUARD_POST, 1, "going_home");
		}
		string MY_POS = GetMonsterProperty("origin");
		if (Distance(MY_POS, MY_GUARD_POST) < BG_HOME_RANGE)
		{
			if (!(OH_IT_IS_ON))
			{
			}
			npcatk_clear_movedest();
			SetRoam(BG_ROAM);
			SetMoveSpeed(BG_ROAM);
			SetMoveAnim(ANIM_IDLE);
			SetEntityOrigin(GetOwner(), MY_GUARD_POST);
			SetAngles("face");
			MADE_IT_HOME = 1;
			NO_STUCK_CHECKS = 1;
			baseguard_made_it_home();
		}
	}

	void npc_pre_flee()
	{
		SetMoveSpeed(BG_BASESPEED);
	}

	void civilian_attacked()
	{
		string OFFENDER = param1;
		if (!(GetEntityRace(OFFENDER) != "hguard")) return;
		if (!(GetEntityRange(OFFENDER) <= BG_MAX_HEAR_CIV)) return;
		if (!(m_hAttackTarget == "unset")) return;
		if ((NPC_MOVING_LAST_KNOWN)) return;
		NO_STUCK_CHECKS = 0;
		npcatk_settarget(param1);
		if (!(false)) return;
		SetSayTextRange(1024);
		string RAND_HALT = RandomInt(1, 4);
		if (RAND_HALT == 1)
		{
			SayText("Hey you! Leave him alone!");
		}
		if (RAND_HALT == 2)
		{
			SayText("You there , leave him be I said!");
		}
		if (RAND_HALT == 3)
		{
			SayText("Stop that!");
		}
		if (RAND_HALT == 4)
		{
			SayText("Halt! We'll have no trouble making around here!");
		}
	}

	void npcatk_clear_movedest()
	{
		SetMoveDest("none");
		NPC_MOVEDEST_TARGET = "unset";
	}

}

}
