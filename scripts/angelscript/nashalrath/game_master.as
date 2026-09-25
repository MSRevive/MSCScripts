#pragma context server

namespace MS
{

class GameMaster : CGameScript
{
	string GM_LAST_PLAYER;
	string GM_NASH_KEYS;
	string GM_NASH_KEYS_DONE;
	string GM_NEXT_NASH_MSG;
	string GM_TEAR_TRACKER;

	void gm_nash_tear()
	{
		CallExternal(FindEntityByName("metal_cave"), "ext_refresh_cl_fx");
		if (GM_TEAR_TRACKER == "GM_TEAR_TRACKER")
		{
			GM_TEAR_TRACKER = "";
		}
		if ((GM_TEAR_TRACKER).findFirst(param1) >= 0)
		{
			SendColoredMessage(param1, "Exiting reality tear...");
			string L_TOKEN_IDX = FindToken(GM_TEAR_TRACKER, param1, ";");
			RemoveToken(GM_TEAR_TRACKER, L_TOKEN_IDX, ";");
			int EXIT_SUB = 1;
		}
		else
		{
			SendColoredMessage(param1, "Entering reality tear...");
		}
		if ((EXIT_SUB)) return;
		if (GM_TEAR_TRACKER.length() > 0) GM_TEAR_TRACKER += ";";
		GM_TEAR_TRACKER += param1;
		SendInfoMsg(param1, "TEAR IN REALITY A tear in reality from the Wars of Fate. Apparently, the Lost Loreldians here never mended this one.");
	}

	void gm_nash_cryskey_found()
	{
		if (GM_NASH_KEYS == "GM_NASH_KEYS")
		{
			GM_NASH_KEYS = 0;
		}
		GM_NASH_KEYS += 1;
		SendInfoMsg(param1, "ARTIFACT FOUND You've found an ancient Loreldian crystal key.");
	}

	void gm_crys_key_activate()
	{
		LogDebug("gm_crys_key_activate PARAM2");
		if ((GM_NASH_KEYS_DONE)) return;
		string L_KEY_IDX = param2;
		if (L_KEY_IDX == 1)
		{
			if ((GM_NASH_KEY1_USED))
			{
			}
			int EXIT_SUB = 1;
		}
		if (L_KEY_IDX == 2)
		{
			if ((GM_NASH_KEY2_USED))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GM_NASH_KEYS == 0)
		{
			if (param1 == GM_LAST_PLAYER)
			{
				if (GetGameTime() < GM_NEXT_NASH_MSG)
				{
				}
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			GM_NEXT_NASH_MSG = GetGameTime();
			GM_NEXT_NASH_MSG += 10.0;
			GM_LAST_PLAYER = param1;
			SendInfoMsg(param1, "CRYSTAL SOCKET KEYHOLE This appears to be a crystal shaped socket.");
		}
		else
		{
			if (GM_NASH_KEYS_USED == "GM_NASH_KEYS_USED")
			{
				GM_NASH_KEYS_USED = 0;
			}
			GM_NASH_KEYS_USED += 1;
			GM_NASH_KEYS -= 1;
			if (L_KEY_IDX == 1)
			{
				UseTrigger("rend_key1_on");
				GM_NASH_KEY1_USED = 1;
			}
			if (L_KEY_IDX == 2)
			{
				UseTrigger("rend_key2_on");
				GM_NASH_KEY2_USED = 1;
			}
			SendColoredMessage(param1, "You insert the Loreldian crystal into the socket.");
			if (GM_NASH_KEYS_USED == 2)
			{
			}
			UseTrigger("brk_lordoor");
			GM_NASH_KEYS_DONE = 1;
			CallExternal(FindEntityByName("metal_cave"), "ext_clearout");
		}
	}

}

}
