#pragma context server

namespace MS
{

class IceWave : CGameScript
{
	int IR_ACTIVE;
	string MY_OWNER;

	void game_dynamically_created()
	{
		MY_OWNER = GetEntityIndex(param2);
		PARAM1("wave_die");
		IR_ACTIVE = 1;
	}

	void OnSpawn() override
	{
		SetName("Ice Wave");
		SetHealth(10000);
		SetInvincible(true);
		SetRace("beloved");
		SetSolid("none");
		SetBloodType("none");
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 52);
		IR_ACTIVE = 1;
		snap_to();
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
	}

	void snap_to()
	{
		if (!(IR_ACTIVE)) return;
		string SEAL_POS = GetEntityOrigin(MY_OWNER);
		string GROUND_Z = /* TODO: $get_ground_height */ $get_ground_height(SEAL_POS);
		string SEAL_Z = (SEAL_POS).z;
		string GROUND_DIST = GROUND_Z;
		GROUND_DIST -= SEAL_Z;
		GROUND_DIST -= 2;
		SEAL_POS += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, GROUND_DIST));
		SetEntityOrigin(GetOwner(), SEAL_POS);
		string OWNER_ANGLES = GetEntityAngles(MY_OWNER);
		SetAngles("face");
		ScheduleDelayedEvent(0.1, "snap_to");
	}

	void wave_die()
	{
		IR_ACTIVE = 0;
		ScheduleDelayedEvent(0.1, "final_bye_bye");
	}

	void final_bye_bye()
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
