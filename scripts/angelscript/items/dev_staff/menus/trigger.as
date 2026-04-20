#pragma context server

namespace MS
{

class Trigger : CGameScript
{
	int LISTENING_FOR_TRIGGER;
	int MENU_TYPE;
	string RECENT_TRIGGERS;
	string STARTED_LISTENING;
	string TRIG_QUEST;

	Trigger()
	{
		LISTENING_FOR_TRIGGER = 0;
	}

	void menu_trigger()
	{
		LISTENING_FOR_TRIGGER = 1;
		STARTED_LISTENING = GetGameTime();
		ScheduleDelayedEvent(10.0, "stop_listening");
		CallExternal(MY_OWNER, "ext_saytextrange", 10000);
		string reg.mitem.title = "Speak the [trigger]";
		string reg.mitem.type = "disabled";
		TRIG_QUEST = "trig_";
		RECENT_TRIGGERS = GetPlayerQuestData(MY_OWNER, TRIG_QUEST);
		if (RECENT_TRIGGERS == "0")
		{
			RECENT_TRIGGERS = "";
		}
		if (RECENT_TRIGGERS == "")
		{
			return;
		}
		for (int i = 0; i < GetTokenCount(RECENT_TRIGGERS, ";"); i++)
		{
			loop_trigger_history();
		}
	}

	void loop_trigger_history()
	{
		string L_TRIG = GetToken(RECENT_TRIGGERS, i, ";");
		string reg.mitem.title = L_TRIG;
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "use_trigger";
		string reg.mitem.data = L_TRIG;
	}

	void use_trigger()
	{
		UseTrigger(param2);
		LISTENING_FOR_TRIGGER = 0;
		MENU_TYPE = 11;
		ScheduleDelayedEvent(0.1, "ext_menu_open");
		CallExternal(MY_OWNER, "ext_playsound_kiss", 0, 5, "weapons/357_cock1.wav");
	}

	void game_heardtext()
	{
		if (!(LISTENING_FOR_TRIGGER)) return;
		if (!(param2 == MY_OWNER)) return;
		string L_IDX = FindToken(RECENT_TRIGGERS, param1, ";");
		if (L_IDX == -1)
		{
			if (GetTokenCount(RECENT_TRIGGERS, ";") >= 6)
			{
				RemoveToken(RECENT_TRIGGERS, 0, ";");
			}
			if (RECENT_TRIGGERS.length() > 0) RECENT_TRIGGERS += ";";
			RECENT_TRIGGERS += param1;
			SetPlayerQuestData(MY_OWNER, TRIG_QUEST);
		}
		use_trigger(MY_OWNER, param1);
	}

	void stop_listening()
	{
		if (!(STARTED_LISTENING <= (GetGameTime() - 10))) return;
		LISTENING_FOR_TRIGGER = 0;
	}

	void menu_trigger_successful()
	{
		string reg.mitem.title = "Trigger Fired!";
		string reg.mitem.type = "disabled";
	}

}

}
