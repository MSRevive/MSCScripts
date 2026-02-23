#pragma context server

#include "NPCs/dwarf_lantern.as"

namespace MS
{

class DwarfLanternStill : CGameScript
{
	DwarfLanternStill()
	{
		const int NO_WANDER = 1;
	}

	void dwarf_spawn()
	{
		SetRoam(false);
		set_npc_turret();
	}

}

}
