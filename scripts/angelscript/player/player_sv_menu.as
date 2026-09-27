#pragma context server

namespace MS
{

class PlayerSvMenu : CGameScript
{
	int PLR_CHECK_SUMMON_ACTIVE;
	string PLR_CHECK_SUMMON_ACTIVE_TYPE;
	string PLR_PET_LIST;

	void OnSpawn() override
	{
		SetMenuAutoOpen(1);
	}

	void game_menu_getoptions()
	{
		if (GetEntityIndex(GetOwner()) == param1)
		{
			menu_self();
		}
		else
		{
			menu_other(param1);
		}
	}

	void menu_self()
	{
		if (!(GetEntityProperty(GetOwner(), "sitting")))
		{
			string reg.mitem.title = "Sit Down (Rest)";
		}
		else
		{
			string reg.mitem.title = "Stand Up";
		}
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "plr_menu_emote";
		string reg.mitem.data = "player_sitstand";
		if (!(GetEntityProperty(GetOwner(), "sitting")))
		{
			string reg.mitem.title = "Emote: Nod Yes";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "plr_menu_emote";
			string reg.mitem.data = "player_nodyes";
			string reg.mitem.title = "Emote: Nod No";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "plr_menu_emote";
			string reg.mitem.data = "player_nodno";
			string reg.mitem.title = "Emote: Stand At Attention";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "plr_menu_emote";
			string reg.mitem.data = "player_standidle";
		}
		string reg.mitem.id = "itemdesc";
		string reg.mitem.title = "Item Desc";
		string reg.mitem.type = "itemdesc";
		string reg.mitem.id = "forgive";
		string reg.mitem.title = "Forgive Last PK";
		string reg.mitem.type = "forgive";
		PLR_PET_LIST = GetPlayerQuestData(GetOwner(), "pets");
		if (PLR_PET_LIST != 0)
		{
			for (int i = 0; i < GetTokenCount(PLR_PET_LIST, ";"); i++)
			{
				list_summons();
			}
		}
		if (GetTokenCount(PLR_ACTIVE_PETS, ";") > 0)
		{
			for (int i = 0; i < GetTokenCount(PLR_ACTIVE_PETS, ";"); i++)
			{
				list_unsummons();
			}
		}
	}

	void menu_other()
	{
		if (!(G_DEVELOPER_MODE)) return;
	}

	void menu_give_item()
	{
	}

	void list_summons()
	{
		string PET_TYPE = GetToken(PLR_PET_LIST, i, ";");
		PLR_CHECK_SUMMON_ACTIVE = 0;
		PLR_CHECK_SUMMON_ACTIVE_TYPE = PET_TYPE;
		for (int i = 0; i < GetTokenCount(PLR_ACTIVE_PET_TYPES, ";"); i++)
		{
			list_summons_check_active();
		}
		if ((PLR_CHECK_SUMMON_ACTIVE)) return;
		string reg.mitem.title = "Summon pet ";
		if (PET_TYPE == "pet_wolf")
		{
			string PET_NAME = "wolf";
		}
		if (PET_TYPE == "pet_wolf_ice")
		{
			string PET_NAME = "ice wolf";
		}
		if (PET_TYPE == "pet_wolf_shadow")
		{
			string PET_NAME = "shadow wolf";
		}
		reg.mitem.title += PET_NAME;
		string reg.mitem.type = "callback";
		string reg.mitem.data = PET_TYPE;
		string reg.mitem.callback = "ext_summon_pets_new";
		if (GetGameTime() < PLR_SUMMON_MENU_DISABLE)
		{
			string reg.mitem.title = "(5 Second Pet Summon Delay)";
			string reg.mitem.type = "disabled";
		}
	}

	void list_summons_check_active()
	{
		string CUR_SUMMON = GetToken(PLR_ACTIVE_PET_TYPES, i, ";");
		if ((PLR_CHECK_SUMMON_ACTIVE_TYPE).findFirst(CUR_SUMMON) >= 0)
		{
			PLR_CHECK_SUMMON_ACTIVE = 1;
		}
	}

	void list_unsummons()
	{
		LogDebug("PLR_ACTIVE_PETS");
		string PET_ID = GetToken(PLR_ACTIVE_PETS, i, ";");
		if (!(IsEntityAlive(PET_ID))) return;
		string reg.mitem.title = "Unsummon ";
		reg.mitem.title += GetEntityProperty(PET_ID, "scriptvar");
		string reg.mitem.type = "callback";
		string reg.mitem.data = PET_ID;
		string reg.mitem.callback = "ext_unsummon_pets_new";
		if (GetGameTime() < PLR_SUMMON_MENU_DISABLE)
		{
			string reg.mitem.title = "(5 Second Pet Summon Delay)";
			string reg.mitem.type = "disabled";
		}
	}

	void plr_menu_emote()
	{
		string CMD_STRING = "action ";
		CMD_STRING += param2;
		ClientCommand(GetOwner(), CMD_STRING);
	}

}

}
