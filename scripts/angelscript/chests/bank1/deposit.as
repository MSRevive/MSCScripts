#pragma context server

namespace MS
{

class Deposit : CGameScript
{
	void deposit_item()
	{
		string L_PLAYER = param1;
		string L_ITEM = param2;
		string L_ITEM = "func_filter_items"(L_PLAYER, L_ITEM);
		if (L_ITEM != "0")
		{
			string L_FREE_BANK = "func_get_free_bank"(L_PLAYER, L_ITEM);
			if (L_FREE_BANK != "0")
			{
				string L_BANK_CONTENTS = GetPlayerQuestData(L_PLAYER, L_FREE_BANK);
				if ((L_BANK_CONTENTS).length() == 0)
				{
					int L_BANK_CONTENTS = 0;
				}
				string L_ITEM_SCRIPTNAME_STRING = "func_make_string"(L_ITEM);
				string L_NEW_BANK_CONTENTS = "func_stack_quantity"(L_BANK_CONTENTS, L_ITEM_SCRIPTNAME_STRING);
				if (L_NEW_BANK_CONTENTS != L_BANK_CONTENTS)
				{
					string L_BANK_CONTENTS = L_NEW_BANK_CONTENTS;
				}
				else
				{
					if (L_BANK_CONTENTS == "0")
					{
						string L_BANK_CONTENTS = L_ITEM_SCRIPTNAME_STRING;
					}
					else
					{
						if (L_BANK_CONTENTS.length() > 0) L_BANK_CONTENTS += ";";
						L_BANK_CONTENTS += L_ITEM_SCRIPTNAME_STRING;
					}
				}
				string L_NUM_STORING = GetToken(L_ITEM_SCRIPTNAME_STRING, 1, ";");
				if (L_NUM_STORING == 0)
				{
					int L_NUM_STORING = 1;
				}
				if (STACK_REMAINDER != L_NUM_STORING)
				{
					string L_NUM_STORING = (L_NUM_STORING - STACK_REMAINDER);
				}
				if ((GetEntityProperty(L_ITEM, "is_projectile")))
				{
					string L_FINAL_AMT = GetEntityProperty(L_ITEM, "quantity");
					L_FINAL_AMT -= L_NUM_STORING;
					string L_STR = "You add ";
					SendColoredMessage(L_PLAYER, L_STR);
					if (L_FINAL_AMT > 0)
					{
						// TODO: setquantity L_ITEM L_FINAL_AMT
					}
					else
					{
						DeleteEntity(L_ITEM);
					}
				}
				else
				{
					if ((GetEntityProperty(L_ITEM, "is_drinkable")))
					{
						string L_FINAL_AMT = GetEntityProperty(L_ITEM, "quality");
						L_FINAL_AMT -= L_NUM_STORING;
						string L_SWIGS = "swig";
						if (L_NUM_STORING > 1)
						{
							L_SWIGS += "s";
						}
						string L_STR = "You add ";
						SendColoredMessage(L_PLAYER, L_STR);
						if (L_FINAL_AMT > 0)
						{
							// TODO: setquality L_ITEM L_FINAL_AMT
						}
						else
						{
							DeleteEntity(L_ITEM);
						}
					}
					else
					{
						DeleteEntity(L_ITEM);
					}
				}
				SetPlayerQuestData(L_PLAYER, L_FREE_BANK);
				string L_MSG = "You add your ";
				SendInfoMsg(L_PLAYER, GetEntityName(GetOwner()) + L_MSG);
				ScheduleDelayedEvent(0.1, "open_chest");
				ScheduleDelayedEvent(0.55, "close_chest");
			}
		}
	}

}

}
