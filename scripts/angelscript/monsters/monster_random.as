#pragma context server

namespace MS
{

class MonsterRandom : CGameScript
{
	string FINAL_MOBS;
	string IN_MOBS;
	int PLAYING_DEAD;
	string SPAWN_ID;

	void OnSpawn() override
	{
		PLAYING_DEAD = 1;
		SetInvincible(true);
		SetGravity(0);
		SetNoPush(true);
		SetFly(true);
		SetHealth(1);
		SetModel("null.mdl");
		SetWidth(3);
		SetHeight(3);
		SetSolid("none");
	}

	void game_postspawn()
	{
		IN_MOBS = param4;
		if ((IN_MOBS).length() < 3)
		{
			int NO_IN_MOBS = 1;
		}
		if ((IN_MOBS).findFirst(PARAM) == 0)
		{
			int NO_IN_MOBS = 1;
		}
		if ((NO_IN_MOBS))
		{
			SendInfoMsg("all", "MAP ERROR monsters/monster_random not supplied with monster list");
			remove_me();
		}
		if ((NO_IN_MOBS)) return;
		FINAL_MOBS = "";
		for (int i = 0; i < GetTokenCount(IN_MOBS, ";"); i++)
		{
			process_in_mobs();
		}
		string N_MOBS = GetTokenCount(FINAL_MOBS, ";");
		N_MOBS -= 1;
		string RND_MOB = RandomInt(0, N_MOBS);
		string RND_MOB = GetToken(FINAL_MOBS, RND_MOB, ";");
		spawn_mob(RND_MOB);
	}

	void process_in_mobs()
	{
		string CUR_MOB = GetToken(IN_MOBS, i, ";");
		if ((CUR_MOB).findFirst("/") >= 0)
		{
			if (FINAL_MOBS.length() > 0) FINAL_MOBS += ";";
			FINAL_MOBS += CUR_MOB;
		}
		else
		{
			string OUT_TOKEN = "monsters/";
			OUT_TOKEN += CUR_MOB;
			if (FINAL_MOBS.length() > 0) FINAL_MOBS += ";";
			FINAL_MOBS += OUT_TOKEN;
		}
	}

	void spawn_mob()
	{
		SpawnNPC(param1, GetEntityOrigin(GetOwner()), ScriptMode::Legacy);
		SPAWN_ID = GetEntityIndex(m_hLastCreated);
		ScheduleDelayedEvent(1.0, "monitor_spawn");
	}

	void monitor_spawn()
	{
		if (!(IsEntityAlive(SPAWN_ID)))
		{
			remove_me();
		}
		else
		{
			ScheduleDelayedEvent(0.5, "monitor_spawn");
		}
	}

	void remove_me()
	{
		SetInvincible(false);
		SetRace("hated");
		DoDamage(GetOwner(), "direct", 99999, 100, GAME_MASTER);
	}

}

}
