#pragma context server

namespace MS
{

class ElementResist : CGameScript
{
	string ELM_REGISTER_SILENT;
	string OLD_RESISTANCES;
	int PLR_CHECK_WEAPON_RESIST;
	string PLR_RESIST_ELEMENTS;
	int PLR_RESIST_UPDATE_FLAG;
	string PLR_RESIST_VALUES;

	ElementResist()
	{
		if (!(/* TODO: $get_array_exists */ $get_array_exists(PLR_RESIST_NAMES)))
		{
			array<string> PLR_RESIST_NAMES;
			array<string> PLR_RESIST_TYPES;
			array<string> PLR_RESIST_AMTS;
			array<string> PLR_RESIST_WEAPON_IDS;
			array<string> PLR_RESIST_WEAPON_TAGS;
		}
		PLR_RESIST_ELEMENTS = "fire;lightning;cold;earth;poison;acid;holy;dark;magic;slash;blunt;pierce;all";
		PLR_RESIST_VALUES = "1.0;1.0;1.0;1.0;1.0;1.0;1.0;1.0;1.0;1.0;1.0;1.0;1.0";
		PLR_CHECK_WEAPON_RESIST = 0;
		const string PLR_RESIST_RESET = "1.0;1.0;1.0;1.0;1.0;1.0;1.0;1.0;1.0;1.0;1.0;1.0;1.0";
	}

	void ext_register_element()
	{
		string RESIST_NAME = param1;
		string RESIST_TYPE = param2;
		string RESIST_AMT = param3;
		string FIND_NAME = /* TODO: $get_arrayfind */ $get_arrayfind(PLR_RESIST_NAMES, RESIST_NAME);
		if (RESIST_TYPE == "remove")
		{
			if (FIND_NAME != -1)
			{
				PLR_RESIST_NAMES.removeAt(FIND_NAME);
				PLR_RESIST_TYPES.removeAt(FIND_NAME);
				PLR_RESIST_AMTS.removeAt(FIND_NAME);
				update_resistances();
			}
		}
		else
		{
			RESIST_AMT *= 0.01;
			if (FIND_NAME != -1)
			{
				string OLD_VALUE = /* TODO: $get_arrayfind */ $get_arrayfind(PLR_RESIST_AMTS, FIND_NAME);
				if (OLD_VALUE != RESIST_AMT)
				{
					PLR_RESIST_AMTS[FIND_NAME] = RESIST_AMT;
				}
			}
			else
			{
				PLR_RESIST_NAMES.insertLast(RESIST_NAME);
				PLR_RESIST_TYPES.insertLast(RESIST_TYPE);
				PLR_RESIST_AMTS.insertLast(RESIST_AMT);
			}
			update_resistances();
		}
	}

	void update_resistances()
	{
		PLR_RESIST_UPDATE_FLAG = 0;
		OLD_RESISTANCES = PLR_RESIST_VALUES;
		PLR_RESIST_VALUES = PLR_RESIST_RESET;
		for (int i = 0; i < /* TODO: $get_array_amt */ $get_array_amt(PLR_RESIST_NAMES); i++)
		{
			cat_resistances();
		}
		for (int i = 0; i < GetTokenCount(PLR_RESIST_VALUES, ";"); i++)
		{
			apply_resistances();
		}
	}

	void cat_resistances()
	{
		string CUR_IDX = i;
		string ITEM_RESIST_TYPE = /* TODO: $get_array */ $get_array(PLR_RESIST_TYPES, CUR_IDX);
		string ITEM_RESIST_AMT = /* TODO: $get_array */ $get_array(PLR_RESIST_AMTS, CUR_IDX);
		string ITEM_RESIST_AMT = /* TODO: $neg */ $neg(ITEM_RESIST_AMT);
		string CUR_RESIST_IDX = FindToken(PLR_RESIST_ELEMENTS, ITEM_RESIST_TYPE, ";");
		string CUR_RESIST_AMT = GetToken(PLR_RESIST_VALUES, CUR_RESIST_IDX, ";");
		CUR_RESIST_AMT += ITEM_RESIST_AMT;
		if (CUR_RESIST_AMT < 0)
		{
			int CUR_RESIST_AMT = 0;
		}
		SetToken(PLR_RESIST_VALUES, CUR_RESIST_IDX, CUR_RESIST_AMT, ";");
	}

	void apply_resistances()
	{
		string CUR_IDX = i;
		string CUR_RESIST_TYPE = GetToken(PLR_RESIST_ELEMENTS, CUR_IDX, ";");
		string CUR_RESIST_AMT = GetToken(PLR_RESIST_VALUES, CUR_IDX, ";");
		SetDamageResistance(CUR_RESIST_TYPE, CUR_RESIST_AMT);
		string OLD_RESIST_AMT = GetToken(OLD_RESISTANCES, CUR_IDX, ";");
		if (CUR_RESIST_AMT != OLD_RESIST_AMT)
		{
			CUR_RESIST_AMT *= 100;
			CUR_RESIST_AMT -= 100;
			string CUR_RESIST_AMT = /* TODO: $neg */ $neg(CUR_RESIST_AMT);
			string CUR_RESIST_AMT = int(CUR_RESIST_AMT);
			CUR_RESIST_AMT += "%";
			if (!(ELM_REGISTER_SILENT))
			{
				SendColoredMessage(GetOwner(), "Your resistance to CUR_RESIST_TYPE is now CUR_RESIST_AMT");
			}
			ELM_REGISTER_SILENT = 0;
		}
	}

	void ext_register_weapon()
	{
		string WEAPON_ID = param1;
		string OUT_TAG = param2;
		string OUT_ELM = param3;
		string OUT_AMT = param4;
		if (param3 != "remove")
		{
			if (/* TODO: $get_arrayfind */ $get_arrayfind(PLR_RESIST_WEAPON_IDS, param1) == -1)
			{
				ext_register_element(OUT_TAG, OUT_ELM, OUT_AMT);
				PLR_RESIST_WEAPON_IDS.insertLast(WEAPON_ID);
				PLR_RESIST_WEAPON_TAGS.insertLast(OUT_TAG);
			}
		}
		else
		{
			ext_register_element(OUT_TAG, "remove");
			string WEAPON_IDX = /* TODO: $get_arrayfind */ $get_arrayfind(PLR_RESIST_WEAPON_IDS, param1);
			PLR_RESIST_WEAPON_IDS.removeAt(WEAPON_IDX);
			PLR_RESIST_WEAPON_TAGS.removeAt(WEAPON_IDX);
		}
		if ((PLR_RESIST_WEAPON_IDS).length() >= 3)
		{
			if (!(PLR_CHECK_WEAPON_RESIST))
			{
			}
			PLR_CHECK_WEAPON_RESIST = 1;
			check_weapons_loop();
		}
		else
		{
			PLR_CHECK_WEAPON_RESIST = 0;
		}
	}

	void check_weapons_loop()
	{
		if (!(PLR_CHECK_WEAPON_RESIST)) return;
		ScheduleDelayedEvent(5.0, "check_weapons_loop");
		if (!(PLR_IN_WORLD)) return;
		if (!(IsEntityAlive(GetOwner()))) return;
		string N_RESIST_WEAPONS = /* TODO: $get_array_amt */ $get_array_amt(PLR_RESIST_WEAPON_IDS);
		if (N_RESIST_WEAPONS > 0)
		{
			for (int i = 0; i < /* TODO: $get_array_amt */ $get_array_amt(PLR_RESIST_WEAPON_IDS); i++)
			{
				check_weapons();
			}
		}
		if ((PLR_RESIST_WEAPON_IDS).length() < 3)
		{
			PLR_CHECK_WEAPON_RESIST = 0;
		}
	}

	void check_weapons()
	{
		string CUR_WEAPON = /* TODO: $get_array */ $get_array(PLR_RESIST_WEAPON_IDS, i);
		if (CUR_WEAPON == PLR_LEFT_HAND)
		{
			int NO_REMOVE = 1;
		}
		if (CUR_WEAPON == PLR_RIGHT_HAND)
		{
			int NO_REMOVE = 1;
		}
		if ((NO_REMOVE)) return;
		ext_register_element(/* TODO: $get_array */ $get_array(PLR_RESIST_WEAPON_TAGS, CUR_WEAPON), "remove");
		PLR_RESIST_WEAPON_IDS.removeAt(CUR_WEAPON);
		PLR_RESIST_WEAPON_TAGS.removeAt(CUR_WEAPON);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ext_register_element("firep", "remove");
		ext_register_element("coldp", "remove");
		ext_register_element("ligip", "remove");
		ext_register_element("firip", "remove");
		ext_register_element("colip", "remove");
		ext_register_element("poiip", "remove");
	}

}

}
