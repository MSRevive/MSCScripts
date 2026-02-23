#pragma context server

namespace MS
{

class ItemDebug : CGameScript
{
	string BITEM_DEBUG_CALLER;
	string BITEM_DEBUG_OUT;

	void item_debug2()
	{
		if (!(GetGameTime() > 5.0)) return;
		string L_DEBUG_CALLER = param1;
		string L_DEBUG_TYPE = param2;
		if (!(GetEntityProperty(L_DEBUG_CALLER, "scriptvar"))) return;
		string L_OUT_MSG = GetEntityProperty(GetOwner(), "itemname");
		L_OUT_MSG += "[";
		L_OUT_MSG += GetEntityIndex(GetOwner());
		L_OUT_MSG += "]: ";
		if (L_DEBUG_TYPE == "array")
		{
			L_OUT_MSG += "Array ";
			L_OUT_MSG += param3;
			L_OUT_MSG += "#";
			L_OUT_MSG += param4;
			L_OUT_MSG += " is ";
			L_OUT_MSG += /* TODO: $get_array */ $get_array(param3, param4);
			int L_PROCESSED = 1;
		}
		if (L_DEBUG_TYPE == "var")
		{
			L_OUT_MSG += "var ";
			L_OUT_MSG += param3;
			L_OUT_MSG += " prop ";
			L_OUT_MSG += GetEntityProperty(param3, "param4");
			int L_PROCESSED = 1;
		}
		if (!(L_PROCESSED))
		{
			if ((param2).findFirst("PARAM") == 0)
			{
				L_OUT_MSG += "exists";
			}
			else
			{
				L_OUT_MSG += param2;
				if ((param3).findFirst("PARAM") == 0)
				{
					L_OUT_MSG += "->";
					L_OUT_MSG += param3;
					L_OUT_MSG += "=";
					L_OUT_MSG += GetEntityProperty(param2, "param3");
				}
				if ((param4).findFirst("PARAM") == 0)
				{
					L_OUT_MSG += ",";
					L_OUT_MSG += GetEntityProperty(param2, "param3");
					string L_PROP = GetEntityProperty(param2, "param3");
					L_OUT_MSG += "->";
					L_OUT_MSG += param4;
					L_OUT_MSG += "=";
					L_OUT_MSG += GetEntityProperty(L_PROP, "param4");
					L_OUT_MSG += " (scriptvar:";
					L_OUT_MSG += GetEntityProperty(L_PROP, "scriptvar");
					L_OUT_MSG += ")";
				}
			}
		}
		if (GetGameTime() < G_NEXT_IDEBUG_CALL)
		{
			BITEM_DEBUG_OUT = L_OUT_MSG;
			BITEM_DEBUG_CALLER = L_DEBUG_CALLER;
			G_NEXT_IDEBUG_CALL += 0.1;
			/* TODO: $math(subtract) */ G_NEXT_IDEBUG_CALL("item_debug_delay");
		}
		else
		{
			SetGlobalVar("G_NEXT_IDEBUG_CALL", GetGameTime());
			G_NEXT_IDEBUG_CALL += 0.1;
			CallExternal(L_DEBUG_CALLER, "ext_debug_que", L_OUT_MSG);
		}
	}

	void item_debug_delay()
	{
		CallExternal(BITEM_DEBUG_CALLER, "ext_debug_que", BITEM_DEBUG_OUT);
	}

	void clitem_debug()
	{
		string L_DEBUG_CALLER = param1;
		if (!(/* TODO: $getcl */ $getcl(L_DEBUG_CALLER, "isplayer"))) return;
		if (!("game.localplayer.index" == L_DEBUG_CALLER)) return;
		string L_DEBUG_TYPE = param2;
		string L_OUT_MSG = "CLIENT:";
		L_OUT_MSG += currentscript;
		L_OUT_MSG += ":";
		if (L_DEBUG_TYPE == "array")
		{
			L_OUT_MSG += "Array ";
			L_OUT_MSG += param3;
			L_OUT_MSG += "#";
			L_OUT_MSG += param4;
			L_OUT_MSG += " is ";
			L_OUT_MSG += /* TODO: $get_array */ $get_array(param3, param4);
			int L_PROCESSED = 1;
		}
		if (L_DEBUG_TYPE == "var")
		{
			L_OUT_MSG += "var ";
			L_OUT_MSG += param3;
			L_OUT_MSG += " prop ";
			L_OUT_MSG += /* TODO: $getcl */ $getcl(param3, param4);
			int L_PROCESSED = 1;
		}
		if (!(L_PROCESSED))
		{
			if ((param2).findFirst("PARAM") == 0)
			{
				L_OUT_MSG += "exists";
			}
			else
			{
				L_OUT_MSG += param2;
				if ((param3).findFirst("PARAM") == 0)
				{
					L_OUT_MSG += "->";
					L_OUT_MSG += param3;
					L_OUT_MSG += "=";
					L_OUT_MSG += /* TODO: $getcl */ $getcl(param2, param3);
				}
			}
			int L_PROCESSED = 1;
		}
		LogDebug("L_OUT_MSG");
	}

}

}
