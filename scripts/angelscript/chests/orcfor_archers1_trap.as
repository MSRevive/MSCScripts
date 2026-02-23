#pragma context server

#include "chests/orcfor_base.as"

namespace MS
{

class OrcforArchers1Trap : CGameScript
{
	int SET_TRAP;

	void chest_additems()
	{
		add_gold(/* TODO: $math(multiply) */ 100);
		if (G_GAVE_ARTI1 == 1)
		{
			add_good_item();
			add_good_arrows();
		}
		if (G_GAVE_ARTI1 == 2)
		{
			add_great_item();
			add_great_arrows();
		}
		if (G_GAVE_ARTI1 == 3)
		{
			add_great_item();
			add_great_arrows();
			add_great_arrows();
			add_epic_arrows();
		}
		if (G_GAVE_ARTI1 == 4)
		{
			add_epic_arrows();
			add_epic_arrows();
		}
		if (G_GAVE_ARTI1 == 5)
		{
			add_epic_arrows();
			add_epic_arrows();
		}
		if (G_GAVE_ARTI1 > 5)
		{
			add_epic_arrows();
			add_epic_arrows();
			add_epic_arrows();
		}
	}

	void OnUse(CBaseEntity@ activator, CBaseEntity@ caller, int useType) override
	{
		if ((SET_TRAP)) return;
		SET_TRAP = 1;
		string MSG_TITLE = GetEntityName(param1);
		MSG_TITLE += " has triggered a trap!";
		SendInfoMsg("all", "MSG_TITLE Oh noes!");
		UseTrigger("spawn_archers1_trap");
	}

}

}
