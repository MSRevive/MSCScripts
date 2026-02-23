#pragma context server

#include "monsters/base_chat_array.as"

namespace MS
{

class Kayle : CGameScript
{
	int CANCHAT;
	int CHAT_MENU_ON;
	int MENU_MODE;
	string MENU_TO;

	Kayle()
	{
		const int CHAT_AUTO_HAIL = 1;
		const int CHAT_AUTO_RUMOR = 1;
		const int CHAT_NEVER_INTERRUPT = 1;
		const int SEE_RANGE = 200;
		MENU_MODE = 0;
	}

	void OnSpawn() override
	{
		SetHealth(1);
		SetWidth(32);
		SetHeight(64);
		SetRace("human");
		SetSkillLevel(0);
		SetName("Kayle");
		SetRoam(false);
		SetModel("npc/human2.mdl");
		SetInvincible(true);
		CANCHAT = 1;
		CHAT_MENU_ON = 0;
		CatchSpeech("say_help", "help");
		CatchSpeech("say_kayle", "kayle");
		CatchSpeech("say_deralia", "deralia");
		CatchSpeech("say_edana", "edana");
		CatchSpeech("say_gatecity", "gatecity");
		CatchSpeech("say_helena", "helena");
		ScheduleDelayedEvent(0.1, "add_dialogue");
	}

	void add_dialogue()
	{
		chat_add_text("seq_hi", "Hey.", 3.0);
		chat_add_text("seq_hi", "My names Kayle.", 1.0);
		chat_add_text("seq_rumor", "Nothing much, besides the fact that they won't let us into to uptown Deralia.", 3.0);
		chat_add_text("seq_rumor", "Don't really get why, not everyone wants to hang around with smelly ship mates.", 3.0);
		chat_add_text("seq_help", "You talking to me?", 5.0);
		chat_add_text("seq_help", "...", 1.0);
		chat_add_text("seq_kayle", "Huh? You beckoned?", 2.0);
		chat_add_text("seq_edana", "Edana huh, that's pretty far off.", 2.0);
		chat_add_text("seq_edana", "Sembelbin seemed interested in an Urdual Title Ring last time I was there.", 3.0);
		chat_add_text("seq_deralia", "I like living in Deralia, its always been my home.", 3.0);
		chat_add_text("seq_gatecity", "Really? You don't look like a dwarf.", 2.0);
		chat_add_text("seq_gatecity", "I don't see any point in going there. It's too much trouble getting around the goblins.", 3.0);
		chat_add_text("seq_helena", "Helena... must've been tough through all those orc attacks.", 2.0);
		chat_add_text("seq_helena", "I've seen old paintings of the heroes who saved Helena from an army of orcs. You have an odd resemblence to one of 'em.", 4.0);
	}

	void say_hi()
	{
		if (param1 != "PARAM1")
		{
			string L_PLAYER = param1;
		}
		else
		{
			string L_PLAYER = GetEntityIndex("ent_lastspoke");
		}
		if (!(CanSee(L_PLAYER, SEE_RANGE))) return;
		chat_start_sequence("seq_hi");
	}

	void say_rumor()
	{
		if (param1 != "PARAM1")
		{
			string L_PLAYER = param1;
		}
		else
		{
			string L_PLAYER = GetEntityIndex("ent_lastspoke");
		}
		if (!(CanSee(L_PLAYER, SEE_RANGE))) return;
		chat_start_sequence("seq_rumor");
	}

	void say_help()
	{
		if (param1 != "PARAM1")
		{
			string L_PLAYER = param1;
		}
		else
		{
			string L_PLAYER = GetEntityIndex("ent_lastspoke");
		}
		if (!(CanSee(L_PLAYER, SEE_RANGE))) return;
		chat_start_sequence("seq_help");
	}

	void say_kayle()
	{
		if (param1 != "PARAM1")
		{
			string L_PLAYER = param1;
		}
		else
		{
			string L_PLAYER = GetEntityIndex("ent_lastspoke");
		}
		if (!(CanSee(L_PLAYER, SEE_RANGE))) return;
		chat_start_sequence("seq_kayle");
	}

	void say_edana()
	{
		if (param1 != "PARAM1")
		{
			string L_PLAYER = param1;
		}
		else
		{
			string L_PLAYER = GetEntityIndex("ent_lastspoke");
		}
		if (!(CanSee(L_PLAYER, SEE_RANGE))) return;
		chat_start_sequence("seq_edana");
	}

	void say_deralia()
	{
		if (param1 != "PARAM1")
		{
			string L_PLAYER = param1;
		}
		else
		{
			string L_PLAYER = GetEntityIndex("ent_lastspoke");
		}
		if (!(CanSee(L_PLAYER, SEE_RANGE))) return;
		chat_start_sequence("seq_deralia");
	}

	void say_gatecity()
	{
		if (param1 != "PARAM1")
		{
			string L_PLAYER = param1;
		}
		else
		{
			string L_PLAYER = GetEntityIndex("ent_lastspoke");
		}
		if (!(CanSee(L_PLAYER, SEE_RANGE))) return;
		chat_start_sequence("seq_gatecity");
	}

	void say_helena()
	{
		if (param1 != "PARAM1")
		{
			string L_PLAYER = param1;
		}
		else
		{
			string L_PLAYER = GetEntityIndex("ent_lastspoke");
		}
		if (!(CanSee(L_PLAYER, SEE_RANGE))) return;
		chat_start_sequence("seq_helena");
	}

	void game_menu_getoptions()
	{
		if (MENU_MODE == 0)
		{
			string reg.mitem.title = "Hail";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_hi";
			string reg.mitem.title = "Ask about Rumors";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_rumor";
			string reg.mitem.title = "Ask about...";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "menu_switch_towns";
		}
		else
		{
			if (MENU_MODE == 1)
			{
				string reg.mitem.title = "Edana";
				string reg.mitem.type = "callback";
				string reg.mitem.callback = "say_edana";
				string reg.mitem.title = "Deralia";
				string reg.mitem.type = "callback";
				string reg.mitem.callback = "say_deralia";
				string reg.mitem.title = "Gatecity";
				string reg.mitem.type = "callback";
				string reg.mitem.callback = "say_gatecity";
				string reg.mitem.title = "Helena";
				string reg.mitem.type = "callback";
				string reg.mitem.callback = "say_helena";
				MENU_MODE = 0;
			}
		}
	}

	void menu_switch_towns()
	{
		MENU_MODE = 1;
		MENU_TO = param1;
		ScheduleDelayedEvent(0.1, "send_menu");
	}

	void send_menu()
	{
		OpenMenu(MENU_TO);
	}

}

}
