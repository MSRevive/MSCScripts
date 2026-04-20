#pragma context server

namespace MS
{

class SorcSitting : CGameScript
{
	string ANIM_ACTION;
	string NPC_DO_EVENTS;

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(10.0, 20.0));
		PlayAnim("once", ANIM_ACTION);
	}

	void OnSpawn() override
	{
		SetName("Shadahar Orc");
		SetModel("monsters/sorc.mdl");
		SetHealth(2000);
		SetDamageResistance("all", 0.7);
		SetStat("parry", 110);
		SetInvincible(true);
		SetRace("beloved");
		SetNoPush(true);
		SetRoam(false);
		SetWidth(32);
		SetHeight(96);
		SetIdleAnim("on_chair");
		SetMoveAnim("on_chair");
		PlayAnim("critical", "on_chair");
		SetModelBody(0, 0);
		SetModelBody(1, 4);
		SetModelBody(2, 0);
		SetSayTextRange(1024);
	}

	void game_postspawn()
	{
		NPC_DO_EVENTS = param4;
		if (!(param4 != "none")) return;
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

	void set_eating()
	{
		ANIM_ACTION = "eat";
		SetModelBody(2, 9);
	}

	void set_drinking()
	{
		ANIM_ACTION = "drink";
		SetModelBody(2, 11);
		SetModelBody(0, 2);
		SetModelBody(1, 0);
	}

}

}
