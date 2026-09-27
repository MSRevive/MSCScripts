#pragma context server

namespace MS
{

class SorcJuggerPatrol : CGameScript
{
	string CUR_SPEAKER;
	string NPC_DO_EVENTS;

	void OnSpawn() override
	{
		SetName("Shadahar Brawler");
		SetModel("monsters/sorc_big.mdl");
		SetHealth(5000);
		SetDamageResistance("all", 0.5);
		SetStat("parry", 110);
		SetWidth(48);
		SetHeight(128);
		SetNoPush(true);
		SetRoam(true);
		SetRace("beloved");
		SetInvincible(true);
		SetStepSize(1);
		SetMoveAnim("walk");
		SetIdleAnim("idle1");
		SetModelBody(0, 0);
		SetModelBody(1, 1);
		SetModelBody(2, 0);
		CatchSpeech("say_hi", "hail");
		SetMenuAutoOpen(1);
	}

	void game_menu_getoptions()
	{
		string reg.mitem.title = "Hail";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_hi";
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

	void say_hi()
	{
		if ((IsEntityAlive(param1)))
		{
			SetMoveDest(param1);
			CUR_SPEAKER = param1;
		}
		else
		{
			if ((IsEntityAlive("ent_lastspoke")))
			{
			}
			SetMoveDest("ent_lastspoke");
		}
		SayText("Ungg... Humans is guests... Jugga no kills.");
	}

}

}
