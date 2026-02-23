#pragma context server

#include "monsters/bear_base.as"
#include "monsters/base_ice_race.as"

namespace MS
{

class BearCubPolar : CGameScript
{
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	int MOVE_RANGE;

	BearCubPolar()
	{
		MOVE_RANGE = 60;
		ATTACK_RANGE = 70;
		ATTACK_HITRANGE = 120;
		const string ATTACK_DAMAGE = "$rand(5,8)";
		const float ATTACK_HITCHANCE = 0.6;
		const int NPC_BASE_EXP = 20;
		DROP_ITEM1 = "skin_bear";
		DROP_ITEM1_CHANCE = 0.5;
	}

	void OnSpawn() override
	{
		SetHealth(80);
		SetWidth(40);
		SetHeight(80);
		SetName("Polar Bear Cub");
		SetHearingSensitivity(2);
		SetDamageResistance("cold", 0.0);
		SetModel("monsters/bearcub.mdl");
		SetModelBody(0, 0);
	}

}

}
