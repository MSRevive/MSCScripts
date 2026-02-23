#pragma context server

namespace MS
{

class Debug : CGameScript
{
	string DUMP_ARRAY_CALLER;
	string DUMP_ARRAY_GLOBAL;
	string DUMP_ARRAY_NAME;

	void bd_debug()
	{
		string L_DEBUG_CALLER = param1;
		string L_DEBUG_TYPE = param2;
		string L_EXTRA_EVENT = "none";
		string L_OUT_MSG = GetEntityName(GetOwner());
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
		if (L_DEBUG_TYPE == "garray")
		{
			L_OUT_MSG += "g_Array ";
			L_OUT_MSG += param3;
			L_OUT_MSG += "#";
			L_OUT_MSG += param4;
			L_OUT_MSG += " is ";
			L_OUT_MSG += /* TODO: $g_get_array */ $g_get_array(param3, param4);
			int L_PROCESSED = 1;
		}
		if (L_DEBUG_TYPE == "darray")
		{
			L_OUT_MSG += "Dumping Array: ";
			L_OUT_MSG += param3;
			DUMP_ARRAY_NAME = param3;
			DUMP_ARRAY_GLOBAL = 0;
			DUMP_ARRAY_CALLER = L_DEBUG_CALLER;
			string L_EXTRA_EVENT = "dbg_dump_array";
			int L_PROCESSED = 1;
		}
		if (L_DEBUG_TYPE == "dgarray")
		{
			L_OUT_MSG += "Dumping Global Array: ";
			L_OUT_MSG += param3;
			DUMP_ARRAY_NAME = param3;
			DUMP_ARRAY_GLOBAL = 1;
			DUMP_ARRAY_CALLER = L_DEBUG_CALLER;
			string L_EXTRA_EVENT = "dbg_dump_array";
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
			if (param2 == "PARAM2")
			{
				L_OUT_MSG += "exists";
			}
			else
			{
				L_OUT_MSG += param2;
				if (param3 != "PARAM3")
				{
					if (param4 == "PARAM4")
					{
					}
					L_OUT_MSG += "->";
					L_OUT_MSG += param3;
					L_OUT_MSG += "=";
					L_OUT_MSG += GetEntityProperty(param2, "param3");
				}
				if (param4 != "PARAM4")
				{
					L_OUT_MSG += "->";
					L_OUT_MSG += param3;
					L_OUT_MSG += "[";
					L_OUT_MSG += param4;
					L_OUT_MSG += "]=";
					L_OUT_MSG += GetEntityProperty(param2, "param3");
				}
			}
			int L_PROCESSED = 1;
		}
		CallExternal(L_DEBUG_CALLER, "ext_debug_que", L_OUT_MSG);
		if (!(L_EXTRA_EVENT != "none")) return;
		L_EXTRA_EVENT();
	}

	void dbg_dump_array()
	{
		if ((DUMP_ARRAY_GLOBAL))
		{
			string L_N_ELEMENTS = /* TODO: $g_get_array_amt */ $g_get_array_amt(DUMP_ARRAY_NAME);
		}
		else
		{
			string L_N_ELEMENTS = /* TODO: $get_array_amt */ $get_array_amt(DUMP_ARRAY_NAME);
		}
		LogDebug("dbg_dump_array L_N_ELEMENTS of DUMP_ARRAY_NAME to GetEntityName(DUMP_ARRAY_CALLER)");
		for (int i = 0; i < L_N_ELEMENTS; i++)
		{
			dbg_dump_array_elements();
		}
	}

	void dbg_dump_array_elements()
	{
		string CUR_IDX = i;
		if ((DUMP_ARRAY_GLOBAL))
		{
			string L_ELEMENT = /* TODO: $g_get_array */ $g_get_array(DUMP_ARRAY_NAME, CUR_IDX);
		}
		else
		{
			string L_ELEMENT = /* TODO: $get_array */ $get_array(DUMP_ARRAY_NAME, CUR_IDX);
		}
		string L_OUT_MSG = "#";
		L_OUT_MSG += int(CUR_IDX);
		L_OUT_MSG += " ";
		L_OUT_MSG += L_ELEMENT;
		CallExternal(DUMP_ARRAY_CALLER, "ext_debug_que", L_OUT_MSG);
	}

}

}
