#pragma context server

#include "monsters/base_flyer.as"

namespace MS
{

class BaseFlyerAgro : CGameScript
{
	int AS_ATTACKING;
	int BF_BOOST_SPEED;
	int BF_CRUISE_SPEED;
	int BF_FLIGHT_STUCK_LIMIT;
	string FLIGHT_STUCK;
	string LAST_POS;
	float LAST_PROG;

	BaseFlyerAgro()
	{
		BF_CRUISE_SPEED = 200;
		BF_BOOST_SPEED = 500;
		BF_FLIGHT_STUCK_LIMIT = 4;
	}

	void bf_agrofly_loop()
	{
		ScheduleDelayedEvent(0.5, "bf_agrofly_loop");
		if (!(IS_HUNTING)) return;
		npcatk_faceattacker();
		if (GetEntityRange(HUNT_LASTTARGET) > MOVE_RANGE)
		{
			SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, BF_CRUISE_SPEED, 0));
		}
		if (GetEntityRange(HUNT_LASTTARGET) < MOVE_RANGE)
		{
			SetVelocity(GetOwner(), Vector3(0, 0, 0));
		}
		if ((I_R_FROZEN))
		{
			SetVelocity(GetOwner(), Vector3(0, 0, 0));
		}
		if (FLIGHT_STUCK > BF_FLIGHT_STUCK_LIMIT)
		{
			do_rand_tweedee();
			npcatk_suspend_ai(Random(0.3, 0.9));
			SetMoveDest(NEW_DEST);
			ScheduleDelayedEvent(0.1, "bf_agrofly_boost");
			FLIGHT_STUCK = 0;
		}
		AS_ATTACKING -= 2;
		string TARG_POS = GetEntityOrigin(HUNT_LASTTARGET);
		if (!(SUSPEND_AI))
		{
			SetAngles("face_origin");
		}
		if (!(AS_ATTACKING <= 0)) return;
		AS_ATTACKING = 0;
		if ((IS_FLEEING)) return;
		if ((SPITTING)) return;
		if (!(GetEntityRange(HUNT_LASTTARGET) > ATTACK_RANGE)) return;
		float CUR_PROG = Distance(GetMonsterProperty("origin"), TARG_POS);
		if (LAST_PROG >= CUR_PROG)
		{
			FLIGHT_STUCK += 1;
		}
		LAST_PROG = Distance(GetMonsterProperty("origin"), TARG_POS);
		LAST_POS = GetMonsterProperty("origin");
	}

	void chicken_run()
	{
		ScheduleDelayedEvent(0.1, "bf_agrofly_boost");
	}

	void bf_agrofly_boost()
	{
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, BF_BOOST_SPEED, 0));
	}

}

}
