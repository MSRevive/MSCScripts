#pragma context server

namespace MS
{

class Rock : CGameScript
{
	string FIRE_ROCK;
	string ROCK_OWNER;

	Rock()
	{
		const int ROCK_SPEED = 1000;
	}

	void OnSpawn() override
	{
		SetSolid("none");
		SetModel("weapons/projectiles.mdl");
		if (!(FIRE_ROCK))
		{
			SetModelBody(0, 5);
		}
		else
		{
			SetModelBody(0, 67);
			Effect("glow", GetOwner(), Vector3(255, 0, 0), 64, -1, -1);
		}
		SetFly(true);
		SetGravity(0);
		SetMoveSpeed(0);
		SetRoam(false);
		SetInvincible(true);
	}

	void game_dynamically_created()
	{
		SetRace(GetEntityRace(param1));
		if (!(IsValidPlayer(param1)))
		{
			StoreEntity("ent_expowner");
		}
		ROCK_OWNER = param1;
		if (param2 == 1)
		{
			SetModelBody(0, 67);
			Effect("glow", GetOwner(), Vector3(255, 0, 0), 64, -1, -1);
			FIRE_ROCK = 1;
		}
	}

	void toss_rock()
	{
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		string ROCK_TARG = param1;
		string ROCK_DAMAGE = param2;
		if (!(FIRE_ROCK))
		{
			TossProjectile("proj_troll_rock", "view", ROCK_TARG, ROCK_SPEED, ROCK_DAMAGE, 0.75, "none");
		}
		else
		{
			TossProjectile("proj_lava_rock", "view", ROCK_TARG, ROCK_SPEED, ROCK_DAMAGE, 0.75, "none");
		}
		CallExternal("ent_lastprojectile", "ext_lighten", 0);
		ScheduleDelayedEvent(1.5, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

}

}
