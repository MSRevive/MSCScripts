#pragma context server

namespace MS
{

class Treasure : CGameScript
{
	void menu_treasure()
	{
		string reg.mitem.title = "Weapons";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_menu_type";
		int reg.mitem.data = 9;
		string reg.mitem.title = "Armor";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "create_treasure";
		string reg.mitem.data = "items/dev_staff/chests/armor";
		string reg.mitem.title = "Ammunition";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "create_treasure";
		string reg.mitem.data = "items/dev_staff/chests/ammo";
		string reg.mitem.title = "Rings";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "create_treasure";
		string reg.mitem.data = "items/dev_staff/chests/rings";
		string reg.mitem.title = "Packs";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "create_treasure";
		string reg.mitem.data = "items/dev_staff/chests/packs";
		string reg.mitem.title = "Potions";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "create_treasure";
		string reg.mitem.data = "items/dev_staff/chests/potions";
		string reg.mitem.title = "Quest Items";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "create_treasure";
		string reg.mitem.data = "items/dev_staff/chests/quest";
	}

	void menu_treasure_weapons()
	{
		string reg.mitem.title = "Swords";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "create_treasure";
		string reg.mitem.data = "items/dev_staff/chests/swords";
		string reg.mitem.title = "Martial Arts";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "create_treasure";
		string reg.mitem.data = "items/dev_staff/chests/martialarts";
		string reg.mitem.title = "Small Arms";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "create_treasure";
		string reg.mitem.data = "items/dev_staff/chests/smallarms";
		string reg.mitem.title = "Axes";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "create_treasure";
		string reg.mitem.data = "items/dev_staff/chests/axes";
		string reg.mitem.title = "Blunt Arms";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "create_treasure";
		string reg.mitem.data = "items/dev_staff/chests/bluntarms";
		string reg.mitem.title = "Archery";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "create_treasure";
		string reg.mitem.data = "items/dev_staff/chests/archery";
		string reg.mitem.title = "Magic";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "create_treasure";
		string reg.mitem.data = "items/dev_staff/chests/magic";
		string reg.mitem.title = "Polearms";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "create_treasure";
		string reg.mitem.data = "items/dev_staff/chests/polearms";
	}

	void create_treasure()
	{
		string OWNER_POS = GetEntityOrigin(MY_OWNER);
		string OWNER_YAW = GetEntityProperty(MY_OWNER, "angles.yaw");
		string SPAWN_POS = OWNER_POS;
		SPAWN_POS += /* TODO: $relpos */ $relpos(Vector3(0, OWNER_YAW, 0), Vector3(0, 64, 0));
		SpawnNPC(param2, SPAWN_POS, ScriptMode::Legacy); // params: MY_OWNER
	}

}

}
