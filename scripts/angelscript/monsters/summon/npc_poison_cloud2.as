#pragma context server

namespace MS
{

class NpcPoisonCloud2 : CGameScript
{
	string CLOUD_TYPE;
	string CL_ID;
	string DOT_POISON;
	int IS_ACTIVE;
	string MY_DURATION;
	string MY_OWNER;
	int PLAYING_DEAD;
	string SCAN_TARGS;

	NpcPoisonCloud2()
	{
		const int CLOUD_RADIUS = 256;
		Precache("poison_cloud.spr");
	}

	void OnSpawn() override
	{
		SetName("Poisonous Cloud");
		SetNoPush(true);
		SetInvincible(true);
		PLAYING_DEAD = 1;
		SetWidth(1);
		SetHeight(1);
		SetModel("null.mdl");
		SetSolid("none");
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		DOT_POISON = param2;
		MY_DURATION = param3;
		CLOUD_TYPE = param4;
		if ((CLOUD_TYPE).findFirst("PARAM") == 0)
		{
			CLOUD_TYPE = 1;
		}
		LogDebug("game_dynamically_created Owner GetEntityName(MY_OWNER) dot DOT_POISON dur MY_DURATION type CLOUD_TYPE");
		SetRace(GetEntityRace(MY_OWNER));
		CL_ID = "game.script.last_sent_id";
		IS_ACTIVE = 1;
		ScheduleDelayedEvent(0.1, "do_scan");
		ScheduleDelayedEvent(0.1, "cl_effects");
		MY_DURATION("remove_me");
	}

	void cl_effects()
	{
		string L_POS = GetEntityOrigin(GetOwner());
		L_POS = "z";
		ClientEvent("new", "all", "monsters/summon/npc_poison_cloud2_cl", L_POS, MY_DURATION, CLOUD_TYPE);
	}

	void do_scan()
	{
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(1.0, "do_scan");
		string L_POS = GetEntityOrigin(GetOwner());
		L_POS += "z";
		SCAN_TARGS = FindEntitiesInSphere("enemy", CLOUD_RADIUS);
		if (!(SCAN_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(SCAN_TARGS, ";"); i++)
		{
			poison_targets();
		}
	}

	void poison_targets()
	{
		string CUR_TARG = GetToken(SCAN_TARGS, i, ";");
		if (CLOUD_TYPE == 1)
		{
			ApplyEffect(CUR_TARG, "effects/dot_poison", 5.0, MY_OWNER, DOT_POISON);
		}
		if (CLOUD_TYPE == 2)
		{
			ApplyEffect(CUR_TARG, "effects/poison_spore", 5.0, MY_OWNER, DOT_POISON);
		}
		if (CLOUD_TYPE == 3)
		{
			ApplyEffect(CUR_TARG, "effects/dot_acid", 5.0, MY_OWNER, DOT_POISON, "none");
		}
	}

	void remove_me()
	{
		IS_ACTIVE = 0;
		DeleteEntity(GetOwner());
	}

}

}
