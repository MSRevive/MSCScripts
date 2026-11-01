#pragma context server

namespace MS
{

class SorcIdle : CGameScript
{
	string ANIM_ACHE;
	string ANIM_DRINK;
	string ANIM_EAT;
	string ANIM_RECLINE_IDLE;
	string ANIM_SIT_IDLE;
	string ANIM_WAVE;
	string NPC_DO_EVENTS;
	string SORC_TYPE;

	SorcIdle()
	{
		ANIM_RECLINE_IDLE = "on_chair2";
		ANIM_SIT_IDLE = "on_chair";
		ANIM_DRINK = "drink";
		ANIM_EAT = "eat";
		ANIM_ACHE = "sit_ground";
		ANIM_WAVE = "waving";
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
		SetIdleAnim("idle1");
		SetMoveAnim("idle1");
		PlayAnim("once", "idle1");
		SetModelBody(0, 0);
		SetModelBody(1, 4);
		SetModelBody(2, 0);
		CatchSpeech("say_hi", "hail");
		SetMenuAutoOpen(1);
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

	void set_recline1()
	{
		SORC_TYPE = "recline1";
		SetModelBody(0, 0);
		SetModelBody(1, 4);
		SetModelBody(2, 0);
		SetIdleAnim("on_chair2");
		SetMoveAnim("on_chair2");
		PlayAnim("once", "on_chair2");
	}

	void game_menu_getoptions()
	{
		string reg.mitem.title = "Hail";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_hi";
	}

	void say_hi()
	{
		if (SORC_TYPE == "recline1")
		{
			PlayAnim("critical", "on_chair2");
			SayText("Oh, it's Runegahr's 'guests'. Don't mind meez, I is just sunnings.");
		}
	}

}

}
