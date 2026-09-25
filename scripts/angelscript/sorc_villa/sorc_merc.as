#pragma context server

#include "monsters/base_npc_vendor.as"
#include "monsters/base_chat_array.as"
#include "monsters/debug.as"

namespace MS
{

class SorcMerc : CGameScript
{
	string LAST_PLAYER_USED;
	string NEXT_YAW_RESET;
	int SORC_STORE_STOCKED;
	string START_YAW;
	string STORE_NAME;
	string STORE_TRIGGERTEXT;
	int VENDOR_MENU_OFF;
	int VENDOR_NOT_ON_USE;

	SorcMerc()
	{
		STORE_NAME = "sorc_merc_";
		STORE_NAME += Random(-10000.00, 10000.00);
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(60.0);
		if (GetGameTime() > NEXT_YAW_RESET)
		{
		}
		SetAngles("face");
	}

	void OnSpawn() override
	{
		SetName("Shadahar Merchant");
		SetModel("monsters/sorc.mdl");
		SetHealth(1);
		SetInvincible(true);
		SetWidth(32);
		SetHeight(72);
		SetRace("beloved");
		SetNoPush(true);
		SetIdleAnim("idle1");
		SetMoveAnim("idle1");
		PlayAnim("once", "idle1");
		if (RandomInt(1, 2) == 1)
		{
			SetModelBody(0, 1);
			SetModelBody(1, 4);
			SetModelBody(2, 0);
		}
		else
		{
			SetModelBody(0, 0);
			SetModelBody(1, 4);
			SetModelBody(2, 0);
		}
		SetSayTextRange(1024);
		VENDOR_MENU_OFF = 0;
		VENDOR_NOT_ON_USE = 0;
		SetMenuAutoOpen(1);
		ScheduleDelayedEvent(0.1, "get_yaw");
	}

	void get_yaw()
	{
		START_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
	}

	void game_menu_getoptions()
	{
		if (LAST_PLAYER_USED != param1)
		{
			int RND_COMMENT = RandomInt(1, 4);
			if (RND_COMMENT == 1)
			{
				SayText("Runegahr says we sells to you, so we sells to you.");
			}
			if (RND_COMMENT == 2)
			{
				SayText("Me have many things skinny humans maybe interested in.");
			}
			if (RND_COMMENT == 3)
			{
				SayText("First time me getting gold from a human without killing him first.");
			}
			if (RND_COMMENT == 4)
			{
				SayText("Some of my stuff maybe too heavy for skinny human arms.");
			}
			Random(30_0, 60_0)("reset_comment_target");
		}
		LAST_PLAYER_USED = param1;
		NEXT_YAW_RESET = GetGameTime();
		NEXT_YAW_RESET += 30.0;
	}

	void reset_comment_target()
	{
		LAST_PLAYER_USED = -1;
	}

	void vendor_addstoreitems()
	{
		if ((SORC_STORE_STOCKED)) return;
		SORC_STORE_STOCKED = 1;
		AddStoreItem(STORE_NAME, "health_mpotion", RandomInt(0, 1), 1.5, 0);
		AddStoreItem(STORE_NAME, "health_spotion", RandomInt(0, 1), 1.5, 0);
		AddStoreItem(STORE_NAME, "mana_mpotion", RandomInt(0, 1), 1.5, 0);
		AddStoreItem(STORE_NAME, "drink_mead", RandomInt(0, 1), 1.5, 0);
		AddStoreItem(STORE_NAME, "drink_ale", RandomInt(0, 1), 1.5, 0);
		AddStoreItem(STORE_NAME, "shields_lironshield", RandomInt(0, 1), 1.5, 0);
		AddStoreItem(STORE_NAME, "pack_heavybackpack", RandomInt(0, 1), 1.5, 0);
		AddStoreItem(STORE_NAME, "pack_archersquiver", RandomInt(0, 1), 1.5, 0);
		AddStoreItem(STORE_NAME, "sheath_back_holster", RandomInt(0, 1), 1.5, 0);
		AddStoreItem(STORE_NAME, "swords_iceblade", RandomInt(0, 1), 1.5, 0);
		AddStoreItem(STORE_NAME, "axes_poison1", RandomInt(0, 1), 1.5, 0);
		AddStoreItem(STORE_NAME, "blunt_granitemace", RandomInt(0, 1), 1.5, 0);
		AddStoreItem(STORE_NAME, "blunt_granitemaul", RandomInt(0, 1), 1.5, 0);
		AddStoreItem(STORE_NAME, "bows_swiftbow", RandomInt(0, 1), 1.5, 0);
		AddStoreItem(STORE_NAME, "axes_thunder11", 1, 10.0, 0);
		AddStoreItem(STORE_NAME, "axes_gthunder11", RandomInt(0, 1), 50.0, 0);
		AddStoreItem(STORE_NAME, "axes_greataxe", RandomInt(0, 1), 3.0, 0);
		AddStoreItem(STORE_NAME, "axes_scythe", RandomInt(0, 1), 3.0, 0);
		AddStoreItem(STORE_NAME, "bows_orcbow", RandomInt(0, 1), 0.5, 0);
		AddStoreItem(STORE_NAME, "armor_helm_dark", RandomInt(0, 1), 3.0, 0);
		AddStoreItem(STORE_NAME, "mana_demon_blood", RandomInt(0, 1), 10.0, 0);
		AddStoreItem(STORE_NAME, "mana_vampire", RandomInt(0, 1), 10.0, 0);
		AddStoreItem(STORE_NAME, "mana_regen", RandomInt(0, 1), 10.0, 0);
		AddStoreItem(STORE_NAME, "armor_helm_bronze", RandomInt(0, 1), 3.0, 0);
		AddStoreItem(STORE_NAME, "blunt_gauntlets_serpant", RandomInt(0, 1), 10.0, 0);
		if (RandomInt(1, 5) == 4)
		{
			AddStoreItem(STORE_NAME, "axes_tl", RandomInt(0, 1), 100.0, 0);
		}
		if (RandomInt(1, 20) == 20)
		{
			AddStoreItem(STORE_NAME, "shields_rune", 1, 50.0, 0);
		}
		if (RandomInt(1, 20) == 20)
		{
			AddStoreItem(STORE_NAME, "armor_helm_gaz1", 1, 30.0, 0);
		}
		if (RandomInt(1, 20) == 20)
		{
			AddStoreItem(STORE_NAME, "armor_helm_gaz2", 1, 30.0, 0);
		}
		if (RandomInt(1, 20) == 20)
		{
			AddStoreItem(STORE_NAME, "armor_fireliz", 1, 30.0, 0);
		}
		if (RandomInt(1, 20) == 20)
		{
			AddStoreItem(STORE_NAME, "axes_vaxe", 1, 30.0, 0);
		}
		if (RandomInt(1, 4) == 2)
		{
			AddStoreItem(STORE_NAME, "mana_leadfoot", 1, 50.0, 0);
		}
		if (RandomInt(1, 20) == 20)
		{
			AddStoreItem(STORE_NAME, "swords_wolvesbane", 1, 100.0, 0);
		}
		if (RandomInt(1, 10) == 2)
		{
			AddStoreItem(STORE_NAME, "axes_tl", 1, 100.0, 0);
		}
	}

	void game_confirm_buy()
	{
		LogDebug("PARAM1 PARAM2 PARAM3 PARAM4");
	}

}

}
