#pragma context server

namespace MS
{

class Filter : CGameScript
{
	string FILTER_RESULT;
	int NUM_REMOVED;

	Filter()
	{
		const string FILTER_REJECTS = "fist_bare;pack_;sheath_;magic_hand_;item_tk_";
	}

	void func_filter_items()
	{
		string L_PLAYER = param1;
		string L_ITEMS = param2;
		for (int i = 0; i < GetTokenCount(L_ITEMS, ";"); i++)
		{
			filter_by_reject(L_ITEMS);
		}
		string L_ITEMS = FILTER_RESULT;
		NUM_REMOVED = 0;
		if (!((L_ITEMS).length()))
		{
			SendColoredMessage(L_PLAYER, "Galat's Storage cannot deposit tickets or containers.");
		}
		for (int i = 0; i < GetTokenCount(L_ITEMS, ";"); i++)
		{
			filter_by_space(L_PLAYER, L_ITEMS);
		}
		string L_ITEMS = FILTER_RESULT;
		return;
		return;
	}

	void filter_by_reject()
	{
		string L_ITEM_IDX = i;
		if (L_ITEM_IDX == 0)
		{
			FILTER_RESULT = param1;
			NUM_REMOVED = 0;
		}
		for (int i = 0; i < GetTokenCount(FILTER_REJECTS, ";"); i++)
		{
			reject_looper(L_ITEM_IDX);
		}
	}

	void reject_looper()
	{
		int L_REMOVE = 0;
		string L_IDX = param1;
		L_IDX -= NUM_REMOVED;
		string L_ITEM_SCRIPTNAME = GetToken(FILTER_RESULT, L_IDX, ";");
		if (!((L_ITEM_SCRIPTNAME !is null)))
		{
			int L_REMOVE = 1;
		}
		if ((GetEntityProperty(L_ITEM_SCRIPTNAME, "scriptvar")))
		{
			int L_REMOVE = 1;
		}
		string L_ITEM_SCRIPTNAME = GetEntityProperty(L_ITEM_SCRIPTNAME, "itemname");
		string L_FILTER = GetToken(FILTER_REJECTS, i, ";");
		if ((L_ITEM_SCRIPTNAME).findFirst(L_FILTER) >= 0)
		{
			int L_REMOVE = 1;
		}
		if ((L_REMOVE))
		{
			RemoveToken(FILTER_RESULT, L_IDX, ";");
			NUM_REMOVED += 1;
			break;
		}
	}

	void filter_by_space()
	{
		string L_ITEM_IDX = i;
		if (L_ITEM_IDX == 0)
		{
			FILTER_RESULT = param2;
			NUM_REMOVED = 0;
		}
		L_ITEM_IDX -= NUM_REMOVED;
		int L_REMOVE = 0;
		string L_PLAYER = param1;
		string L_ITEM = GetToken(FILTER_RESULT, L_ITEM_IDX, ";");
		string L_BANK = /* TODO: $func */ $func("func_get_free_bank", L_PLAYER, L_ITEM);
		if (L_BANK == "0")
		{
			string L_STR = "Your bank is too full to fit ";
			SendColoredMessage(L_PLAYER, "L_STR");
			RemoveToken(FILTER_RESULT, L_ITEM_IDX, ";");
			NUM_REMOVED += 1;
		}
	}

}

}
