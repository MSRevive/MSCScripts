#pragma context server

#include "monsters/gbear_polar.as"

namespace MS
{

class GbearBlackLpoly : CGameScript
{
	GbearBlackLpoly()
	{
		const int NPC_BASE_EXP = 400;
		const string MONSTER_MODEL = "monsters/gbear_lpoly.mdl";
		const int NO_BREATH_ATTACK = 1;
		const int NO_FROSTY_BREATH = 1;
	}

	void OnSpawn() override
	{
		SetName("Greater Blackbear");
		SetDamageResistance("cold", 0.5);
		SetDamageResistance("fire", 0.5);
		SetHealth(2500);
		SetProp(GetOwner(), "skin", 1);
		SetGravity(5);
	}

}

}
