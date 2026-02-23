#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"

namespace MS
{

class Armorer : CGameScript
{
	int CANCHAT;
	int GAVE_AXE2;
	string GOLD_TARGET;
	int JOB;
	int OFFER_SET;
	string ORE_TARGET;
	int SELL_WEAPON_LEVEL;
	int STORE_CLOSED;
	int VEND_NEWBIE;

	Armorer()
	{
		const string SOUND_DEATH = "none";
		STORE_CLOSED = 0;
		const string STORE_NAME = "gatecity_armory";
		const string STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		const int STORE_SELLMENU = 1;
		const float SELL_RATIO = 0.75;
		const float OVER_CHARGE = 1.5;
		const int NO_RUMOR = 1;
		SELL_WEAPON_LEVEL = 3;
		const int VEND_ARMORER = 1;
		VEND_NEWBIE = 1;
		const int VEND_CONTAINERS = 1;
		const int VEND_WEAPONS = 1;
		const int VEND_SPEC_SHEATHS = 1;
		const int NPC_REACTS = 1;
	}

	void OnSpawn() override
	{
		SetName("Roland");
		SetHealth(25);
		SetGold(25);
		SetName("Roland the Blacksmith");
		SetFOV(30);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("dwarf/male1.mdl");
		SetModelBody(0, 0);
		SetModelBody(1, 2);
		SetInvincible(true);
		JOB = 0;
		CANCHAT = 1;
		STORE_CLOSED = 0;
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_job", "job");
		CatchSpeech("say_rumor", "rumour");
		CatchSpeech("say_axe", "axe");
		CatchSpeech("say_failed_pay", "no");
		createmystore();
	}

	void npcreact_targetsighted()
	{
		if (!(STORE_CLOSED))
		{
			if (GetEntityDist(param1) <= 90)
			{
				SayText("Would you like to [purchase] one of my fine weapons?");
			}
		}
	}

	void say_hi()
	{
		if (!(STORE_CLOSED))
		{
			if (GetEntityDist("ent_lastspoke") <= 90)
			{
				SayText("Would you like [buy] some fine armor or weapons?");
			}
		}
	}

	void say_job()
	{
		SayText("Sorry , but with the Undermountains closed , I have no work to be done.");
	}

	void say_rumor()
	{
		SayText("I hear the mayor is looking for some help.");
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "armor_leather_torn", RandomInt(1, 3), 125, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_leather", RandomInt(1, 3), 125, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_leather_studded", RandomInt(1, 3), 125, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_plate", RandomInt(1, 2), 90, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_helm_plate", RandomInt(1, 2), 90, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_helm_bronze", RandomInt(1, 2), 90, SELL_RATIO);
		mongol_gear();
		knight_gear();
		AddStoreItem(STORE_NAME, "armor_golden", 0, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_helm_golden", 0, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_dark", 0, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_helm_dark", 0, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "sheath_belt_snakeskin", 1, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "sheath_back_snakeskin", 1, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "sheath_dagger_snakeskin", 1, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "sheath_axe_snakeskin", 1, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "sheath_blunt_snakeskin", 1, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "sheath_holster_snakeskin", 1, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "sheath_back_holster", 5, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "shields_buckler", RandomInt(1, 2), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "shields_ironshield", RandomInt(1, 2), 100, 0.25);
		AddStoreItem(STORE_NAME, "shields_lironshield", RandomInt(1, 2), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_rsword", RandomInt(1, 5), 90, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_shortsword", RandomInt(1, 5), 90, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_nkatana", RandomInt(1, 5), 90, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_longsword", RandomInt(1, 5), 90, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_doubleaxe", RandomInt(1, 5), 90, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_gauntlets_leather", RandomInt(1, 2), 90, SELL_RATIO);
		AddStoreItem(STORE_NAME, "sheath_belt_holster", 1, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_knife", 4, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_dagger", 3, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_rknife", 0, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_rsword", 0, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_shortsword", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_scimitar", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_longsword", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_bastardsword", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_rsmallaxe", 0, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_smallaxe", 3, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_axe", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_2haxe", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_battleaxe", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_club", 1, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_hammer1", 0, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_hammer2", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_mace", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_warhammer", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_hammer3", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_maul", 2, 100, SELL_RATIO);
	}

	void mongol_gear()
	{
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORE_NAME, "armor_mongol", 1, 100, SELL_RATIO);
			AddStoreItem(STORE_NAME, "armor_helm_mongol", 1, 100, SELL_RATIO);
		}
	}

	void knight_gear()
	{
		if (RandomInt(1, 25) == 1)
		{
			AddStoreItem(STORE_NAME, "armor_knight", 1, 100, SELL_RATIO);
			AddStoreItem(STORE_NAME, "armor_helm_knight", 1, 100, SELL_RATIO);
		}
	}

	void trade_success()
	{
		if (!(CANCHAT == 1)) return;
		EmitSound(GetOwner(), CHAN_VOICE, "npc/goods.wav", "game.sound.maxvol");
		Say("[.34] [.24] [.35] [.40]");
		CANCHAT = 0;
		ScheduleDelayedEvent(10, "resetchat");
	}

	void resetchat()
	{
		CANCHAT = 1;
	}

	void vendor_say_closed()
	{
		SayText("Sorry, I'm closed. I will reopen at seven in the morning.");
	}

	void game_menu_getoptions()
	{
		if ((OFFER_SET))
		{
			if ((ItemExists(param1, "item_gaxe_handle")))
			{
			}
			string reg.mitem.title = "Pay 10,000 Gold";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "gold:10000;item_gaxe_handle;item_ore_lorel";
			string reg.mitem.callback = "say_gotgold";
			string reg.mitem.cb_failed = "say_failed_pay";
		}
		if ((OFFER_SET)) return;
		if ((ItemExists(param1, "item_gaxe_handle")))
		{
			string reg.mitem.title = "Ask about broken axe";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_axe";
			if ((ItemExists(param1, "item_ore_lorel")))
			{
			}
			string reg.mitem.title = "Show Loreldian Ore";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_ore";
		}
	}

	void say_axe()
	{
		if (param1 == "PARAM1")
		{
			string SPEAKER_ID = GetEntityIndex("ent_lastspoke");
			if (!(ItemExists(SPEAKER_ID, "item_gaxe_handle")))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		SayText("Wow , this here was a real piece of work , before it broke.");
		ScheduleDelayedEvent(4.0, "say_axe2");
	}

	void say_axe2()
	{
		SayText("Don't make them like this anymore, that's fer sure.");
		ScheduleDelayedEvent(4.0, "say_axe3");
	}

	void say_axe3()
	{
		SayText("I can still see the bits of the blade end, I can tell it was made of Loreldian ore.");
		ScheduleDelayedEvent(4.0, "say_axe4");
	}

	void say_axe4()
	{
		SayText("That's where the thing gets its magic, and why it only harms the unholy.");
		ScheduleDelayedEvent(4.0, "say_axe5");
	}

	void say_axe5()
	{
		SayText("Most such cursed things are imbued with the power of The Fallen, either directly, or indirectly.");
		ScheduleDelayedEvent(4.0, "say_axe6");
	}

	void say_axe6()
	{
		SayText("This stuff don't grow on trees, ya know. Even if it did, it's very difficult to work with.");
		ScheduleDelayedEvent(4.0, "say_axe7");
	}

	void say_axe7()
	{
		SayText("But if ya find some, bring it back to me, together with this handle, and maybe I can fix ya up.");
	}

	void say_ore()
	{
		ORE_TARGET = param1;
		SayText("Wow, you actually found some of the stuff! Hmm... Let's see here...");
		ScheduleDelayedEvent(4.0, "say_ore2");
	}

	void say_ore2()
	{
		SayText("Okay, I think I can do this, but it'll cost ya.");
		ScheduleDelayedEvent(4.0, "say_ore3");
	}

	void say_ore3()
	{
		SayText("I'll need 10,000 gold. Plus the hilt, of course.");
		ScheduleDelayedEvent(2.0, "say_ore4");
		OFFER_SET = 1;
	}

	void say_ore4()
	{
		SayText("Just tell me no, if yer not interested.");
	}

	void say_gotgold()
	{
		GOLD_TARGET = param1;
		SayText("Alright , just give me a few moments here.");
		PlayAnim("critical", "attack");
		ScheduleDelayedEvent(1.0, "smith_sound");
		ScheduleDelayedEvent(2.0, "say_gotgold2");
	}

	void say_gotgold2()
	{
		PlayAnim("critical", "attack");
		ScheduleDelayedEvent(1.0, "smith_sound");
		ScheduleDelayedEvent(2.0, "say_gotgold3");
	}

	void say_gotgold3()
	{
		PlayAnim("critical", "attack2");
		ScheduleDelayedEvent(1.0, "smith_sound2");
		ScheduleDelayedEvent(1.0, "say_gotgold4");
	}

	void say_gotgold4()
	{
		SayText("There ya go! Good as new... Sorta...");
		// TODO: offer GOLD_TARGET axes_golden
		GAVE_AXE2 = 1;
		ScheduleDelayedEvent(3.0, "say_gotgold5");
	}

	void say_gotgold5()
	{
		SayText("Now, if you want to make sure it won't break AGAIN, well...");
		ScheduleDelayedEvent(4.0, "say_gotgold6");
	}

	void say_gotgold6()
	{
		SayText("To be honest, you'd need a better smith than I. But I happen to know one- Thordac!");
		ScheduleDelayedEvent(4.0, "say_gotgold7");
	}

	void say_gotgold7()
	{
		SayText("Go over to Deralia, give him yer axe and my instructions here, telling him what ya need.");
		// TODO: offer GOLD_TARGET item_roland_letter
		ScheduleDelayedEvent(4.0, "say_gotgold8");
	}

	void say_gotgold8()
	{
		SayText("I warn ye though, he'll charge you up the nose for what you'll need done!");
	}

	void say_failed_pay()
	{
		if (!(OFFER_SET)) return;
		if ((GAVE_AXE2)) return;
		OFFER_SET = 0;
		SayText("Well, if ya ain't got the money now, I can wait.");
	}

	void smith_sound()
	{
		// PlayRandomSound from: "debris/metal3.wav", "debris/metal2.wav", "debris/metal1.wav"
		array<string> sounds = {"debris/metal3.wav", "debris/metal2.wav", "debris/metal1.wav"};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void smith_sound2()
	{
		EmitSound(GetOwner(), 0, "debris/bustmetal2.wav", 10);
	}

}

}
