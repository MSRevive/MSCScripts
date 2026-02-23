#pragma context server

namespace MS
{

class FxManabolt : CGameScript
{
	string F_BALL_SIZE;
	string MY_OWNER;

	void OnSpawn() override
	{
		SetModel("weapons/projectiles.mdl");
		SetSolid("none");
		SetModelBody(0, 14);
		SetRace("beloved");
		SetInvincible(true);
		SetFly(true);
		SetGravity(0);
		SetMonsterClip(0);
		SetProp(GetOwner(), "renderamt", 10);
		SetProp(GetOwner(), "rendermode", 5);
	}

	void game_dynamically_created()
	{
		MY_OWNER = GetEntityIndex(param1);
		ScheduleDelayedEvent(0.1, "stick_to_owner");
	}

	void stick_to_owner()
	{
		ScheduleDelayedEvent(0.1, "stick_to_owner");
		SetProp(GetOwner(), "renderamt", 10);
		SetProp(GetOwner(), "rendermode", 5);
		string SET_LOC = GetEntityOrigin(MY_OWNER);
		string OWNER_YAW = GetEntityProperty(MY_OWNER, "angles.yaw");
		string OWNER_PITCH = GetEntityProperty(MY_OWNER, "angles.pitch");
		string N_OWNER_PITCH = /* TODO: $neg */ $neg(OWNER_PITCH);
		SET_LOC += /* TODO: $relpos */ $relpos(Vector3(N_OWNER_PITCH, OWNER_YAW, 0), Vector3(0, 20, 28));
		SetEntityOrigin(GetOwner(), SET_LOC);
		F_BALL_SIZE = GetEntityProperty(MY_OWNER, "scriptvar");
		if (F_BALL_SIZE == 0)
		{
			DeleteEntity(GetOwner());
		}
		if (!(F_BALL_SIZE > 0)) return;
		string SUB_MODEL = int(F_BALL_SIZE);
		SUB_MODEL += 12;
		string SUB_MODEL = int(SUB_MODEL);
		SetModelBody(0, SUB_MODEL);
	}

	void set_size()
	{
		string IN_SIZE = param1;
		string SUB_MODEL = int(IN_SIZE);
		SUB_MODEL += 13;
		SetModelBody(0, SUB_MODEL);
	}

}

}
