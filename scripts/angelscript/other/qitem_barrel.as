#pragma context server

#include "monsters/debug.as"

namespace MS
{

class QitemBarrel : CGameScript
{
	int AM_SUMMONED;
	int BARREL_CLOSED_IDX;
	string BARREL_DONE;
	string BARREL_EVENT;
	string BARREL_EXPLODES;
	string BARREL_PLR;
	string BARREL_SUBMODEL_GROUP;
	string BARREL_SUBMODEL_IDX_MAX;
	string BARREL_SUBMODEL_IDX_MIN;
	string BARREL_USE_SUBMODELS;
	int ITEMS_TO_TURN_IN;
	int ITEM_COUNT;
	string ITEM_NAME;
	string ITEM_REQ;
	string ITEM_TYPE;
	string MAIN_NAME;
	string MENU_ADD;
	int PLAYING_DEAD;
	string SOUND_EXPLODE;
	string SPRITE_EXPLODE;

	QitemBarrel()
	{
		SPRITE_EXPLODE = "bigsmoke.spr";
		SOUND_EXPLODE = "weapons/explode3.wav";
		BARREL_CLOSED_IDX = 6;
		ITEMS_TO_TURN_IN = 0;
	}

	void OnSpawn() override
	{
		SetModel("props/tnt_barrel.mdl");
		SetWidth(32);
		SetHeight(72);
		SetModelBody(0, 0);
		SetProp(GetOwner(), "skin", 0);
		SetNoPush(true);
		SetInvincible(true);
		PLAYING_DEAD = 1;
		SetName("Barrel");
		MAIN_NAME = "Barrel of Stuff";
		SetMenuAutoOpen(1);
		ITEM_COUNT = 0;
	}

	void game_postspawn()
	{
		if ((AM_SUMMONED)) return;
		string PARAM_OUT1 = param4;
		setup_barrel(PARAM_OUT1);
	}

	void game_dynamically_created()
	{
		AM_SUMMONED = 1;
		string PARAM_OUT1 = param1;
		setup_barrel(PARAM_OUT1);
	}

	void setup_barrel()
	{
		if (!(ITEM_TYPE == "ITEM_TYPE")) return;
		LogDebug("setup_barrel PARAM1");
		ITEM_TYPE = GetToken(param1, 0, ";");
		ITEM_REQ = GetToken(param1, 1, ";");
		BARREL_EVENT = GetToken(param1, 2, ";");
		if (GetTokenCount(param1, ";") >= 4)
		{
			if (GetToken(param1, 3, ";") == "repeat")
			{
				BARREL_REPEATS = 1;
			}
		}
		if ((ITEM_TYPE).findFirst("tnt") >= 0)
		{
			MAIN_NAME = "Barrel of Explosives ";
			SetName("a");
			SetProp(GetOwner(), "skin", 0);
			MENU_ADD = "Add Explosives ";
			ITEM_NAME = "explosives";
			BARREL_EXPLODES = 1;
			BARREL_USE_SUBMODELS = 1;
			BARREL_SUBMODEL_GROUP = 0;
			BARREL_SUBMODEL_IDX_MIN = 1;
			BARREL_SUBMODEL_IDX_MAX = 5;
			update_name();
			int L_TYPE_HANDLED = 1;
		}
		if (!(L_TYPE_HANDLED))
		{
			LogDebug("$currentscript - Warning! Type ITEM_TYPE not handled!");
		}
	}

	void update_name()
	{
		string L_NAME = MAIN_NAME;
		L_NAME += "()";
		L_NAME += int(ITEM_COUNT);
		L_NAME += "/";
		L_NAME += int(ITEM_REQ);
		L_NAME += ")";
		SetName(L_NAME);
	}

	void ext_receive_quest_item()
	{
		ITEMS_TO_TURN_IN += 1;
		ITEMS_TO_TURN_IN = int(ITEMS_TO_TURN_IN);
	}

	void game_menu_getoptions()
	{
		if ((BARREL_DONE)) return;
		CallExternal(GAME_MASTER, "ext_check_quest_item", ITEM_TYPE, GetEntityIndex(GetOwner()));
		if (ITEMS_TO_TURN_IN > 0)
		{
			string reg.mitem.title = MENU_ADD;
			reg.mitem.title += "()";
			reg.mitem.title += ITEMS_TO_TURN_IN;
			reg.mitem.title += ")";
			string reg.mitem.type = "callback";
			string reg.mitem.data = ITEMS_TO_TURN_IN;
			string reg.mitem.callback = "add_items";
		}
		else
		{
			string L_OUT_MSG = "You have no ";
			L_OUT_MSG += ITEM_NAME;
			L_OUT_MSG += " to add to the ";
			L_OUT_MSG += MAIN_NAME;
			SendInfoMsg(param1, "Quest item required " + L_OUT_MSG);
			string reg.mitem.title = MENU_ADD;
			string reg.mitem.type = "disabled";
		}
	}

	void add_items()
	{
		ITEM_COUNT += param2;
		ITEMS_TO_TURN_IN -= int(ITEM_COUNT);
		if (ITEMS_TO_TURN_IN < 0)
		{
			ITEMS_TO_TURN_IN = 0;
		}
		if (param2 != 0)
		{
			EmitSound(GetOwner(), 0, "items/ammopickup1.wav", 10);
		}
		update_name();
		if ((BARREL_USE_SUBMODELS))
		{
			string L_FULL_RATIO = ITEM_COUNT;
			L_FULL_RATIO /= ITEM_REQ;
			string L_BODY = /* TODO: $ratio */ $ratio(L_FULL_RATIO, BARREL_SUBMODEL_IDX_MIN, BARREL_SUBMODEL_IDX_MAX);
			int L_BODY = int(L_BODY);
			SetModelBody(BARREL_SUBMODEL_GROUP, L_BODY);
		}
		if ((IsValidPlayer(param1)))
		{
			BARREL_PLR = param1;
		}
		if (!(ITEM_COUNT >= ITEM_REQ)) return;
		if ((BARREL_USE_SUBMODELS))
		{
			SetModelBody(BARREL_SUBMODEL_GROUP, BARREL_SUBMODEL_IDX_MAX);
		}
		string L_OUT_MSG = MAIN_NAME;
		L_OUT_MSG += "is full!";
		ShowHelpTip(BARREL_PLR, "generic", L_OUT_MSG, " ");
		do_event();
	}

	void ext_setbody()
	{
		LogDebug("ext_setbody PARAM1 PARAM2");
		SetModelBody(param1, param2);
	}

	void do_event()
	{
		if (!(BARREL_EXPLODES))
		{
			UseTrigger(BARREL_EVENT);
		}
		else
		{
			SetMenuAutoOpen(0);
			BARREL_DONE = 1;
			do_explode();
		}
		if ((BARREL_REPEATS))
		{
			ITEM_COUNT -= ITEM_REQ;
			if (ITEM_COUNT >= 0)
			{
				add_items(0, 0);
			}
		}
		else
		{
			SetMenuAutoOpen(0);
			BARREL_DONE = 1;
			if (!(BARREL_EXPLODES))
			{
				SetModelBody(0, BARREL_CLOSED_IDX);
			}
		}
	}

	void do_explode()
	{
		EmitSound(GetOwner(), 0, "monsters/dwarf_bomber/fuse_lit.wav", 10);
		ClientEvent("new", "all", "monsters/summon/tnt_bomb_cl", GetEntityIndex(GetOwner()), 5.0);
		ScheduleDelayedEvent(5.0, "do_explode2");
	}

	void do_explode2()
	{
		UseTrigger(BARREL_EVENT);
		EmitSound(GetOwner(), 0, SOUND_EXPLODE, 10);
		Effect("tempent", "spray", SPRITE_EXPLODE, GetMonsterProperty("origin"), 0, 1, 0, 0);
		SetModel("none");
		XDoDamage(GetEntityOrigin(GetOwner()), 256, 2000, 0.9, GetOwner(), GetOwner(), "none", "fire_effect", "dmgevent:push_loop");
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void push_loop_dodamage()
	{
		string CUR_TARGET = param2;
		string TARGET_ORG = GetEntityOrigin(CUR_TARGET);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARGET_ORG);
		SetVelocity(CUR_TARGET, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 1000, 110)));
	}

	void remove_me()
	{
		SetEntityOrigin(GetOwner(), Vector3(20000, 0, 0));
		SetInvincible(false);
		SetRace("hated");
		DoDamage(GetOwner(), "direct", 99999, 100, GAME_MASTER);
	}

	void set_scale()
	{
		if (!(param1 > 0)) return;
		SetProp(GetOwner(), "scale", param1);
		string MY_WIDTH = GetEntityWidth(GetOwner());
		string MY_HEIGHT = GetEntityHeight(GetOwner());
		MY_WIDTH *= param1;
		MY_HEIGHT *= param1;
		SetWidth(MY_WIDTH);
		SetHeight(MY_WIDTH);
	}

}

}
