#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"
#include "helena/helena_npc.as"

namespace MS
{

class Fletcher : CGameScript
{
	string ANIM_CHAT;
	string ANIM_NO;
	string ANIM_YES;
	string ARROW_AMT;
	int CANCHAT;
	string HELENA_MODE;
	int NO_HAIL;
	int NO_JOB;
	int NO_RUMOR;
	string SOUND_DEATH;
	string STORE_NAME;
	int STORE_SELLMENU;
	string STORE_TRIGGERTEXT;
	string THIS_MAP;
	int VEND_CONTAINERS;
	int VEND_NEWBIE;
	int VEND_WEAPONS;

	Fletcher()
	{
		SOUND_DEATH = "none";
		STORE_NAME = "edana_fletcher";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		STORE_SELLMENU = 1;
		NO_HAIL = 1;
		ANIM_CHAT = "pondering";
		ANIM_YES = "yes";
		ANIM_NO = "no";
		VEND_NEWBIE = 1;
		VEND_WEAPONS = 1;
		VEND_CONTAINERS = 1;
	}

	void OnSpawn() override
	{
		SetHealth(25);
		SetGold(25);
		SetName("Bertold the Fletcher");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetInvincible(true);
		CANCHAT = 1;
		THIS_MAP = StringToLower(GetMapName());
		NO_HAIL = 1;
		NO_JOB = 1;
		NO_RUMOR = 1;
		if (THIS_MAP == "helena")
		{
			SetName("Hendlekemp , master fletcher of Helena");
			HELENA_MODE = 1;
		}
		if (THIS_MAP == "gatecity")
		{
			SetName("Soltov , the traveling fletcher");
		}
		if (!(HELENA_MODE))
		{
			SetAngles("face");
		}
		if (!(THIS_MAP == "edana")) return;
		NO_JOB = 0;
		NO_RUMOR = 0;
		CatchSpeech("say_job", "job");
		CatchSpeech("say_rumor", "rumour");
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "proj_arrow_fire", 600, 100, 0, 60);
		AddStoreItem(STORE_NAME, "proj_arrow_wooden", 600, 100, 0, 60);
		AddStoreItem(STORE_NAME, "proj_arrow_broadhead", 600, 100, 0, 60);
		AddStoreItem(STORE_NAME, "pack_quiver", 3, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "bows_orcbow", 1, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "bows_treebow", 2, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "bows_shortbow", 1, 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "item_feather", 0, 150, SELL_RATIO);
		AddStoreItem(STORE_NAME, "proj_bolt_wooden", 100, 100, SELL_RATIO);
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORE_NAME, "proj_bolt_iron", 200, 100, SELL_RATIO);
		}
		if (RandomInt(1, 12) == 1)
		{
			ARROW_AMT = RandomInt(1, 3);
			ARROW_AMT *= 30;
			AddStoreItem(STORE_NAME, "proj_arrow_jagged", ARROW_AMT, 500, 0.1, 30);
			AddStoreItem(STORE_NAME, "proj_arrow_broadhead", ARROW_AMT, 500, 0.1, 30);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORE_NAME, "proj_arrow_silvertipped", 300, 200, 0, 60);
		}
		if (THIS_MAP == "gatecity")
		{
			AddStoreItem(STORE_NAME, "proj_arrow_holy", 60, 200, 0.1, 30);
			if (RandomInt(1, 2) == 1)
			{
				AddStoreItem(STORE_NAME, "proj_bolt_fire", 25, 200, 0, 25);
			}
		}
	}

	void trade_success()
	{
		if (!(CANCHAT == 1)) return;
		Say("goods[.34] [.24] [.35] [.40]");
		CANCHAT = 0;
		ScheduleDelayedEvent(10, "resetchat");
	}

	void resetchat()
	{
		CANCHAT = 1;
	}

	void say_job()
	{
		if ((HELENA_MODE)) return;
		SayText("Sorry lad " + I + " do all my work at home and have no need for an aide , maybe the armourer could find a place for you?");
	}

	void say_rumor()
	{
		if ((HELENA_MODE)) return;
		PlayAnim("once", "pondering");
		say_rumour2();
	}

	void say_rumour2()
	{
		SayText("Krythos lacks some confidence in himself and his goods , and he keeps high prices.");
	}

}

}
