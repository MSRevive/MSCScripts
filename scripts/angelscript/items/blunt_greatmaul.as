#pragma context server

#include "items/blunt_maul.as"

namespace MS
{

class BluntGreatmaul : CGameScript
{
	BluntGreatmaul()
	{
		const int BASE_LEVEL_REQ = 12;
		const int MELEE_DMG = 290;
		const int MELEE_DMG_RANGE = 150;
		const int MELEE_ENERGY = 11;
		const float MELEE_ATK_DURATION = 1.5;
	}

	void weapon_spawn()
	{
		SetName("Great Maul");
		SetDescription("An even heavier maul");
		SetWeight(125);
		SetSize(13);
		SetValue(530);
	}

}

}
