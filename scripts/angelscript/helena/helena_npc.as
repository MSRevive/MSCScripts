#pragma context server

#include "monsters/debug.as"

namespace MS
{

class HelenaNpc : CGameScript
{
	int HELENA_RETURNED_HOME;
	int HELENA_SAVED;
	string HELENA_TELE_HOME_TIME;
	string NPC_HOME_ANG;
	string NPC_HOME_LOC;
	int OVERCHARGE;
	int RAID_ON;
	string SCAREY_GUY;
	float SELL_RATIO;
	int STORE_CLOSED;

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		helena_flee(GetEntityIndex(m_hLastStruck), "struck");
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		string LAST_HEARD = GetEntityIndex("ent_lastheard");
		if (!(GetEntityRange(LAST_HEARD) < 128)) return;
		if ((IsValidPlayer(LAST_HEARD))) return;
		if (GetEntityRace(LAST_HEARD) == "orc")
		{
			helena_flee(LAST_HEARD, "heard_orc");
		}
		if (GetEntityRace(LAST_HEARD) == "rogue")
		{
			helena_flee(LAST_HEARD, "heard_bandit");
		}
	}

	void helena_flee()
	{
		SetRoam(true);
		SCAREY_GUY = param1;
		SetMoveAnim("run1");
		SetMoveDest(SCAREY_GUY);
		ScheduleDelayedEvent(10.0, "helena_stopflee");
	}

	void helena_stopflee()
	{
		SetMoveAnim("walk_scared");
	}

	void helena_raid_go()
	{
		SetHearingSensitivity(4);
		RAID_ON = 1;
		HELENA_RETURNED_HOME = 0;
		HELENA_SAVED = 0;
		if (NPC_HOME_LOC == "NPC_HOME_LOC")
		{
			NPC_HOME_LOC = GetMonsterProperty("origin");
			NPC_HOME_ANG = GetMonsterProperty("angles");
		}
		SetInvincible(false);
		SetMoveAnim("walk_scared");
		SetIdleAnim("crouch_idle");
		SetMenuAutoOpen(0);
		STORE_CLOSED = 1;
	}

	void helena_raid_end()
	{
		HELENA_TELE_HOME_TIME = GetGameTime();
		HELENA_TELE_HOME_TIME += 60.0;
		if (STORE_NAME != "STORE_NAME")
		{
			helena_return_home();
		}
		if (STORE_NAME == "STORE_NAME")
		{
			helena_made_it_home();
		}
	}

	void helena_return_home()
	{
		SetMoveDest(NPC_HOME_LOC);
		if (Distance(GetMonsterProperty("origin"), NPC_HOME_LOC) < 10)
		{
			helena_made_it_home();
			int EXIT_SUB = 1;
		}
		if (GetGameTime() >= HELENA_TELE_HOME_TIME)
		{
			helena_made_it_home();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetGameTime() < HELENA_TELE_HOME_TIME)) return;
		if ((HELENA_RETURNED_HOME)) return;
		string RND_DELAY = Random(4, 9);
		RND_DELAY("helena_return_home");
	}

	void helena_made_it_home()
	{
		OVERCHARGE = 50;
		SELL_RATIO = 1.0;
		STORE_CLOSED = 0;
		HELENA_SAVED = 1;
		if (STORE_NAME != "STORE_NAME")
		{
			SetEntityOrigin(GetOwner(), NPC_HOME_LOC);
			string OLD_YAW = /* TODO: $vec.yaw */ $vec.yaw(NPC_HOME_ANG);
			SetAngles("face");
			SetIdleAnim("idle1");
			SetMoveAnim("idle1");
			SetRoam(false);
			SetMoveDest("none");
			NpcStoreRemove(STORE_NAME, "allitems");
			vendor_addstoreitems();
			SetMenuAutoOpen(1);
		}
		else
		{
			SetIdleAnim("idle1");
			SetMoveAnim("walk");
		}
		HELENA_RETURNED_HOME = 1;
		RAID_ON = 0;
	}

	void basevendor_offerstore()
	{
		if (!(HELENA_SAVED)) return;
		string RND_SAY = RandomInt(1, 3);
		if (RND_SAY == 1)
		{
			SayText("Thank you for saving our little town. For you , I ll offer a discount rate.");
		}
		if (RND_SAY == 2)
		{
			SayText("For the saviors of Helena , we offer discount rates.");
		}
		if (RND_SAY == 3)
		{
			SayText("Thank you again , please , consider everything on discount.");
		}
		Say("[.56] [.4] [.58] [.66]");
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if ((DEFAULT_HUMAN)) return;
		call_for_help(GetEntityIndex(m_hLastStruck));
	}

	void call_for_help()
	{
		SetSayTextRange(1024);
		string RAND_SCREAM = RandomInt(1, 4);
		if (RAND_SCREAM == 1)
		{
			SayText("Help! Help!");
		}
		if (RAND_SCREAM == 2)
		{
			SayText("Guards! Call the guards!");
		}
		if (RAND_SCREAM == 3)
		{
			SayText("Save me!");
		}
		if (RAND_SCREAM == 4)
		{
			SayText("Help! Help! I m being repressed!");
		}
		CallExternal("all", "civilian_attacked", param1, IsValidPlayer(param1));
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((DEFAULT_HUMAN)) return;
		CallExternal("all", "civilian_attacked", GetEntityIndex(m_hLastStruck), IsValidPlayer(m_hLastStruck));
	}

}

}
