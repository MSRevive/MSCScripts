#pragma context server

#include "items/blunt_mace.as"

namespace MS
{

class BluntGranitemace : CGameScript
{
	int BASE_LEVEL_REQ;
	float MELEE_ACCURACY;
	int MELEE_DMG;
	int MELEE_DMG_RANGE;

	BluntGranitemace()
	{
		BASE_LEVEL_REQ = 12;
		MELEE_DMG = 230;
		MELEE_DMG_RANGE = 140;
		MELEE_ACCURACY = 0.7;
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
