#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"
#include "old_helena/base_old_helena_npc.as"

namespace MS
{

class Dorfgan : CGameScript
{
	int ATTACK1_DAMAGE;
	int ATTACK_RANGE;
	int CANCHAT;
	int CAN_RUN;
	int CAN_SCREAM;
	string CHAT_STEP1;
	string CHAT_STEP2;
	int CHAT_STEPS;
	string CUR_PLAYER;
	int DID_CATA_COMMENT;
	int EXPLAINING_QUEST;
	int FIXING_DAGGER;
	int HELENA_SAVED;
	int MENTIONED_DAGGER;
	string NPCATK_TARGET;
	int OFFER_ITEMS;
	int QUEST_1;
	int QUEST_2;
	string REPAIR_QUEST_WINNER;
	int REPAIR_STEP;
	int SAY_SO;
	int SEE_ENEMY;
	string SOUND_PAIN;
	string SOUND_PAIN2;

	Dorfgan()
	{
		ATTACK_RANGE = 64;
		const string ANIM_ATTACK = "beatdoor";
		const string STORE_NAME = "dorfgans_blacksmith";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(1.5);
		string TARGETS_NEAR = FindEntitiesInSphere("enemy", 128);
		if (TARGETS_NEAR >= 1)
		{
			PlayAnim("once", ANIM_ATTACK);
			DoDamage(GetToken(TARGETS_NEAR, 0, ";"), ATTACK_RANGE, 20.0, 0.9, "blunt");
		}
	}

	void OnSpawn() override
	{
		SetHealth(1200);
		SetGold(25);
		SetName("Dorfgan");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/blacksmith.mdl");
		SOUND_PAIN = "player/chesthit1.wav";
		SOUND_PAIN2 = "player/armhit1.wav";
		ATTACK1_DAMAGE = 3;
		ATTACK_RANGE = 90;
		SAY_SO = 0;
		EXPLAINING_QUEST = 0;
		QUEST_1 = 0;
		QUEST_2 = 0;
		OFFER_ITEMS = 1;
		CANCHAT = 1;
		CAN_SCREAM = 1;
		CAN_RUN = 1;
		SEE_ENEMY = 0;
		createmystore();
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_hi", "hello");
		CatchSpeech("say_hi", "hail");
		CatchSpeech("say_hi", "greet");
		CatchSpeech("say_quest", "attack");
		CatchSpeech("say_quest", "orc");
		CatchSpeech("say_dagger", "dagger");
		NPCATK_TARGET = "unset";
		SetMenuAutoOpen(1);
		ScheduleDelayedEvent(260.0, "add_moar_stuff");
	}

	void say_hi()
	{
		SayText("Adventurer! We're under [attack]!");
		ScheduleDelayedEvent(3, "say_hi2test");
	}

	void say_hi2test()
	{
		if (!(SAY_SO == 0)) return;
		SayText("I'm Dorfgan, the blacksmith.");
		setsayso();
	}

	void setsayso()
	{
		SAY_SO = 1;
	}

	void say_quest()
	{
		if (!(EXPLAINING_QUEST == 0)) return;
		SayText("Our village is being ransacked by those blasted Orcs!");
		EXPLAINING_QUEST = 1;
		ScheduleDelayedEvent(2, "say_quest_2");
	}

	void struck()
	{
		SetVolume(10);
		// PlayRandomSound from: SOUND_PAIN, SOUND_PAIN2
		array<string> sounds = {SOUND_PAIN, SOUND_PAIN2};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		PlayAnim("once", "raflinch");
		flee();
	}

	void resetoffer()
	{
		OFFER_ITEMS = 1;
	}

	void playerused()
	{
		if ((HELENA_SAVED))
		{
			SayText("I've also an item or two for exclusive sale to our brave saviors here.");
		}
		if (!(OFFER_ITEMS == 1)) return;
		// TODO: offerstore STORE_NAME buysell trade
	}

	void trade_success()
	{
		if (!(CANCHAT == 1)) return;
		SayText("We're low on supplies, so I don't have much to offer...");
		CANCHAT = 0;
		ScheduleDelayedEvent(10, "resetchat");
	}

	void resetchat()
	{
		CANCHAT = 1;
	}

	void vendor_addstoreitems()
	{
		// TODO: createstore STORE_NAME
		AddStoreItem(STORE_NAME, "swords_shortsword", 1, 100);
		AddStoreItem(STORE_NAME, "swords_bastardsword", 1, 100);
		AddStoreItem(STORE_NAME, "axes_doubleaxe", 2, 100);
		AddStoreItem(STORE_NAME, "shields_ironshield", 2, 100);
		AddStoreItem(STORE_NAME, "shields_lironshield", 2, 100);
		AddStoreItem(STORE_NAME, "proj_bolt_wooden", 100, 100, 0, 25);
		AddStoreItem(STORE_NAME, "proj_bolt_fire", 100, 100, 0, 25);
		AddStoreItem(STORE_NAME, "proj_bolt_iron", 100, 100, 0, 25);
		AddStoreItem(STORE_NAME, "proj_bolt_steel", 75, 800, 0, 25);
		AddStoreItem(STORE_NAME, "proj_bolt_silver", 25, 800, 0, 25);
		addrandomitems();
	}

	void addrandomitems()
	{
		if (!(RandomInt(1, 2) == 1)) return;
		AddStoreItem(STORE_NAME, "swords_longsword", 1, 200);
	}

	void addrandomitems()
	{
		if (!(RandomInt(1, 2) == 1)) return;
		AddStoreItem(STORE_NAME, "swords_scimitar", 1, 100);
	}

	void addrandomitems()
	{
		if (!(RandomInt(1, 2) == 1)) return;
		AddStoreItem(STORE_NAME, "axes_battleaxe", 1, 200);
	}

	void old_helena_warboss_died()
	{
		HELENA_SAVED = 1;
		AddStoreItem(STORE_NAME, "blunt_northmaul972", 1, 200, 0);
		AddStoreItem(STORE_NAME, "bows_crossbow_heavy33", 1, 100, 0);
	}

	void basevendor_offerstore()
	{
		if (!(HELENA_SAVED)) return;
		SayText("I've got a few unusual items just for those who rescued Helena.");
		bchat_mouth_move();
	}

	void catapults_fire()
	{
		if ((DID_CATA_COMMENT)) return;
		CATAPULT_COMMENT += 1;
		if (!(CATAPULT_COMMENT > 3)) return;
		SayText("Catapults!? May the gods save us! They've brought catapults!");
		DID_CATA_COMMENT = 1;
	}

	void say_dagger()
	{
		if (!(ItemExists(param1, "smallarms_rd"))) return;
		if (!(HELENA_SAVED))
		{
			SayText("Is now really the time to talk about this? We're under attack!");
		}
		if (!(HELENA_SAVED)) return;
		if ((FIXING_DAGGER)) return;
		CUR_PLAYER = param1;
		SayText("I always hate to see adventurers who can't properly take care of their equipment.");
		ScheduleDelayedEvent(1.0, "say_dagger2");
	}

	void say_dagger2()
	{
		SayText("I can fix that up for you, for a nominal fee, of course.");
		OpenMenu(CUR_PLAYER);
	}

	void not_enough_repair_dagger()
	{
		SayText("You travellers have to learn somehow.");
	}

	void start_repair_dagger()
	{
		REPAIR_QUEST_WINNER = param1;
		FIXING_DAGGER = 1;
		REPAIR_STEP = 0;
		repair_dagger();
	}

	void repair_dagger()
	{
		REPAIR_STEP += 1;
		if (REPAIR_STEP == 1)
		{
			PlayAnim("once", "portal");
			SayText("This'll be no trouble at all.");
		}
		if (REPAIR_STEP == 2)
		{
			PlayAnim("once", "panic");
			SayText("*Crunch* Ow!");
		}
		if (REPAIR_STEP == 3)
		{
			PlayAnim("once", "push_button");
			SayText("Sorry, I broke your dagger. Strange thing is, I think it cut me AFTER it shattered...");
			// TODO: offer REPAIR_QUEST_WINNER smallarms_eth
			FIXING_DAGGER = 0;
		}
		if (!(REPAIR_STEP < 3)) return;
		ScheduleDelayedEvent(2.0, "repair_dagger");
	}

	void OnUse(CBaseEntity@ activator, CBaseEntity@ caller, int useType) override
	{
		if (!(HELENA_SAVED)) return;
		if (!(ItemExists(param1, "smallarms_rd"))) return;
		CHAT_STEP1 = "Hey, that's a mighty interesting looking hunk of rust you have there.";
		CHAT_STEP2 = "I might be able to clean it up into something even more interesting, for a price.";
		CHAT_STEPS = 2;
		chat_loop();
		MENTIONED_DAGGER = 1;
	}

	void game_menu_getoptions()
	{
		if (!(HELENA_SAVED)) return;
		if ((ItemExists(param1, "smallarms_rd")))
		{
			string reg.mitem.title = "Repair rusted dagger (10,000 gold)";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "smallarms_rd;gold:10000";
			string reg.mitem.callback = "start_repair_dagger";
			string reg.mitem.cb_failed = "not_enough_repair_dagger";
		}
	}

}

}
