#pragma context server

#include "monsters/base_npc_vendor.as"

namespace MS
{

class DrWho1 : CGameScript
{
	string ANIM_STEP2;
	string ANIM_STEP3;
	int BUSY_CHATTING;
	int CHAT_STEP;
	string CHAT_STEP1;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEP4;
	int CHAT_STEPS;
	int DID_INTRO;
	int DOING_VOTE;
	int NO_HAIL;
	int NO_TALKIE;
	int STORE_CLOSED;
	string STORE_NAME;
	int TALLY_NO_VOTES;
	int TALLY_VOTES;
	int TALLY_YES_VOTES;
	int VENDOR_MENU_OFF;
	int VENDOR_NOT_ON_USE;

	DrWho1()
	{
		const int NO_JOB = 1;
		const int NO_RUMOR = 1;
		const float CHAT_DELAY = 4.0;
		STORE_NAME = "tom_bakers_shop";
		const int VEND_INDIVIDUAL = 1;
		VENDOR_NOT_ON_USE = 1;
	}

	void OnSpawn() override
	{
		SetName("Torwhodoc Sa thraz, Keeper of Time");
		SetHealth(1);
		SetInvincible(true);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/balancepriest2.mdl");
		SetWidth(32);
		SetHeight(72);
		SetIdleAnim("idle1");
		SetSayTextRange(512);
		CatchSpeech("say_hi", "hail");
		CatchSpeech("start_helena_vote", "helena");
		SetMenuAutoOpen(1);
		ScheduleDelayedEvent(1.0, "scan_for_ally");
	}

	void scan_for_ally()
	{
		if ((DID_INTRO)) return;
		ScheduleDelayedEvent(2.0, "scan_for_ally");
		if (!(false)) return;
		if (!(GetEntityRange(m_hLastSeen) < 512)) return;
		DID_INTRO = 1;
		say_hi();
	}

	void say_hi()
	{
		if ((BUSY_CHATTING)) return;
		CHAT_STEPS = 4;
		CHAT_STEP = 0;
		BUSY_CHATTING = 1;
		CHAT_STEP1 = "Excellent work! Gave those orcs what for, you did! Just like last time!";
		CHAT_STEP2 = "...although, not like that one other time, but, that's no longer an issue, I suppose.";
		ANIM_STEP2 = "lean";
		CHAT_STEP3 = "In anycase, I've those items I told you about, for that fee I told you about. Feel free to pick!";
		CHAT_STEP4 = "When you're ready to go back to the fut... [Helena], just say so.";
		chat_loop();
	}

	void game_menu_getoptions()
	{
		if ((NO_TALKIE)) return;
		if (!(DOING_VOTE))
		{
			string reg.mitem.title = "Return to the Future";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "start_helena_vote";
		}
		if ((DOING_VOTE))
		{
			string reg.mitem.title = "VOTE: Return to the Future?";
			string reg.mitem.type = "disabled";
			string reg.mitem.title = "Yes!";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "wtf_vote_yes";
			string reg.mitem.title = "No!";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "wtf_vote_no";
		}
	}

	void payment_failed()
	{
		PlayAnim("critical", "no");
		SayText("Come now , the last of the time wizards deserves better food than that will buy.");
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "mana_forget", 2, 100, 0.0);
		AddStoreItem(STORE_NAME, "mana_speed", 1, 100, 0.0);
		AddStoreItem(STORE_NAME, "mana_gprotection", 1, 100, 0.0);
		AddStoreItem(STORE_NAME, "mana_protection", 1, 100, 0.0);
		AddStoreItem(STORE_NAME, "mana_resist_cold", 1, 100, 0.0);
		AddStoreItem(STORE_NAME, "mana_immune_cold", 1, 100, 0.0);
		AddStoreItem(STORE_NAME, "mana_resist_fire", 1, 100, 0.0);
		AddStoreItem(STORE_NAME, "mana_immune_fire", 1, 100, 0.0);
		AddStoreItem(STORE_NAME, "mana_immune_poison", 1, 100, 0.0);
		AddStoreItem(STORE_NAME, "mana_demon_blood", 1, 100, 0.0);
		AddStoreItem(STORE_NAME, "mana_vampire", 1, 100, 0.0);
		AddStoreItem(STORE_NAME, "mana_prot_spiders", 1, 100, 0.0);
	}

	void start_helena_vote()
	{
		NO_HAIL = 1;
		VENDOR_MENU_OFF = 1;
		GetAllPlayers(PLAYER_LIST);
		DOING_VOTE = 1;
		SayText("Just a moment , while we get a consensus amongst our heros.");
		TALLY_VOTES = 0;
		TALLY_YES_VOTES = 0;
		TALLY_NO_VOTES = 0;
		ScheduleDelayedEvent(3.0, "zomg_stupid_error");
	}

	void zomg_stupid_error()
	{
		for (int i = 0; i < GetTokenCount(PLAYER_LIST, ";"); i++)
		{
			wtf_ask_players();
		}
		float WTF_VOTE_DELAY = 10.0;
		if (GetPlayerCount() > 1)
		{
			float WTF_VOTE_DELAY = 20.0;
		}
		WTF_VOTE_DELAY("wtf_count_votes");
	}

	void wtf_ask_players()
	{
		string CUR_PLAYER = GetToken(PLAYER_LIST, i, ";");
		OpenMenu(CUR_PLAYER);
	}

	void wtf_vote_yes()
	{
		LogDebug("GetEntityName(param1) voted yes");
		TALLY_YES_VOTES += 1;
		TALLY_VOTES += 1;
		PlayAnim("critical", "yes");
		SayText("GetEntityName(param1) seems ready to go.");
	}

	void wtf_vote_no()
	{
		LogDebug("GetEntityName(param1) voted no");
		TALLY_NO_VOTES += 1;
		TALLY_VOTES += 1;
		PlayAnim("critical", "no");
		SayText("GetEntityName(param1) seems to still be shopping , or... Looting corpses.");
	}

	void wtf_count_votes()
	{
		if (TALLY_NO_VOTES > 0)
		{
			int WTF_VOTE_FAIL = 1;
		}
		if (TALLY_VOTES == 0)
		{
			int WTF_VOTE_FAIL = 1;
		}
		if (WTF_VOTE_FAIL == 1)
		{
			NO_HAIL = 0;
			VENDOR_MENU_OFF = 0;
			DOING_VOTE = 0;
			CHAT_STEPS = 3;
			CHAT_STEP = 0;
			BUSY_CHATTING = 1;
			CHAT_STEP1 = "Seems some people want to look around before we leave.";
			CHAT_STEP2 = "It's not a problem. The temporal stasus feild prevents you from interfering with events beyond this area.";
			CHAT_STEP3 = "So it's not as if you can get into any real trouble... This time.";
			ANIM_STEP3 = "lean";
			chat_loop();
		}
		if (!(WTF_VOTE_FAIL == 0)) return;
		STORE_CLOSED = 1;
		NO_HAIL = 1;
		VENDOR_MENU_OFF = 1;
		SetSayTextRange(9999);
		CHAT_STEPS = 3;
		CHAT_STEP = 0;
		BUSY_CHATTING = 1;
		CHAT_STEP1 = "Alright, get into the blue box and hold onto your hats! We're going home!";
		CHAT_STEP2 = "It's an old type 40 I just borrowed... Give it a bit to warm up.";
		CHAT_STEP3 = "Kick that flux capacitor over there and we'll be on our way.";
		chat_loop();
		PlayAnim("critical", "studycart");
		NO_TALKIE = 1;
		UseTrigger("engine_tardis");
		ScheduleDelayedEvent(4.0, "amx_mapchange");
		ScheduleDelayedEvent(10.0, "manual_mapchange");
	}

	void amx_mapchange()
	{
		UseTrigger("force_map_helena");
	}

	void manual_mapchange()
	{
		CallExternal(GAME_MASTER, "gm_manual_map_change", "helena");
	}

}

}
