#pragma context server

namespace MS
{

class Withdraw : CGameScript
{
	string PLAYER_WITHDRAWING;
	string STORENAME;

	void withdraw_items()
	{
		if (!(PLAYER_WITHDRAWING))
		{
			PLAYER_WITHDRAWING = param1;
			STORENAME = "galat_";
			// TODO: createstore STORENAME
			for (int i = 0; i < BANK_MAX; i++)
			{
				build_stores(GetEntityIndex(param1));
			}
			// TODO: offerstore STORENAME GetEntityIndex(param1) inv trade
		}
		else
		{
			string L_MSG = GetEntityName(GetOwner());
			SendColoredMessage(GetEntityIndex(param1), "L_MSG");
		}
	}

	void build_stores()
	{
		string L_BANK = GetToken(BANK_STRINGS, i, ";");
		string L_BANK_CONTENTS = GetPlayerQuestData(param1, L_BANK);
		if ((L_BANK_CONTENTS).length() > 1)
		{
			for (int i = 0; i < GetTokenCount(L_BANK_CONTENTS, ";"); i++)
			{
				add_to_chest(L_BANK_CONTENTS);
			}
		}
	}

	void add_to_chest()
	{
		string L_BANK_CONTENTS = param1;
		string L_ITEM_SCRIPTNAME = GetToken(L_BANK_CONTENTS, i, ";");
		string L_QUANTITY = /* TODO: $func */ $func("func_get_stored_quantity", L_BANK_CONTENTS, /* TODO: $pass */ $pass(i));
		if (L_QUANTITY > 1)
		{
			if ((/* TODO: $get_item_table */ $get_item_table(L_ITEM_SCRIPTNAME, "is_projectile")))
			{
				string L_MAX_STACK = MAX_IN_ONE_TRANSACTION;
			}
			else
			{
				string L_MAX_STACK = /* TODO: $get_item_table */ $get_item_table(L_ITEM_SCRIPTNAME, "quality");
			}
			string L_STACKS = /* TODO: $math(divide) */ L_QUANTITY;
			if (L_STACKS > int(L_STACKS))
			{
				L_QUANTITY %= L_MAX_STACK;
				AddStoreItem(STORENAME, L_ITEM_SCRIPTNAME, L_QUANTITY, 0, 0, L_QUANTITY);
			}
			for (int i = 0; i < int(L_STACKS); i++)
			{
				add_stack_to_chest(L_ITEM_SCRIPTNAME, L_MAX_STACK);
			}
		}
		else
		{
			AddStoreItem(STORENAME, L_ITEM_SCRIPTNAME, L_QUANTITY, 0, 0, L_QUANTITY);
		}
	}

	void add_stack_to_chest()
	{
		AddStoreItem(STORENAME, param1, param2, 0, 0, param2);
	}

	void ext_player_got_item()
	{
		string L_ITEM = param1;
		string L_ITEM_SCRIPTNAME = GetEntityProperty(L_ITEM, "itemname");
		string L_PLAYER = param2;
		string L_ITEM_FOUND = /* TODO: $func */ $func("func_check_bank_has", L_PLAYER, L_ITEM_SCRIPTNAME);
		if (L_ITEM_FOUND != "0")
		{
			string L_BANK = GetToken(L_ITEM_FOUND, 0, ";");
			string L_BANK_STR = GetPlayerQuestData(L_PLAYER, L_BANK);
			string L_ITEM_IDX = GetToken(L_ITEM_FOUND, 1, ";");
			string L_QUANTITY_STORED = /* TODO: $func */ $func("func_get_stored_quantity", L_BANK_STR, L_ITEM_IDX);
			string L_QUANTITY_WITHDRAWING = L_QUANTITY_STORED;
			if (L_QUANTITY_STORED > 1)
			{
				string L_MAX_TRANSACTION = MAX_IN_ONE_TRANSACTION;
				if ((GetEntityProperty(L_ITEM, "is_drinkable")))
				{
					string L_MAX_TRANSACTION = GetEntityProperty(L_ITEM, "quality");
				}
				if (L_QUANTITY_WITHDRAWING > L_MAX_TRANSACTION)
				{
					string L_QUANTITY_WITHDRAWING = L_MAX_TRANSACTION;
				}
				L_QUANTITY_STORED -= L_QUANTITY_WITHDRAWING;
				if (L_QUANTITY_STORED > 1)
				{
					SetToken(L_BANK_STR, /* TODO: $math(add) */ L_ITEM_IDX, int(L_QUANTITY_STORED), ";");
				}
				else
				{
					if (L_QUANTITY_STORED == 1)
					{
						RemoveToken(L_BANK_STR, /* TODO: $math(add) */ L_ITEM_IDX, ";");
					}
					else
					{
						RemoveToken(L_BANK_STR, L_ITEM_IDX, ";");
						RemoveToken(L_BANK_STR, L_ITEM_IDX, ";");
					}
				}
			}
			else
			{
				RemoveToken(L_BANK_STR, L_ITEM_IDX, ";");
			}
			if ((GetEntityProperty(L_ITEM, "is_projectile")))
			{
				// TODO: setquantity L_ITEM L_QUANTITY_WITHDRAWING
			}
			else
			{
				if ((GetEntityProperty(L_ITEM, "is_drinkable")))
				{
					// TODO: setquality L_ITEM L_QUANTITY_WITHDRAWING
					// TODO: setquantity L_ITEM 1
				}
			}
			SetPlayerQuestData(L_PLAYER, L_BANK);
		}
		else
		{
			LogDebug("Couldn't find item!");
			CallExternal(L_ITEM, "item_banked");
			DeleteEntity(L_ITEM);
		}
	}

}

}
