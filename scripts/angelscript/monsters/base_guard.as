#pragma context server

namespace MS
{

class BaseGuard : CGameScript
{
	string HUNT_LASTTARGET;
	int MADE_IT_HOME;
	string MY_GUARD_POST;
	string MY_ORG_ANGLES;
	int OH_IT_IS_ON;

	void OnSpawn() override
	{
		SetRoam(false);
		SetMoveSpeed(0.0);
		ScheduleDelayedEvent(1.0, "set_guard_post");
		ScheduleDelayedEvent(1.0, "scan_for_enemies");
	}

	void set_guard_post()
	{
		MY_GUARD_POST = GetEntityOrigin(GetOwner());
		MY_ORG_ANGLES = GetEntityAngles(GetOwner());
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		if ((OH_IT_IS_ON)) return;
		baseguard_tobattle();
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if ((OH_IT_IS_ON)) return;
		if (!(false)) return;
		baseguard_tobattle();
	}

	void baseguard_tobattle()
	{
		OH_IT_IS_ON = 1;
		SetMoveSpeed(1.0);
		SetRoam(true);
		SetMoveAnim(ANIM_RUN);
		SetActionAnim(ANIM_ATTACK);
		PlayAnim("loop", ANIM_ATTACK);
		if (param1 != "PARAM1")
		{
			SetMoveDest(param1);
		}
	}

	void my_target_died()
	{
		if ((false)) return;
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

}

}
