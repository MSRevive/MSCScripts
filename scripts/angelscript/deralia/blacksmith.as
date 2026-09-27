#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"
#include "monsters/base_xmass.as"

namespace MS
{

class Blacksmith : CGameScript
{
	int ATTACK1_DAMAGE;
	int ATTACK_PERCENTAGE;
	int ATTACK_RANGE;
	int CANCHAT;
	int CHATTING_PLAYER;
	string CHECK_PLAYER;
	string CURRENT_THIEF;
	string GAXE_TARGET;
	int NO_JOB;
	int OFFER_SET;
	int SELL_WEAPON_LEVEL;
	string STORE_NAME;
	int STORE_SELLMENU;
	string STORE_TRIGGERTEXT;
	int VEND_ARMORER;
	int VEND_CONTAINERS;
	int VEND_NEWBIE;
	int VEND_WEAPONS;

	Blacksmith()
	{
		STORE_NAME = "deralia_merchant_2";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		STORE_SELLMENU = 1;
		NO_JOB = 1;
		SELL_WEAPON_LEVEL = 3;
		VEND_NEWBIE = 1;
		VEND_WEAPONS = 1;
		VEND_CONTAINERS = 1;
		VEND_ARMORER = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(25);
		if (!(CHATTING_PLAYER))
		{
		}
		CanSee("player");
		PlayAnim("once", "wave");
		SayText("The finest weapons in all the land!");
	}

	void OnSpawn() override
	{
		SetHealth(25);
		SetMaxHealth(25);
		SetGold(50);
		SetName("Thordac the Blacksmith");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/blacksmith.mdl");
		SetInvincible(true);
		CANCHAT = 1;
		ATTACK_RANGE = 90;
		ATTACK1_DAMAGE = 5;
		ATTACK_PERCENTAGE = 60;
		CURRENT_THIEF = �PNULL�P;
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_rumour", "rumour");
		resetchat();
	}

	void say_rumor()
	{
		say_rumour();
	}

	void say_hi()
	{
		SayText("Welcome to Deralia s smithy. I have many items, some that might interest you.");
		ScheduleDelayedEvent(3, "say_store");
	}

	void say_store()
	{
		CHECK_PLAYER = "ent_lastspoke";
		offer_notthief();
		offer_isthief();
	}

	void trade_done()
	{
		SayText("Please , do come again some time. Might have something more interesting for you then.");
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "armor_helm_knight", 3, 110);
		AddStoreItem(STORE_NAME, "armor_knight", 2, 110);
		AddStoreItem(STORE_NAME, "smallarms_rknife", 0, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_knife", 3, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_dagger", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_rsword", 0, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_shortsword", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_scimitar", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_nkatana", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_longsword", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_bastardsword", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_rsmallaxe", 0, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_smallaxe", 3, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_axe", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_2haxe", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_battleaxe", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_club", 1, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_hammer2", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_mace", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_warhammer", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_hammer3", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_maul", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "polearms_qs", RandomInt(0, 1), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "polearms_sp", RandomInt(0, 1), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "polearms_tri", RandomInt(0, 1), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "sheath_back_holster", 5, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_gauntlets_leather", 1, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_craftedknife", RandomInt(1, 2), 175);
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORE_NAME, "blunt_greatmaul", 1, 120);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORE_NAME, "axes_scythe", 4, 120);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORE_NAME, "blunt_granitemace", 1, 500, 0);
		}
		AddStoreItem(STORE_NAME, "crest_deralia", 1, 100, 0);
	}

	void say_rumour()
	{
		PlayAnim("once", "pondering2");
		SayText("Ummm ... someone mentioned seeing the beacon blink. But that could never happen.");
	}

	void game_menu_getoptions()
	{
		LogDebug("game_menu_getoptions GetEntityName(param1) ax ItemExists(param1, "axes_golden") let ItemExists(param1, "item_roland_letter")");
		if ((ItemExists(param1, "axes_golden")))
		{
			if (!(OFFER_SET))
			{
			}
			if ((ItemExists(param1, "item_roland_letter")))
			{
			}
			string reg.mitem.title = "Show Rolands Letter";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "say_letter";
			string reg.mitem.callback = "say_letter";
		}
		if ((OFFER_SET))
		{
			if ((ItemExists(param1, "axes_golden")))
			{
			}
			string reg.mitem.title = "Pay 100,000 Gold";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "gold:100000;axes_golden;item_roland_letter";
			string reg.mitem.callback = "make_gaxe";
			string reg.mitem.cb_failed = "say_letter6";
		}
	}

	void say_letter()
	{
		if (param1 == "PARAM1")
		{
			string SPEAKER_ID = GetEntityIndex("ent_lastspoke");
			if (!(ItemExists(SPEAKER_ID, "item_roland_letter")))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		CHATTING_PLAYER = 1;
		SayText("Hmm... Wow , he wants me to attach a theulian spine to this thing!?");
		SetIdleAnim("keypad");
		PlayAnim("once", "keypad");
		ScheduleDelayedEvent(4.0, "say_letter2");
	}

	void say_letter2()
	{
		SayText("Hmmm... " + I + " have one , but these things are so damned rare. It ll cost you about...");
		SetIdleAnim("pondering");
		PlayAnim("once", "pondering");
		ScheduleDelayedEvent(4.0, "say_letter3");
	}

	void say_letter3()
	{
		SayText("100 , 000 gold.");
		OFFER_SET = 1;
		ScheduleDelayedEvent(4.0, "say_letter4");
	}

	void say_letter4()
	{
		SetIdleAnim("pondering");
		PlayAnim("once", "pondering");
		SayText("He sent you to me , because he knows " + I + " m the only one around who makes these...");
		ScheduleDelayedEvent(4.0, "say_letter5");
	}

	void say_letter5()
	{
		SayText("They take me about five years a piece to make , so " + I + " don t install them cheap!");
		ScheduleDelayedEvent(4.0, "say_letter6");
	}

	void say_letter6()
	{
		SayText("100 , 000 gold. Take it or leave it.");
		CHATTING_PLAYER = 0;
		ScheduleDelayedEvent(2.0, "resume_idle");
	}

	void make_gaxe()
	{
		CHATTING_PLAYER = 1;
		GAXE_TARGET = param1;
		SayText("Wow , rich boy. *cough* Okay... Here we go.");
		SetModelBody(0, 1);
		SetModelBody(1, 1);
		SetIdleAnim("smith_hammer_time");
		PlayAnim("once", "smith_hammer_time");
		ScheduleDelayedEvent(1.0, "smith_noise");
		ScheduleDelayedEvent(2.0, "smith_noise");
		ScheduleDelayedEvent(3.0, "smith_noise");
		ScheduleDelayedEvent(4.0, "smith_noise");
		ScheduleDelayedEvent(5.0, "smith_noise");
		ScheduleDelayedEvent(6.0, "smith_noise");
		ScheduleDelayedEvent(7.0, "make_gaxe2");
	}

	void make_gaxe2()
	{
		SetIdleAnim("smith_hammer_idle");
		PlayAnim("once", "smith_hammer_idle");
		SayText("Alright...");
		ScheduleDelayedEvent(2.0, "make_gaxe3");
	}

	void make_gaxe3()
	{
		// TODO: offer GAXE_TARGET axes_golden_ref
		SetModelBody(0, 0);
		SetModelBody(1, 0);
		SetIdleAnim("dryhands");
		PlayAnim("once", "dryhands");
		SayText("There. That thing will never break again , guaranteed.");
		CHATTING_PLAYER = 0;
		ScheduleDelayedEvent(3.0, "resume_idle");
	}

	void resume_idle()
	{
		SetIdleAnim("idle1");
		PlayAnim("once", "idle1");
	}

	void smith_noise()
	{
		// PlayRandomSound from: "debris/metal3.wav", "debris/metal2.wav", "debris/metal1.wav"
		array<string> sounds = {"debris/metal3.wav", "debris/metal2.wav", "debris/metal1.wav"};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

}

}
