#pragma context server

namespace MS
{

class BaseGuardFriendly : CGameScript
{
	string HUNT_LASTTARGET;
	string IS_HUNTING;
	int MADE_IT_HOME;
	string MY_GUARD_POST;
	string MY_ORG_ANGLES;
	int NO_STUCK_CHECKS;
	string NPC_ATTACK_TARGET;
	string NPC_MOVE_TARGET;
	int OH_IT_IS_ON;
	int STRUCK_BY_PLAYER;

	BaseGuardFriendly()
	{
		NO_STUCK_CHECKS = 1;
	}

	void OnSpawn() override
	{
		SetRoam(false);
		SetMoveSpeed(0.0);
		npcatk_suspend_ai();
		ScheduleDelayedEvent(1.0, "set_guard_post");
		ScheduleDelayedEvent(1.0, "scan_for_enemies");
	}

	void set_guard_post()
	{
		MY_GUARD_POST = GetEntityOrigin(GetOwner());
		MY_ORG_ANGLES = GetEntityAngles(GetOwner());
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if ((OH_IT_IS_ON)) return;
		baseguard_tobattle(GetEntityIndex(m_hLastStruck));
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if ((OH_IT_IS_ON)) return;
		if (!(false)) return;
		baseguard_tobattle();
	}

	void baseguard_tobattle()
	{
		npcatk_resume_ai();
		OH_IT_IS_ON = 1;
		SetMoveSpeed(1.0);
		SetRoam(true);
		SetMoveAnim(ANIM_RUN);
		SetActionAnim(ANIM_ATTACK);
		PlayAnim("critical", ANIM_ATTACK);
		if (param1 != "PARAM1")
		{
			IS_HUNTING = 1;
			HUNT_LASTTARGET = param1;
			NPC_MOVE_TARGET = param1;
			SetMoveDest(HUNT_LASTTARGET);
		}
	}

	void my_target_died()
	{
		if ((false)) return;
		STRUCK_BY_PLAYER = 0;
		OH_IT_IS_ON = 0;
		SetAngles("face_origin");
		SetMoveDest(MY_GUARD_POST);
		MADE_IT_HOME = 0;
		going_home();
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if (!(GetRelationship("ent_lastheard") == "enemy")) return;
		if ((IsValidPlayer("ent_lastheard"))) return;
		HUNT_LASTTARGET = m_hLastSeen;
		SetMoveDest("ent_lastheard");
		baseguard_tobattle(GetEntityIndex("ent_lastheard"));
	}

	void scan_for_enemies()
	{
		if ((OH_IT_IS_ON)) return;
		ScheduleDelayedEvent(1.1, "scan_for_enemies");
		if (!(false)) return;
		if ((IsValidPlayer(m_hLastSeen))) return;
		HUNT_LASTTARGET = m_hLastSeen;
		SetMoveDest(m_hLastSeen);
		baseguard_tobattle(GetEntityIndex(m_hLastSeen));
	}

	void going_home()
	{
		if ((false)) return;
		if ((MADE_IT_HOME)) return;
		if ((OH_IT_IS_ON)) return;
		ScheduleDelayedEvent(1.0, "going_home");
		string MY_POS = GetEntityOrigin(GetOwner());
		if (GetMonsterProperty("movedest.origin") != MY_GUARD_POST)
		{
			SetMoveDest(MY_GUARD_POST);
		}
		if (Distance(MY_POS, MY_GUARD_POST) < 10)
		{
			if (!(OH_IT_IS_ON))
			{
			}
			string MY_POS = GetEntityOrigin(GetOwner());
			SetMoveDest("none");
			SetRoam(false);
			SetMoveSpeed(0.0);
			SetMoveAnim(ANIM_IDLE);
			SetActionAnim(ANIM_IDLE);
			SetAngles("face");
			ScheduleDelayedEvent(1.0, "scan_for_enemies");
			MADE_IT_HOME = 1;
		}
	}

	void check_attack()
	{
		NPC_ATTACK_TARGET = HUNT_LASTTARGET;
	}

}

}
