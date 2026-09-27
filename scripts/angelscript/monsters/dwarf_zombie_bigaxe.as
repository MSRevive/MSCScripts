#pragma context server

#include "monsters/dwarf_zombie_random.as"

namespace MS
{

class DwarfZombieBigaxe : CGameScript
{
	int WEAPON_TYPE;

	void pick_weapon_type()
	{
		WEAPON_TYPE = 2;
	}

}

}
