#pragma context server

namespace MS
{

class BaseFish2 : CGameScript
{
	int BF_STAY_IN_WATER;
	int FISH_VRANGE;
	int FISH_VSPEED_DOWN;
	int FISH_VSPEED_UP;
	int NPC_IS_FISH;

	BaseFish2()
	{
		FISH_VSPEED_UP = 25;
		FISH_VSPEED_DOWN = -25;
		FISH_VRANGE = 50;
		BF_STAY_IN_WATER = 1;
		NPC_IS_FISH = 1;
	}

	void OnSpawn() override
	{
		SetGravity(0);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		string MOVE_DEST_Z = (GetMonsterProperty("movedest.origin")).z;
		string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
		string L_FISH_VSPEED_UP = FISH_VSPEED_UP;
		string L_FISH_VSPEED_DOWN = FISH_VSPEED_DOWN;
		if ((BF_STAY_IN_WATER))
		{
			if (IsInWater(GetOwner()) < 1)
			{
				if (!(SUSPEND_AI))
				{
					npcatk_suspend_ai(2.0);
				}
				SetMoveDest(NPC_HOME_LOC);
				string MOVE_DEST_Z = (NPC_HOME_LOC).z;
				SetGravity(0.5);
				L_FISH_VSPEED_UP *= 0.5;
				L_FISH_VSPEED_DOWN *= 2;
			}
			else
			{
				SetGravity(0);
			}
		}
		if (MOVE_DEST_Z > MY_Z)
		{
			if ((IsInWater(GetOwner())))
			{
			}
			string Z_DIFF = MOVE_DEST_Z;
			Z_DIFF -= MY_Z;
			if (Z_DIFF > FISH_VRANGE)
			{
			}
			AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, L_FISH_VSPEED_UP));
		}
		if (MOVE_DEST_Z < MY_Z)
		{
			string Z_DIFF = MY_Z;
			Z_DIFF -= MOVE_DEST_Z;
			if (Z_DIFF > FISH_VRANGE)
			{
			}
			AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, L_FISH_VSPEED_DOWN));
		}
	}

}

}
