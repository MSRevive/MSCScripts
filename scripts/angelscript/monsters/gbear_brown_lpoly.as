#pragma context server

#include "monsters/gbear_polar.as"

namespace MS
{

class GbearBrownLpoly : CGameScript
{
	GbearBrownLpoly()
	{
		const int NPC_BASE_EXP = 350;
		const string MONSTER_MODEL = "monsters/gbear_lpoly.mdl";
		const int NO_BREATH_ATTACK = 1;
		const int NO_FROSTY_BREATH = 1;
	}

	void OnSpawn() override
	{
		SetName("Greater Brownbear");
		SetDamageResistance("cold", 0.75);
		SetDamageResistance("fire", 0.75);
		SetHealth(2000);
		SetProp(GetOwner(), "skin", 2);
	}

}

}
