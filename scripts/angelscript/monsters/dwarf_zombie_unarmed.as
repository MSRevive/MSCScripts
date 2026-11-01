#pragma context server

#include "monsters/dwarf_zombie_random.as"

namespace MS
{

class DwarfZombieUnarmed : CGameScript
{
	int WEAPON_TYPE;

	void pick_weapon_type()
	{
		WEAPON_TYPE = 0;
	}

}

}
