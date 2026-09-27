#pragma context server

namespace MS
{

class Waypoints : CGameScript
{
	string WAYPOINT_QUEST;

	Waypoints()
	{
		WAYPOINT_QUEST = "wpoint_";
	}

	void menu_choose_waypoints()
	{
		string reg.mitem.title = "Save Waypoint";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_menu_type";
		int reg.mitem.data = 12;
		string reg.mitem.title = "Load Waypoint";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_menu_type";
		int reg.mitem.data = 13;
	}

	void menu_waypoint_save()
	{
		SendColoredMessage(MY_OWNER, "Waypoints save along with the map.");
		string reg.mitem.title = "#1 Waypoint";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "save_waypoint";
		int reg.mitem.data = 0;
		string reg.mitem.title = "#2 Waypoint";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "save_waypoint";
		int reg.mitem.data = 1;
		string reg.mitem.title = "#3 Waypoint";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "save_waypoint";
		int reg.mitem.data = 2;
		string reg.mitem.title = "#4 Waypoint";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "save_waypoint";
		int reg.mitem.data = 3;
		string reg.mitem.title = "#5 Waypoint";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "save_waypoint";
		int reg.mitem.data = 4;
	}

	void save_waypoint()
	{
		string L_WAYPOINTS = GetPlayerQuestData(MY_OWNER, WAYPOINT_QUEST);
		if (L_WAYPOINTS == "0")
		{
			string L_WAYPOINTS = "0;0;0;0;0";
		}
		SetToken(L_WAYPOINTS, param2, GetEntityOrigin(MY_OWNER), ";");
		SetPlayerQuestData(MY_OWNER, WAYPOINT_QUEST);
		SendColoredMessage(MY_OWNER, "Waypoint saved.");
	}

	void menu_waypoint_load()
	{
		string L_WAYPOINTS = GetPlayerQuestData(MY_OWNER, WAYPOINT_QUEST);
		if (L_WAYPOINTS == "0")
		{
			string L_WAYPOINTS = "0;0;0;0;0";
		}
		string reg.mitem.title = "#1 Waypoint";
		if (GetToken(L_WAYPOINTS, 0, ";") != "0")
		{
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "load_waypoint";
			int reg.mitem.data = 0;
		}
		else
		{
			string reg.mitem.type = "disabled";
		}
		string reg.mitem.title = "#2 Waypoint";
		if (GetToken(L_WAYPOINTS, 1, ";") != "0")
		{
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "load_waypoint";
			int reg.mitem.data = 1;
		}
		else
		{
			string reg.mitem.type = "disabled";
		}
		string reg.mitem.title = "#3 Waypoint";
		if (GetToken(L_WAYPOINTS, 2, ";") != "0")
		{
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "load_waypoint";
			int reg.mitem.data = 2;
		}
		else
		{
			string reg.mitem.type = "disabled";
		}
		string reg.mitem.title = "#4 Waypoint";
		if (GetToken(L_WAYPOINTS, 3, ";") != "0")
		{
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "load_waypoint";
			int reg.mitem.data = 3;
		}
		else
		{
			string reg.mitem.type = "disabled";
		}
		string reg.mitem.title = "#5 Waypoint";
		if (GetToken(L_WAYPOINTS, 4, ";") != "0")
		{
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "load_waypoint";
			int reg.mitem.data = 4;
		}
		else
		{
			string reg.mitem.type = "disabled";
		}
	}

	void load_waypoint()
	{
		string L_WAYPOINTS = GetPlayerQuestData(MY_OWNER, WAYPOINT_QUEST);
		string L_POINT = GetToken(L_WAYPOINTS, param2, ";");
		SetEntityOrigin(MY_OWNER, L_POINT);
		SendColoredMessage(MY_OWNER, "Waypoint loaded.");
	}

}

}
