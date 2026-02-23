#pragma context server

#include "monsters/base_flyer.as"
#include "monsters/base_monster.as"

namespace MS
{

class BatBase : CGameScript
{
	string ANIM_DEATH;
	string ANIM_DEATH_NEW;
	string ANIM_IDLE;
	int AS_ATTACKING;
	string BAT_STATUS;
	int CAN_HEAR;
	int CAN_HUNT;
	string FLIGHT_STUCK;
	int HUNT_AGRO;
	string LAST_POS;
	string LAST_PROG;
	float RETALIATE_CHANCE;

	BatBase()
	{
		const int BAT_FLYING = 0;
		const int BAT_HANGING = 1;
		const int BAT_DROPPING = 2;
		ANIM_DEATH = "die";
		ANIM_DEATH_NEW = "die";
		const string ANIM_DEAD = "deadground";
		ANIM_IDLE = "IdleFlyNormal";
		HUNT_AGRO = 1;
		RETALIATE_CHANCE = 0.75;
		CAN_HEAR = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.5);
		if ((IS_HUNTING))
		{
		}
		npcatk_faceattacker();
		if (GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)
		{
			SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 100, 0));
		}
		if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)
		{
			SetVelocity(GetOwner(), Vector3(0, 0, 0));
		}
		if ((SPITTING))
		{
			SetVelocity(GetOwner(), Vector3(0, 0, 0));
		}
		if (FLIGHT_STUCK > 4)
		{
			do_rand_tweedee();
			npcatk_suspend_ai(Random(0.3, 0.9));
			SetMoveDest(NEW_DEST);
			ScheduleDelayedEvent(0.1, "horror_boost");
			FLIGHT_STUCK = 0;
		}
		AS_ATTACKING -= 2;
		string TARG_POS = GetEntityOrigin(m_hAttackTarget);
		if (!(SUSPEND_AI))
		{
			SetAngles("face_origin");
		}
		if (AS_ATTACKING <= 0)
		{
		}
		AS_ATTACKING = 0;
		if (!(IS_FLEEING))
		{
		}
		if (!(SPITTING))
		{
		}
		if (GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)
		{
		}
		string CUR_PROG = Distance(GetMonsterProperty("origin"), TARG_POS);
		if (LAST_PROG >= CUR_PROG)
		{
			FLIGHT_STUCK += 1;
		}
		LAST_PROG = Distance(GetMonsterProperty("origin"), TARG_POS);
		LAST_POS = GetMonsterProperty("origin");
	}

	void OnSpawn() override
	{
		SetFly(true);
		SetRace("wildanimal");
		ScheduleDelayedEvent(0.1, "bat_spawn");
		bat_hang();
	}

	void OnPostSpawn() override
	{
		string L_MAP_NAME = StringToLower(GetMapName());
		if (!(L_MAP_NAME == "sfor")) return;
		SetMonsterClip(0);
	}

	void bat_hang()
	{
		SetIdleAnim(ANIM_IDLE_HANG);
		SetMoveAnim(ANIM_WALK);
		SetRoam(false);
		BAT_STATUS = BAT_HANGING;
		CAN_HUNT = 0;
	}

	void npc_targetsighted()
	{
		basebat_drop_down();
	}

	void npc_heardenemy()
	{
		basebat_drop_down();
	}

	void basebat_drop_down()
	{
		CAN_HUNT = 1;
		if (!(BAT_STATUS == BAT_HANGING)) return;
		bat_drop_down();
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((BAT_NO_FAKE_DEATH)) return;
		SetMoveDest(/* TODO: $relpos */ $relpos(0, 0, 2048));
		SetSolid("none");
		SetFly(false);
		SetIdleAnim(ANIM_DEAD);
		SetMoveAnim(ANIM_DEAD);
		SetProp(GetOwner(), "movetype", "const.movetype.noclip");
		PlayAnim("critical", ANIM_DEATH_NEW);
		DropToFloor();
		DropToFloor();
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, -10));
		string SLAYER_LOC = GetEntityOrigin(m_hLastStruck);
		string SLAYER_X = (SLAYER_LOC).x;
		string MY_LOC = GetEntityOrigin(GetOwner());
		string MY_X = (MY_LOC).x;
		string DISTANCE_X = SLAYER_X;
		DISTANCE_X -= MY_X;
		if (DISTANCE_X < 0)
		{
			string HOLDER = DISTANCE_X;
			HOLDER *= 2;
			DISTANCE_X -= HOLDER;
		}
		if (DISTANCE_X < 12)
		{
			SetModel("none");
		}
	}

	void chicken_run()
	{
		ScheduleDelayedEvent(0.1, "horror_boost");
	}

	void horror_boost()
	{
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 200, 0));
	}

}

}
