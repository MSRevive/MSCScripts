#pragma context server

namespace MS
{

class SealMaker : CGameScript
{
	int PLAYING_DEAD;
	string SEAL_MODEL;
	int SEAL_RUNNING;

	void game_dynamically_created()
	{
		SEAL_MODEL = param1;
		SetModel(param1);
		SetModelBody(0, param3);
		PARAM2("make_go_bye_bye");
	}

	void OnSpawn() override
	{
		SetName("Magic Seal");
		SetHealth(10000);
		SetInvincible(true);
		SetDamageResistance("all", 0.0);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("lightning", 0.0);
		SetDamageResistance("cold", 0.0);
		SetMoveSpeed(0.0);
		PLAYING_DEAD = 1;
		SetFly(true);
		1 = float(1);
		SetGravity(0.0);
		SetBloodType("none");
		if (SEAL_MODEL == "SEAL_MODEL")
		{
			SEAL_MODEL = "none";
		}
		SetModel(SEAL_MODEL);
		SetSolid("none");
		DropToFloor();
		SEAL_RUNNING = 1;
		ScheduleDelayedEvent(0.5, "stay_floor");
	}

	void stay_floor()
	{
		if (!(SEAL_RUNNING)) return;
		DropToFloor();
		ScheduleDelayedEvent(1.0, "stay_floor");
	}

	void make_go_bye_bye()
	{
		SEAL_RUNNING = 0;
		SetEntityOrigin(GetOwner(), Vector3(20000, 20000, 20000));
		ScheduleDelayedEvent(0.5, "final_remove");
	}

	void final_remove()
	{
		ClientEvent("remove", "all", currentscript);
		DeleteEntity(GetOwner());
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetAlive(1);
	}

}

}
