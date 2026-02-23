#pragma context server

namespace MS
{

class BagOGoldBase : CGameScript
{
	string ANIM_IDLE;
	string GOLD_AMT;
	string NEW_NAME;
	string NPC_DO_EVENTS;
	int WAS_USED;

	BagOGoldBase()
	{
		const string ANIM_OPEN = "idle";
		const string ANIM_CLOSE = "idle";
		ANIM_IDLE = "idle";
	}

	void game_dynamically_created()
	{
		ScheduleDelayedEvent(90.0, "fade_away");
		if (!(param1 != "PARAM1")) return;
		GOLD_AMT = param1;
	}

	void OnSpawn() override
	{
		SetName("Bag of Gold");
		SetModel("misc/treasure.mdl");
		SetModelBody(0, 3);
		SetSolid("none");
		SetHealth(1);
		SetInvincible(2);
		SetWidth(20);
		SetHeight(30);
		SetIdleAnim(ANIM_IDLE);
		EmitSound(GetOwner(), 0, "misc/gold.wav", 10);
		Effect("glow", GetOwner(), Vector3(230, 210, 80), 64, 3, 3);
	}

	void OnUse(CBaseEntity@ activator, CBaseEntity@ caller, int useType) override
	{
		if ((WAS_USED)) return;
		WAS_USED = 1;
		CallExternal(param1, "ext_addgold", GOLD_AMT);
		EmitSound(GetOwner(), 0, "misc/gold.wav", 10);
		remove_me();
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

	void game_postspawn()
	{
		NEW_NAME = param1;
		if (NEW_NAME != "default")
		{
			SetName(NEW_NAME);
		}
		if ((param4).findFirst(PARAM) == 0)
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		NPC_DO_EVENTS = param4;
		ScheduleDelayedEvent(0.01, "run_addparams");
	}

	void run_addparams()
	{
		for (int i = 0; i < GetTokenCount(NPC_DO_EVENTS, ";"); i++)
		{
			npcatk_do_events();
		}
	}

	void npcatk_do_events()
	{
		string N_EVENT = i;
		string EVENT_NAME = GetToken(NPC_DO_EVENTS, N_EVENT, ";");
		N_EVENT += 1;
		if (N_EVENT <= GetTokenCount(NPC_DO_EVENTS, ";"))
		{
			string NEXT_EVENT = GetToken(NPC_DO_EVENTS, N_EVENT, ";");
		}
		LogDebug("doing token event EVENT_NAME");
		EVENT_NAME(NEXT_EVENT);
	}

	void fade_away()
	{
		if ((BAG_NO_DELETE)) return;
		DeleteEntity(GetOwner(), true); // fade out
	}

}

}
