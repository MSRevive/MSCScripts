#pragma context server

#include "chests/orcfor_base.as"

namespace MS
{

class OrcforCaves : CGameScript
{
	int SET_TRAP;

	void chest_additems()
	{
		add_gold(/* TODO: $math(multiply) */ 100);
		add_epic_item();
	}

	void OnUse(CBaseEntity@ activator, CBaseEntity@ caller, int useType) override
	{
		if ((SET_TRAP)) return;
		SET_TRAP = 1;
		string MSG_TITLE = GetEntityName(param1);
		MSG_TITLE += " has triggered a trap!";
		SendInfoMsg("all", "MSG_TITLE Oh noes!");
		UseTrigger("spawn_cave_trap");
	}

}

}
