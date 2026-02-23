#pragma context server

#include "old_helena/base_old_helena_npc.as"
#include "monsters/base_npc.as"
#include "monsters/base_npc_vendor.as"

namespace MS
{

class Harry : CGameScript
{
	string ANIM_DEATH;
	int SAY_SO;
	string STORE_NAME;
	string STORE_TRIGGERTEXT;

	Harry()
	{
		const string SOUND_DEATH = "none";
		ANIM_DEATH = "diesimple";
		STORE_NAME = "harrys_inn";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		SAY_SO = 0;
		const int NO_JOB = 1;
		const int NO_RUMOR = 1;
		const Vector3 MY_RAID_POS = Vector3(-592, 383, 36);
	}

	void OnSpawn() override
	{
		SetHealth(800);
		SetName("Harry");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetModelBody(1, 1);
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_quiet", "quiet");
		CatchSpeech("say_orcs", "orcs");
		CatchSpeech("say_dorfgan", "dorfgan");
		CatchSpeech("say_erkold", "erkold");
		CatchSpeech("say_serrold", "serrold");
		CatchSpeech("say_inn", "inn");
		CatchSpeech("say_thanks", "ok");
	}

	void say_hi()
	{
		PlayAnim("once", "pondering3");
		SayText("Greetings to you adventurer!");
		ScheduleDelayedEvent(3, "say_hi2test");
	}

	void say_hi2test()
	{
		if (!(SAY_SO == 0)) return;
		SayText("I am Harry , your humble innkeeper.");
		setsayso();
	}

	void satsayso()
	{
		SAY_SO = 1;
	}

	void say_orcs()
	{
		SayText("They disappear after 10 drinks!");
	}

	void say_dorfgan()
	{
		PlayAnim("once", "yes");
		SayText("Nice guy , he keeps order when my customers get a little fuzzy");
	}

	void say_erkold()
	{
		PlayAnim("once", "yes");
		SayText("Poor man.. Lost everything...");
	}

	void say_serrold()
	{
		SayText("Serrold? He was our village leader...until the attacks.");
		ScheduleDelayedEvent(3, "say_serrold2");
	}

	void say_serrold2()
	{
		SayText("He wasn t paying attention and an arrow ran him through...");
	}

	void say_inn()
	{
		SayText("Yes , I own the inn over there. It s free to anyone passing through, but donations are welcome.");
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

	void old_helena_warboss_died()
	{
		AddStoreItem(STORE_NAME, "mana_regen", 2, 100, 0);
		AddStoreItem(STORE_NAME, "item_light_crystal", "game.playersnb", 100, 0);
		AddStoreItem(STORE_NAME, "mana_leadfoot", 4, 100, 0);
	}

	void basevendor_offerstore()
	{
		if (!(HELENA_SAVED)) return;
		SayText("For you , I ll break out the rare stock! I almost never sell this stuff.");
		PlayAnim("critical", "lean");
		bchat_mouth_move();
	}

}

}
