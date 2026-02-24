#pragma context server

#include "monsters/debug.as"

namespace MS
{

class Qitem : CGameScript
{
	int AM_SUMMONED;
	string GLOW_COLOR;
	int IS_ACTIVE;
	string ITEM_TYPE;
	string NEXT_TOUCH;
	int PLAYING_DEAD;
	string QUEST_PLAYER;
	string SLOW_COUNT;
	string TNT_MODEL;

	Qitem()
	{
		GLOW_COLOR = Vector3(255, 200, 0);
		SetCallback("touch", "enable");
	}

	void OnSpawn() override
	{
		SetModel("misc/sylphiels_stuff.mdl");
		SetWidth(16);
		SetHeight(16);
		SetSolid("trigger");
		SetInvincible(true);
		SetNoPush(true);
		PLAYING_DEAD = 1;
		ScheduleDelayedEvent(1.0, "glow_loop");
	}

	void glow_loop()
	{
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(10.0, "glow_loop");
		Effect("glow", GetOwner(), GLOW_COLOR, 16.0, 9.0, -1);
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if (!(IS_ACTIVE)) return;
		if (!(GetGameTime() > NEXT_TOUCH)) return;
		NEXT_TOUCH = GetGameTime();
		NEXT_TOUCH += 1.0;
		if (!(IsValidPlayer(param1))) return;
		QUEST_PLAYER = param1;
		found_item();
	}

	void found_item()
	{
		if (!(IS_ACTIVE)) return;
		IS_ACTIVE = 0;
		EmitSound(GetOwner(), 0, "items/ammopickup1.wav", 10);
		string OUT_MSG = "You find ";
		OUT_MSG += GetEntityProperty(GetOwner(), "name.full");
		SendColoredMessage(QUEST_PLAYER, "You acquire  " + GetEntityProperty(GetOwner(), "name.full"));
		SendInfoMsg("all", "QUEST ITEM FOUND " + OUT_MSG);
		ShowHelpTip(QUEST_PLAYER, "questitem", "QUEST ITEM", "This is a special quest item that will not appear in your inventory.");
		CallExternal(GAME_MASTER, "ext_got_quest_item", ITEM_TYPE);
		ScheduleDelayedEvent(0.5, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

	void game_postspawn()
	{
		string L_PARAM = StringToLower(GetToken(param4, 0, ";"));
		if (L_PARAM != "none")
		{
			set_item_type(L_PARAM);
		}
	}

	void set_item_type()
	{
		IS_ACTIVE = 1;
		ITEM_TYPE = param1;
		if (ITEM_TYPE == "ap")
		{
			SetName("Golden Apple");
			SetModelBody(0, 0);
			int L_DID_INIT = 1;
		}
		if (ITEM_TYPE == "bs")
		{
			SetName("Bag of Salt");
			SetModelBody(0, 1);
			int L_DID_INIT = 1;
		}
		if (ITEM_TYPE == "bp")
		{
			SetName("Bag of Pepper");
			SetModelBody(0, 2);
			int L_DID_INIT = 1;
		}
		if (ITEM_TYPE == "km")
		{
			SetName("Barrel of Mead");
			SetModelBody(0, 3);
			int L_DID_INIT = 1;
		}
		if (ITEM_TYPE == "la")
		{
			SetName("Sylphiel's Ladel");
			SetModelBody(0, 4);
			int L_DID_INIT = 1;
		}
		if (ITEM_TYPE == "tnt")
		{
			SetName("a stick of|Dwarven Explosives");
			GLOW_COLOR = Vector3(0, 255, 0);
			SetProp(GetOwner(), "movetype", "const.movetype.bounce");
			TNT_MODEL = "monsters/dwarf_bomber_tnt.mdl";
			SLOW_COUNT = 0;
			ScheduleDelayedEvent(0.1, "slow_down_loop");
			SetModel(TNT_MODEL);
			int L_DID_INIT = 1;
			SetMonsterClip(0);
		}
		if ((L_DID_INIT)) return;
		string OUT_MSG = "m2_quest/sylphiels_stuff cannot find type: ";
		OUT_MSG += ITEM_TYPE;
		SendInfoMsg("all", "MAPPING ERROR " + OUT_MSG);
	}

	void slow_down_loop()
	{
		string CUR_VEL = GetEntityVelocity(GetOwner());
		CUR_VEL *= Vector3(0.5, 0.5, 0.5);
		SLOW_COUNT += 1;
		if (SLOW_COUNT >= 20)
		{
			Vector3 CUR_VEL = Vector3(0, 0, 0);
		}
		SetVelocity(GetOwner(), CUR_VEL);
		if (!(CUR_VEL != Vector3(0, 0, 0))) return;
		ScheduleDelayedEvent(0.5, "slow_down_loop");
	}

	void game_dynamically_created()
	{
		AM_SUMMONED = 1;
		set_item_type(StringToLower(param1));
	}

}

}
