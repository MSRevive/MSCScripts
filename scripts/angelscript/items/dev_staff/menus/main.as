#pragma context server

#include "items/dev_staff/menus/beams.as"
#include "items/dev_staff/menus/player.as"
#include "items/dev_staff/menus/treasure.as"
#include "items/dev_staff/menus/trigger.as"
#include "items/dev_staff/menus/waypoints.as"
#include "items/dev_staff/menus/warp_player.as"

namespace MS
{

class Main : CGameScript
{
	int MENU_TYPE;
	string MY_ITEM;
	string MY_OWNER;

	Main()
	{
		MENU_TYPE = 0;
	}

	void OnSpawn() override
	{
		SetName("Jester's Staff");
		SetModel("null.mdl");
		SetRace("beloved");
		SetInvincible(true);
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_ITEM = param2;
	}

	void game_menu_getoptions()
	{
		if (!(param1 == MY_OWNER)) return;
		if (MENU_TYPE == 0)
		{
			menu_main();
		}
		if (MENU_TYPE == 1)
		{
			menu_listbeams();
		}
		if (MENU_TYPE == 2)
		{
			menu_listafflicttype();
		}
		if (MENU_TYPE == 3)
		{
			menu_listafflictduration();
		}
		if (MENU_TYPE == 4)
		{
			menu_listafflictdmg();
		}
		if (MENU_TYPE == 5)
		{
			menu_playerlist();
		}
		if (MENU_TYPE == 6)
		{
			menu_playerlevels();
		}
		if (MENU_TYPE == 7)
		{
			menu_addgold();
		}
		if (MENU_TYPE == 8)
		{
			menu_treasure();
		}
		if (MENU_TYPE == 9)
		{
			menu_treasure_weapons();
		}
		if (MENU_TYPE == 10)
		{
			menu_trigger();
		}
		if (MENU_TYPE == 11)
		{
			menu_trigger_successful();
		}
		if (MENU_TYPE == 12)
		{
			menu_waypoint_save();
		}
		if (MENU_TYPE == 13)
		{
			menu_waypoint_load();
		}
		if (MENU_TYPE == 14)
		{
			menu_damager_setdmg();
		}
		if (MENU_TYPE == 15)
		{
			menu_tele_mode();
		}
		if (MENU_TYPE == 16)
		{
			menu_tele_player();
		}
		if (MENU_TYPE == 17)
		{
			menu_choose_waypoints();
		}
	}

	void menu_main()
	{
		string reg.mitem.title = "Spawn Galat Chest";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "spawn_galats";
		string reg.mitem.title = "Change Beam Type";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_menu_type";
		int reg.mitem.data = 1;
		string reg.mitem.title = "Player Attributes";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_menu_type";
		int reg.mitem.data = 5;
		string reg.mitem.title = "Spawn Items";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_menu_type";
		int reg.mitem.data = 8;
		string reg.mitem.title = "Use Trigger";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_menu_type";
		int reg.mitem.data = 10;
		string reg.mitem.title = "Waypoints";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_menu_type";
		int reg.mitem.data = 17;
		string reg.mitem.title = "Warp other Player";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_menu_type";
		int reg.mitem.data = 15;
	}

	void set_menu_type()
	{
		MENU_TYPE = param2;
		ScheduleDelayedEvent(0.1, "ext_menu_open");
	}

	void ext_menu_open()
	{
		OpenMenu(MY_OWNER);
	}

	void ext_menu_main()
	{
		MENU_TYPE = 0;
		ScheduleDelayedEvent(0.1, "ext_menu_open");
	}

	void spawn_galats()
	{
		string OWNER_POS = GetEntityOrigin(MY_OWNER);
		string OWNER_YAW = GetEntityProperty(MY_OWNER, "angles.yaw");
		string SPAWN_POS = OWNER_POS;
		SPAWN_POS += /* TODO: $relpos */ $relpos(Vector3(0, OWNER_YAW, 0), Vector3(0, 64, 0));
		SpawnNPC("chests/bank1", SPAWN_POS, ScriptMode::Legacy); // params: MY_OWNER
	}

}

}
