#pragma context server

namespace MS
{

class Player : CGameScript
{
	void menu_playerlist()
	{
		string reg.mitem.title = "Loreldian Soup (Godmode)";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "toggle_soup";
		string reg.mitem.title = "Invisibility Potion (Notarget)";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "toggle_notarget";
		string reg.mitem.title = "Set Levels";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_menu_type";
		int reg.mitem.data = 6;
		string reg.mitem.title = "Add Gold";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_menu_type";
		int reg.mitem.data = 7;
		string reg.mitem.title = "Set Respawn Here";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_respawn";
	}

	void toggle_soup()
	{
		if ((GetEntityProperty(MY_OWNER, "haseffect")))
		{
			SendColoredMessage(MY_OWNER, "Removed Loreldian Soup effect.");
			CallExternal(MY_OWNER, "ext_remove_lsoup");
		}
		else
		{
			SendColoredMessage(MY_OWNER, "Applied Loreldian Soup effect.");
			ApplyEffect(MY_OWNER, "items/dev_staff/effects/loreldian_soup");
		}
	}

	void toggle_notarget()
	{
		if ((GetEntityProperty(MY_OWNER, "scriptvar")))
		{
			SendColoredMessage(MY_OWNER, "Enemies will now target you.");
			CallExternal(MY_OWNER, "ext_invalidate", 0);
		}
		else
		{
			SendColoredMessage(MY_OWNER, "Enemies have stopped targeting you.");
			CallExternal(MY_OWNER, "ext_invalidate", 1);
		}
	}

	void menu_playerlevels()
	{
		string reg.mitem.title = "1";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "setlevels";
		int reg.mitem.data = 1;
		string reg.mitem.title = "5";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "setlevels";
		int reg.mitem.data = 5;
		string reg.mitem.title = "10";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "setlevels";
		int reg.mitem.data = 10;
		string reg.mitem.title = "15";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "setlevels";
		int reg.mitem.data = 15;
		string reg.mitem.title = "20";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "setlevels";
		int reg.mitem.data = 20;
		string reg.mitem.title = "25";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "setlevels";
		int reg.mitem.data = 25;
		string reg.mitem.title = "30";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "setlevels";
		int reg.mitem.data = 30;
		string reg.mitem.title = "35";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "setlevels";
		int reg.mitem.data = 35;
		string reg.mitem.title = "75";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "setlevels";
		int reg.mitem.data = 75;
	}

	void setlevels()
	{
		CallExternal(MY_OWNER, "ext_setstats", param2);
		SendColoredMessage(MY_OWNER, "Set all levels to: " + param2);
		HealEntity(MY_OWNER, 10000);
		GiveMP(MY_OWNER);
	}

	void menu_addgold()
	{
		string reg.mitem.title = "100";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "addgold";
		int reg.mitem.data = 100;
		string reg.mitem.title = "10000";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "addgold";
		int reg.mitem.data = 10000;
		string reg.mitem.title = "1000000";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "addgold";
		int reg.mitem.data = 1000000;
		string reg.mitem.title = "999999999";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "addgold";
		int reg.mitem.data = 999999999;
	}

	void addgold()
	{
		CallExternal(MY_OWNER, "ext_addgold", param2);
	}

	void set_respawn()
	{
		CallExternal(MY_OWNER, "set_spawn_point", GetEntityOrigin(MY_OWNER));
		SendColoredMessage(MY_OWNER, "Respawn point set.");
	}

}

}
