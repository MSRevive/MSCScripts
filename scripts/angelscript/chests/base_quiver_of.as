#pragma context server

namespace MS
{

class BaseQuiverOf : CGameScript
{
	string BQ_BUNDLE_SIZE;
	int BQ_CUSTOM;
	string BQ_QUIVER_TYPE;
	string NEW_NAME;
	string NPC_DO_EVENTS;

	BaseQuiverOf()
	{
		const int IS_QUIVER = 1;
	}

	void OnSpawn() override
	{
		SetHealth(1);
		SetInvincible(2);
		SetName("Quiver");
		SetWidth(20);
		SetHeight(30);
		SetModel("weapons/bows/quiver_floor.mdl");
		SetSolid("trigger");
		EmitSound(GetOwner(), 0, "player/hitground2.wav", 10);
	}

	void OnUse(CBaseEntity@ activator, CBaseEntity@ caller, int useType) override
	{
		if (BQ_QUIVER_TYPE == "BQ_QUIVER_TYPE")
		{
			int IS_ERROR = 1;
		}
		if ((BQ_QUIVER_TYPE).findFirst(PARAM) == 0)
		{
			int IS_ERROR = 1;
		}
		if ((IS_ERROR))
		{
			string OUT_MSG = "Quiver type invalid or not set (";
			OUT_MSG += BQ_QUIVER_TYPE;
			OUT_MSG += ")";
			SendInfoMsg(param1, "QUIVER ERROR OUT_MSG");
		}
		// TODO: offer PARAM1 BQ_QUIVER_TYPE BQ_BUNDLE_SIZE
		DeleteEntity(GetOwner());
	}

	void fade_away()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

	void game_dynamically_created()
	{
		if ((param1).findFirst(PARAM) == 0)
		{
			set_type(param1, param2);
		}
		ScheduleDelayedEvent(30.0, "fade_away");
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

	void set_type()
	{
		BQ_CUSTOM = 1;
		BQ_QUIVER_TYPE = param1;
		if ((param2).findFirst(PARAM) == 0)
		{
			BQ_BUNDLE_SIZE = param2;
		}
		else
		{
			BQ_BUNDLE_SIZE = 30;
		}
	}

}

}
