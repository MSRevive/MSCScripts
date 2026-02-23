#pragma context server

#include "items/blunt_mace.as"

namespace MS
{

class BluntGranitemace : CGameScript
{
	BluntGranitemace()
	{
		const int BASE_LEVEL_REQ = 12;
		const int MELEE_DMG = 230;
		const int MELEE_DMG_RANGE = 140;
		const float MELEE_ACCURACY = 0.7;
	}

	void weapon_spawn()
	{
		SetName("Granite Mace");
		SetDescription("A heavy granite mace");
		SetWeight(60);
		SetSize(12);
		SetValue(800);
	}

}

}
