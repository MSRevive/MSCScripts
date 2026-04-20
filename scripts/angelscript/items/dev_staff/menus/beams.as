#pragma context server

namespace MS
{

class Beams : CGameScript
{
	string AFF_1;
	string AFF_2;
	string AFF_3;
	string MENU_TYPE;

	void menu_listbeams()
	{
		string reg.mitem.title = "Set Beam Type";
		string reg.mitem.type = "disabled";
		string reg.mitem.title = "Physgun";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_beam_type";
		int reg.mitem.data = 0;
		string reg.mitem.title = "Remover";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_beam_type";
		int reg.mitem.data = 1;
		string reg.mitem.title = "Damager";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_beam_type";
		int reg.mitem.data = 3;
		string reg.mitem.title = "Afflicter";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_beam_type";
		int reg.mitem.data = 2;
	}

	void set_beam_type()
	{
		CallExternal(MY_ITEM, "set_beam_type", param2);
		if (param2 == 2)
		{
			MENU_TYPE = 2;
			ScheduleDelayedEvent(0.1, "ext_menu_open");
		}
		else
		{
			if (param2 == 3)
			{
				MENU_TYPE = 14;
				ScheduleDelayedEvent(0.1, "ext_menu_open");
			}
		}
	}

	void menu_listafflicttype()
	{
		string reg.mitem.title = "Set Affliction Type";
		string reg.mitem.type = "disabled";
		string reg.mitem.title = "Fire";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_afflict_type";
		string reg.mitem.data = "fire";
		string reg.mitem.title = "Cold";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_afflict_type";
		string reg.mitem.data = "cold";
		string reg.mitem.title = "Lightning";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_afflict_type";
		string reg.mitem.data = "lightning";
		string reg.mitem.title = "Holy";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_afflict_type";
		string reg.mitem.data = "holy";
		string reg.mitem.title = "Poison";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_afflict_type";
		string reg.mitem.data = "poison";
		string reg.mitem.title = "Acid";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_afflict_type";
		string reg.mitem.data = "acid";
	}

	void menu_listafflictduration()
	{
		string reg.mitem.title = "Set Affliction Duration";
		string reg.mitem.type = "disabled";
		string reg.mitem.title = "5";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_afflict_duration";
		string reg.mitem.data = "5";
		string reg.mitem.title = "10";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_afflict_duration";
		string reg.mitem.data = "10";
		string reg.mitem.title = "15";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_afflict_duration";
		string reg.mitem.data = "15";
		string reg.mitem.title = "30";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_afflict_duration";
		string reg.mitem.data = "30";
	}

	void menu_listafflictdmg()
	{
		string reg.mitem.title = "Set Affliction Damage";
		string reg.mitem.type = "disabled";
		string reg.mitem.title = "0.5";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_afflict_dmg";
		string reg.mitem.data = "0.5";
		string reg.mitem.title = "5";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_afflict_dmg";
		string reg.mitem.data = "5";
		string reg.mitem.title = "20";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_afflict_dmg";
		string reg.mitem.data = "20";
		string reg.mitem.title = "50";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_afflict_dmg";
		string reg.mitem.data = "50";
		string reg.mitem.title = "100";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_afflict_dmg";
		string reg.mitem.data = "100";
		string reg.mitem.title = "500";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_afflict_dmg";
		string reg.mitem.data = "500";
		string reg.mitem.title = "1000";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_afflict_dmg";
		string reg.mitem.data = "1000";
	}

	void menu_damager_setdmg()
	{
		string reg.mitem.title = "Set Beam Damage";
		string reg.mitem.type = "disabled";
		string reg.mitem.title = "0.5";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_damager";
		string reg.mitem.data = "0.5";
		string reg.mitem.title = "5";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_damager";
		string reg.mitem.data = "5";
		string reg.mitem.title = "20";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_damager";
		string reg.mitem.data = "20";
		string reg.mitem.title = "50";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_damager";
		string reg.mitem.data = "50";
		string reg.mitem.title = "100";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_damager";
		string reg.mitem.data = "100";
		string reg.mitem.title = "500";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_damager";
		string reg.mitem.data = "500";
		string reg.mitem.title = "1000";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "set_damager";
		string reg.mitem.data = "1000";
	}

	void set_afflict_type()
	{
		AFF_1 = param2;
		MENU_TYPE = 3;
		ScheduleDelayedEvent(0.1, "ext_menu_open");
	}

	void set_afflict_duration()
	{
		AFF_2 = param2;
		MENU_TYPE = 4;
		ScheduleDelayedEvent(0.1, "ext_menu_open");
	}

	void set_afflict_dmg()
	{
		AFF_3 = param2;
		CallExternal(MY_ITEM, "set_affliction", AFF_1, AFF_2, AFF_3);
	}

	void set_damager()
	{
		CallExternal(MY_ITEM, "set_damager", param2);
	}

}

}
