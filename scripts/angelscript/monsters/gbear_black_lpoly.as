#pragma context server

#include "monsters/gbear_polar.as"

namespace MS
{

class GbearBlackLpoly : CGameScript
{
	string MONSTER_MODEL;
	int NO_BREATH_ATTACK;
	int NO_FROSTY_BREATH;
	int NPC_BASE_EXP;

	GbearBlackLpoly()
	{
		NPC_BASE_EXP = 400;
		MONSTER_MODEL = "monsters/gbear_lpoly.mdl";
		NO_BREATH_ATTACK = 1;
		NO_FROSTY_BREATH = 1;
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
