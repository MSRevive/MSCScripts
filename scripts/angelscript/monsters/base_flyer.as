#pragma context server

namespace MS
{

class BaseFlyer : CGameScript
{
	float BF_CHECK_FREQ;
	int BF_NO_STUCK;
	float BF_RETREAT_TIME;
	string BF_UNSTUCK_ADJ;
	string BOUNCED;
	string FLIGHT_CHECK_FREQ;
	int FLIGHT_SCANNING;
	string FLY_OLD_POS;
	string NEW_DEST;
	int NO_STUCK_CHECKS;

	BaseFlyer()
	{
		BF_CHECK_FREQ = 0.2;
		BF_RETREAT_TIME = 1.0;
		BF_UNSTUCK_ADJ = /* TODO: $relvel */ $relvel(0, 50, 0);
		FLIGHT_CHECK_FREQ = BF_CHECK_FREQ;
		NO_STUCK_CHECKS = 1;
	}

	void OnSpawn() override
	{
		ScheduleDelayedEvent(0.2, "setup_flight");
	}

	void setup_flight()
	{
		FLY_OLD_POS = GetMonsterProperty("pos");
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if ((FLIGHT_SCANNING)) return;
		FLIGHT_SCANNING = 1;
		ScheduleDelayedEvent(1.0, "flight_check");
	}

	void flight_check()
	{
		float FLY_MOVED = Distance(FLY_OLD_POS, GetMonsterProperty("origin"));
		string HIT_WALL = TraceLine(GetMonsterProperty("origin"), GetMonsterProperty("movedest"));
		if (HIT_WALL != GetMonsterProperty("movedest"))
		{
			if (Distance(GetMonsterProperty("origin"), GetMonsterProperty("movedest")) < 50)
			{
			}
			npcatk_suspend_ai(0.2);
			do_one_eighty();
			SetMoveDest(NEW_DEST);
			ScheduleDelayedEvent(0.1, "bat_boost");
		}
		if (FLY_MOVED == 0)
		{
			if (!(BF_NO_STUCK))
			{
			}
			npcatk_suspend_ai(0.2);
			BOUNCED = 1;
			FLIGHT_CHECK_FREQ = BF_RETREAT_TIME;
			if (!(false))
			{
			}
			do_one_eighty();
			SetMoveDest(NEW_DEST);
			ScheduleDelayedEvent(0.1, "bat_boost");
		}
		if (FLY_MOVED != 0)
		{
			if (!(BF_NO_STUCK))
			{
			}
			if ((BOUNCED))
			{
			}
			BOUNCED = 0;
			FLIGHT_CHECK_FREQ = BF_CHECK_FREQ;
		}
		FLY_OLD_POS = GetMonsterProperty("origin");
		FLIGHT_CHECK_FREQ("flight_check");
	}

	void npc_selectattack()
	{
		FLY_OLD_POS = Vector3(20000, 20000, 20000);
	}

	void bf_suspend_stuck()
	{
		PARAM1("bf_resume_stuck");
		BF_NO_STUCK = 1;
	}

	void bf_resume_stuck()
	{
		FLY_OLD_POS = Vector3(20000, 20000, 20000);
		BF_NO_STUCK = 0;
	}

	void bat_boost()
	{
		AddVelocity(GetOwner(), BF_UNSTUCK_ADJ);
		ScheduleDelayedEvent(1.0, "bf_reset_target");
	}

	void bf_reset_target()
	{
		SetMoveDest(m_hAttackTarget);
	}

	void do_one_eighty2()
	{
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(GetMonsterProperty("angles"));
		MY_YAW += 180;
		if (MY_YAW > 359)
		{
			MY_YAW -= 359;
		}
		string MY_PITCH = /* TODO: $vec.pitch */ $vec.pitch(GetMonsterProperty("angles"));
		MY_PITCH += 180;
		if (MY_PITCH > 359)
		{
			MY_PITCH -= 359;
		}
		NEW_DEST = /* TODO: $relpos */ $relpos(Vector3(0, MY_PITCH, 0), Vector3(0, 1000, 0));
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(GetMonsterProperty("angles"));
		MY_YAW += 180;
		if (MY_YAW > 359)
		{
			MY_YAW -= 359;
		}
		string MY_PITCH = /* TODO: $vec.pitch */ $vec.pitch(GetMonsterProperty("angles"));
		MY_PITCH += 180;
		if (MY_PITCH > 359)
		{
			MY_PITCH -= 359;
		}
		string MY_ROLL = /* TODO: $vec.roll */ $vec.roll(GetMonsterProperty("angles"));
		MY_ROLL += 180;
		if (MY_ROLL > 359)
		{
			MY_ROLL -= 359;
		}
		NEW_DEST = /* TODO: $relpos */ $relpos(Vector3(MY_PITCH, MY_YAW, MY_ROLL), Vector3(0, 1000, 0));
	}

	void do_rand_tweedee()
	{
		int MY_PITCH = RandomInt(0, 359);
		int MY_YAW = RandomInt(0, 359);
		int MY_ROLL = RandomInt(0, 359);
		NEW_DEST = /* TODO: $relpos */ $relpos(Vector3(MY_PITCH, MY_YAW, MY_ROLL), Vector3(0, 1000, 0));
	}

}

}
