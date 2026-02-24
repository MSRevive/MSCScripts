#pragma context server

namespace MS
{

class BaseFlyerGrav : CGameScript
{
	int BFLY_AGRESSIVE;
	int BFLY_AGRESSIVE_MAX_THRUST;
	int BFLY_AGRESSIVE_MIN_RANGE;
	float BFLY_MIN_REMOVE_DELAY;
	int BFLY_VRANGE;
	int BFLY_VSPEED_DOWN;
	int BFLY_VSPEED_UP;

	BaseFlyerGrav()
	{
		BFLY_VSPEED_UP = 25;
		BFLY_VSPEED_DOWN = -25;
		BFLY_VRANGE = 50;
		BFLY_MIN_REMOVE_DELAY = 15.0;
		BFLY_AGRESSIVE = 0;
		BFLY_AGRESSIVE_MAX_THRUST = 100;
		BFLY_AGRESSIVE_MIN_RANGE = 128;
	}

	void OnSpawn() override
	{
		SetGravity(0);
	}

	void npc_targetsighted()
	{
		if (!(BFLY_AGRESSIVE)) return;
		if (!(GetEntityRange(m_hAttackTarget) > BFLY_AGRESSIVE_MIN_RANGE)) return;
		string L_THRUST_RATIO = GetEntityRange(m_hAttackTarget);
		if (L_THRUST_RATIO > 640)
		{
			int L_THRUST_RATIO = 640;
		}
		L_THRUST_RATIO /= 640;
		string L_THRUST_RATIO = /* TODO: $ratio */ $ratio(L_THRUST_RATIO, 0, BFLY_AGRESSIVE_MAX_THRUST);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, L_THRUST_RATIO, 0));
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if ((SUSPEND_AI)) return;
		if ((I_R_FROZEN)) return;
		if ((BFLY_SUSPEND_FLY)) return;
		string MOVE_DEST_Z = (GetMonsterProperty("movedest.origin")).z;
		string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
		if (MOVE_DEST_Z > MY_Z)
		{
			string Z_DIFF = MOVE_DEST_Z;
			Z_DIFF -= MY_Z;
			if (Z_DIFF > BFLY_VRANGE)
			{
			}
			AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, BFLY_VSPEED_UP));
		}
		if (MOVE_DEST_Z < MY_Z)
		{
			string Z_DIFF = MY_Z;
			Z_DIFF -= MOVE_DEST_Z;
			if (Z_DIFF > BFLY_VRANGE)
			{
			}
			AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, BFLY_VSPEED_DOWN));
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((BFLY_NO_FAKE_DEATH)) return;
		PlayAnim("critical", ANIM_DEATH);
		ClientEvent("update", "all", "const.localplayer.scriptID", "spawn_corpse", GetEntityIndex(GetOwner()), GetEntityProperty(GetOwner(), "anim.index"), GetEntityProperty(GetOwner(), "renderprops"));
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
	}

}

}
