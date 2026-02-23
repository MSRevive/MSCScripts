#pragma context server

#include "monsters/base_npc_vendor.as"

namespace MS
{

class Ron : CGameScript
{
	string ANIM_DEATH;
	int MENU_OPEN;
	int NO_SPAWN_STUCK_CHECK;
	int NPC_NO_PLAYER_DMG;
	int SAY_SO;
	int SET_DESTINATION;
	string STORE_NAME;
	string STORE_TRIGGERTEXT;
	string TRIGGER_OUT;
	int VENDOR_NOT_ON_USE;

	Ron()
	{
		const string SOUND_DEATH = "none";
		ANIM_DEATH = "diesimple";
		STORE_NAME = "rons_shop";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		SAY_SO = 0;
		const int NO_JOB = 1;
		const int NO_RUMOR = 1;
		NO_SPAWN_STUCK_CHECK = 1;
		VENDOR_NOT_ON_USE = 1;
		NPC_NO_PLAYER_DMG = 1;
	}

	void OnSpawn() override
	{
		SetHealth(100);
		SetName("Captain Ron");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetModelBody(1, 1);
		SetNoPush(true);
		SetDamageResistance("holy", 0);
		CatchSpeech("say_hi", "hi");
		SetMenuAutoOpen(1);
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "health_apple", 15, 100);
		AddStoreItem(STORE_NAME, "health_mpotion", 20, 100, 0);
		AddStoreItem(STORE_NAME, "mana_mpotion", 20, 100, 0);
		AddStoreItem(STORE_NAME, "drink_mead", 20, 100);
		AddStoreItem(STORE_NAME, "drink_ale", 20, 100);
		AddStoreItem(STORE_NAME, "drink_wine", 20, 100);
	}

	void say_hi()
	{
		if ((SET_DESTINATION)) return;
		if ((MENU_OPEN)) return;
		OpenMenu(GetEntityIndex("ent_lastspoke"));
	}

	void game_menu_getoptions()
	{
		MENU_OPEN = 1;
		if (!(SET_DESTINATION))
		{
			PlayAnim("once", "converse1");
			if (!(GAVE_INTRO))
			{
				SayText("Ahoy there! Welcome to Captain Ron's pleasure cruise slash high seas adventure! Where be ye travelin' lad?");
				GAVE_INTRO = 1;
			}
			string reg.mitem.title = "To Deralia";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "set_sail";
			string reg.mitem.data = "deralia";
			string reg.mitem.title = "To Port Ara";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "set_sail";
			string reg.mitem.data = "ara";
			string reg.mitem.title = "To The Isles of Dread";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "set_sail";
			string reg.mitem.data = "isles";
			string reg.mitem.title = "To The Tundra";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "set_sail";
			string reg.mitem.data = "tundra";
		}
	}

	void set_sail()
	{
		if ((SET_DESTINATION)) return;
		SET_DESTINATION = 1;
		VENDOR_NOT_ON_USE = 0;
		TRIGGER_OUT = param2;
		TRIGGER_OUT += "_start";
		PlayAnim("once", "converse2");
		if (param2 == "deralia")
		{
			SayText("Ah yes, Deralia, jewel of Daragoth, ne're a safer port there be. Off we go!");
		}
		if (param2 == "ara")
		{
			SayText("Hmm... I think I saw some orcs rowin' towards Ara. Don't be too surprised if we catch up with 'em.");
		}
		if (param2 == "isles")
		{
			SayText("Isles of Dread? I'd charge extra for that, were I not already on the King's commission.");
		}
		if (param2 == "tundra")
		{
			SayText("Brrrr... cold up there. Alright - just mind the orca when you step off!");
		}
		Effect("screenfade", "all", 4, 10, Vector3(1, 1, 1), 255, "fadeout");
		ScheduleDelayedEvent(10, "delay_sailing");
	}

	void delay_sailing()
	{
		Effect("screenfade", "all", 4, 0, Vector3(1, 1, 1), 255, "fadein");
		UseTrigger(TRIGGER_OUT);
	}

	void game_menu_cancel()
	{
		SetMenuAutoOpen(1);
		MENU_OPEN = 0;
	}

	void OnDamage(int damage) override
	{
		if ((IsValidPlayer(param1)))
		{
			SetDamage("dmg");
			SetDamage("hit");
			return;
		}
	}

}

}
