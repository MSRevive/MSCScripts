#pragma context server

#include "chests/bank1/filter.as"
#include "chests/bank1/deposit.as"
#include "chests/bank1/withdraw.as"

namespace MS
{

class Bank1 : CGameScript
{
	string ANIM_CLOSE;
	string ANIM_IDLE;
	string ANIM_OPEN;
	string BANK_HAS;
	int BANK_MAX;
	string BANK_PREFIX;
	string BANK_STRINGS;
	string FREE_BANK;
	int MAX_AMMO_IN_ONE_SLOT;
	int MAX_BANK_STRING;
	int MAX_IN_ONE_TRANSACTION;
	int MAX_SWIGS_IN_ONE_SLOT;
	int NPC_ECHO_ITEMS;
	int NPC_NO_REPORT_ITEMS;
	int PLAYER_WITHDRAWING;
	string SCAN_AREA;
	string STACK_REMAINDER;

	Bank1()
	{
		ANIM_IDLE = "idle";
		ANIM_CLOSE = "close";
		ANIM_OPEN = "open";
		BANK_PREFIX = "b";
		BANK_MAX = 10;
		MAX_BANK_STRING = 255;
		MAX_IN_ONE_TRANSACTION = 100;
		MAX_AMMO_IN_ONE_SLOT = 9999;
		MAX_SWIGS_IN_ONE_SLOT = 20;
		NPC_ECHO_ITEMS = 1;
		NPC_NO_REPORT_ITEMS = 1;
		PLAYER_WITHDRAWING = 0;
	}

	void OnSpawn() override
	{
		SetName("Galat's Wondrous Chest of Storage");
		SetHealth(1);
		SetInvincible(true);
		SetWidth(20);
		SetHeight(30);
		SetModel("misc/treasure.mdl");
		SetModelBody(0, 2);
		SetIdleAnim(ANIM_IDLE);
		SetGravity(0.1);
		SetNoPush(true);
		for (int i = 0; i < BANK_MAX; i++)
		{
			generate_bank_strings();
		}
		SetMenuAutoOpen(1);
	}

	void generate_bank_strings()
	{
		string L_STR = /* TODO: $stradd */ $stradd(BANK_PREFIX, i);
		if (BANK_STRINGS == "BANK_STRINGS")
		{
			BANK_STRINGS = L_STR;
		}
		else
		{
			if (BANK_STRINGS.length() > 0) BANK_STRINGS += ";";
			BANK_STRINGS += L_STR;
		}
	}

	void game_menu_getoptions()
	{
		string L_PLAYER = param1;
		string L_ITEMS = GetEntityProperty(L_PLAYER, "scriptvar");
		if (L_ITEMS.length() > 0) L_ITEMS += ";";
		L_ITEMS += GetEntityProperty(L_PLAYER, "scriptvar");
		string L_ITEMS = "func_filter_items"(L_PLAYER, L_ITEMS);
		if (L_ITEMS == "0")
		{
			SendInfoMsg(L_PLAYER, "Galat's wondrous Chest of Storage Be sure to place any items you wish to store in your hands.");
			if (NUM_REMOVED > 0)
			{
				string reg.mitem.title = "Chest is Full";
				string reg.mitem.type = "disabled";
			}
		}
		else
		{
			for (int i = 0; i < GetTokenCount(L_ITEMS, ";"); i++)
			{
				add_deposit_options(L_ITEMS);
			}
		}
		if (("func_check_bank_has"(L_PLAYER)))
		{
			if (GetEntityProperty(L_PLAYER, "numitems") >= G_MAX_ITEMS)
			{
				SendInfoMsg(L_PLAYER, "Can't Withdaw Items Your inventory is full.");
				string reg.mitem.title = "(Inventory Full)";
				string reg.mitem.type = "disabled";
			}
			else
			{
				if (!(PLAYER_WITHDRAWING))
				{
					string reg.mitem.title = "Withdraw Items";
					string reg.mitem.type = "callback";
					string reg.mitem.callback = "withdraw_items";
				}
				else
				{
					string L_MSG = GetEntityName(GetOwner());
					SendColoredMessage(GetEntityIndex(L_PLAYER), L_MSG);
					string reg.mitem.title = "Withdraw Items";
					string reg.mitem.type = "disabled";
				}
			}
		}
	}

	void add_deposit_options()
	{
		string L_ITEM = GetToken(param1, i, ";");
		string L_ITEM_TITLE = "Deposit ";
		string L_SCRIPTNAME_STRING = "func_make_string"(L_ITEM);
		string L_DEPOSIT_AMT = GetToken(L_SCRIPTNAME_STRING, 1, ";");
		if (L_DEPOSIT_AMT > 0)
		{
			L_ITEM_TITLE += " (";
			L_ITEM_TITLE += L_DEPOSIT_AMT;
			L_ITEM_TITLE += ")";
		}
		string reg.mitem.title = L_ITEM_TITLE;
		string reg.mitem.type = "callback";
		string reg.mitem.data = L_ITEM;
		string reg.mitem.callback = "deposit_item";
	}

	void trade_success()
	{
		open_chest();
	}

	void trade_done()
	{
		close_chest();
		erase_store();
		PLAYER_WITHDRAWING = 0;
	}

	void erase_store()
	{
		NpcStoreRemove(STORENAME);
	}

	void game_dynamically_created()
	{
		string L_YAW = GetEntityProperty(param1, "angles.yaw");
		SetSolid("none");
		if (!(IsValidPlayer(param1)))
		{
			spawn_in(L_YAW);
		}
		else
		{
			string OTHER_CHEST = FindEntityByName("galat_bank1");
			if (((OTHER_CHEST !is null)))
			{
				SetEntityOrigin(OTHER_CHEST, GetEntityOrigin(GetOwner()));
				CallExternal(OTHER_CHEST, "spawn_in", /* TODO: $neg */ $neg(L_YAW));
				DeleteEntity(GetOwner());
			}
			else
			{
				SetName("galat_bank1");
				spawn_in(/* TODO: $neg */ $neg(L_YAW));
			}
		}
	}

	void spawn_in()
	{
		string L_YAW = param1;
		EmitSound(GetOwner(), 0, "magic/spawn.wav", 7);
		SetAngles("face");
		CallExternal(GAME_MASTER, "gm_fade_in", GetEntityIndex(GetOwner()), 5);
		SCAN_AREA = FindEntitiesInSphere("any", 64);
		if (!(SCAN_AREA != "none")) return;
		for (int i = 0; i < GetTokenCount(SCAN_AREA, ";"); i++)
		{
			move_monsters();
		}
	}

	void move_monsters()
	{
		string CUR_TARG = GetToken(SCAN_AREA, i, ";");
		if ((IsValidPlayer(CUR_TARG))) return;
		if ((GetEntityProperty(CUR_TARG, "scriptvar"))) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARG_ORG);
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 1000, 110)));
	}

	void fade_in_done()
	{
		SetProp(GetOwner(), "rendermode", 0);
		SetProp(GetOwner(), "renderamt", 255);
	}

	void open_chest()
	{
		EmitSound(GetOwner(), 2, "Items/creak.wav", 10);
		PlayAnim("hold", ANIM_OPEN);
	}

	void close_chest()
	{
		PlayAnim("once", ANIM_CLOSE);
	}

	void func_get_free_bank()
	{
		string L_PLAYER = param1;
		string L_ITEM = param2;
		for (int i = 0; i < BANK_MAX; i++)
		{
			free_bank_looper(L_PLAYER, L_ITEM);
		}
		return;
		return;
	}

	void free_bank_looper()
	{
		if (i == 0)
		{
			FREE_BANK = 0;
		}
		string L_PLAYER = param1;
		string L_ITEM = param2;
		string L_ITEM_SCRIPTNAME = GetEntityProperty(param2, "itemname");
		string L_ITEM_STRING = "func_make_string"(L_ITEM);
		string L_BANK = GetToken(BANK_STRINGS, i, ";");
		string L_BANK_CONTENTS = GetPlayerQuestData(L_PLAYER, L_BANK);
		string L_NEW_BANK_CONTENTS = "func_stack_quantity"(L_BANK_CONTENTS, L_ITEM_STRING);
		if (L_NEW_BANK_CONTENTS != L_BANK_CONTENTS)
		{
			FREE_BANK = L_BANK;
			break;
		}
		else
		{
			string L_RESULT = ((L_BANK_CONTENTS).length() + (L_ITEM_STRING).length());
			L_RESULT += 1;
			if (L_RESULT <= MAX_BANK_STRING)
			{
				FREE_BANK = L_BANK;
				break;
			}
		}
	}

	void func_check_bank_has()
	{
		string L_PLAYER = param1;
		string L_ITEM_SCRIPTNAME = param2;
		if (L_ITEM_SCRIPTNAME == "PARAM2")
		{
			for (int i = 0; i < BANK_MAX; i++)
			{
				bank_has_anything_loop(L_PLAYER);
			}
		}
		else
		{
			for (int i = 0; i < BANK_MAX; i++)
			{
				bank_has_item_loop(L_PLAYER, L_ITEM_SCRIPTNAME);
			}
		}
		return;
		return;
	}

	void bank_has_anything_loop()
	{
		if (i == 0)
		{
			BANK_HAS = 0;
		}
		string L_BANK_SLOT = GetToken(BANK_STRINGS, i, ";");
		string L_BANK_CONTENTS = GetPlayerQuestData(param1, L_BANK_SLOT);
		if ((L_BANK_CONTENTS).length() > 1)
		{
			BANK_HAS = 1;
			break;
		}
	}

	void bank_has_item_loop()
	{
		if (i == 0)
		{
			BANK_HAS = 0;
		}
		string L_BANK_SLOT = GetToken(BANK_STRINGS, i, ";");
		string L_BANK_CONTENTS = GetPlayerQuestData(param1, L_BANK_SLOT);
		string L_IDX = FindToken(L_BANK_CONTENTS, param2, ";");
		if (L_IDX != -1)
		{
			BANK_HAS = L_BANK_SLOT;
			break;
		}
	}

	void func_stack_quantity()
	{
		string L_BANK_CONTENTS = param1;
		string L_SCRIPTNAME_STRING = param2;
		STACK_REMAINDER = GetToken(L_SCRIPTNAME_STRING, 1, ";");
		if (STACK_REMAINDER == 0)
		{
			STACK_REMAINDER = 1;
		}
		string L_ITEM_SCRIPTNAME = GetToken(L_SCRIPTNAME_STRING, 0, ";");
		int L_MAX_QUANTITY = 1;
		if ((/* TODO: $get_item_table */ $get_item_table(L_ITEM_SCRIPTNAME, "is_projectile")))
		{
			string L_MAX_QUANTITY = MAX_AMMO_IN_ONE_SLOT;
		}
		else
		{
			if ((/* TODO: $get_item_table */ $get_item_table(L_ITEM_SCRIPTNAME, "is_drinkable")))
			{
				string L_MAX_QUANTITY = MAX_SWIGS_IN_ONE_SLOT;
			}
		}
		if (L_MAX_QUANTITY > 1)
		{
			string L_EXISTING_IDX = FindToken(L_BANK_CONTENTS, L_ITEM_SCRIPTNAME, ";");
			if (L_EXISTING_IDX != -1)
			{
				string L_EXISTING_QUANTITY = "func_get_stored_quantity"(L_BANK_CONTENTS, L_EXISTING_IDX);
				if (L_EXISTING_QUANTITY < L_MAX_QUANTITY)
				{
					int L_INSERT_QUANTITY = 1;
					string L_EXISTING_SCRIPTNAME_STRING = L_ITEM_SCRIPTNAME;
					if (L_EXISTING_QUANTITY != 1)
					{
						int L_INSERT_QUANTITY = 0;
						if (L_EXISTING_SCRIPTNAME_STRING.length() > 0) L_EXISTING_SCRIPTNAME_STRING += ";";
						L_EXISTING_SCRIPTNAME_STRING += GetToken(L_BANK_CONTENTS, (L_EXISTING_IDX + 1), ";");
					}
					L_EXISTING_QUANTITY += STACK_REMAINDER;
					int L_REMAINDER = 0;
					if (L_EXISTING_QUANTITY > L_MAX_QUANTITY)
					{
						string L_REMAINDER = (L_EXISTING_QUANTITY - L_MAX_QUANTITY);
						string L_EXISTING_QUANTITY = L_MAX_QUANTITY;
					}
					string L_NEW_SCRIPTNAME_STRING = L_ITEM_SCRIPTNAME;
					string L_BANK_CONTENTS_LEN = (L_BANK_CONTENTS).length();
					L_BANK_CONTENTS_LEN -= (L_EXISTING_SCRIPTNAME_STRING).length();
					L_BANK_CONTENTS_LEN += (L_NEW_SCRIPTNAME_STRING).length();
					if (L_BANK_CONTENTS_LEN <= MAX_BANK_STRING)
					{
						if ((L_INSERT_QUANTITY))
						{
							SetToken(L_BANK_CONTENTS, L_EXISTING_IDX, L_NEW_SCRIPTNAME_STRING, ";");
						}
						else
						{
							SetToken(L_BANK_CONTENTS, (L_EXISTING_IDX + 1), int(L_EXISTING_QUANTITY), ";");
						}
						STACK_REMAINDER = L_REMAINDER;
					}
				}
			}
		}
		return;
		return;
	}

	void func_make_string()
	{
		string L_ITEM = param1;
		string L_ITEM_SCRIPTNAME = GetEntityProperty(param1, "itemname");
		int L_QUANTITY = 1;
		if ((GetEntityProperty(L_ITEM, "is_projectile")))
		{
			string L_QUANTITY = GetEntityProperty(L_ITEM, "quantity");
			if (L_QUANTITY > MAX_IN_ONE_TRANSACTION)
			{
				string L_QUANTITY = MAX_IN_ONE_TRANSACTION;
			}
		}
		else
		{
			if ((GetEntityProperty(L_ITEM, "is_drinkable")))
			{
				string L_QUANTITY = GetEntityProperty(L_ITEM, "quality");
			}
		}
		if (L_QUANTITY > 1)
		{
			if (L_ITEM_SCRIPTNAME.length() > 0) L_ITEM_SCRIPTNAME += ";";
			L_ITEM_SCRIPTNAME += L_QUANTITY;
		}
		return;
		return;
	}

	void func_get_stored_quantity()
	{
		string L_BANK_CONTENTS = param1;
		string L_QUANTITY = (param2 + 1);
		string L_QUANTITY = GetToken(L_BANK_CONTENTS, L_QUANTITY, ";");
		if (L_QUANTITY == /* TODO: $num */ $num(L_QUANTITY))
		{
			if (L_QUANTITY == 0)
			{
				int L_QUANTITY = 1;
			}
		}
		else
		{
			int L_QUANTITY = 1;
		}
		return;
		return;
	}

}

}
