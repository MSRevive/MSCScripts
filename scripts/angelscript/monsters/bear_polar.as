#pragma context server

#include "monsters/bear_base.as"
#include "monsters/base_ice_race.as"

namespace MS
{

class BearPolar : CGameScript
{
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	int MOVE_RANGE;

	BearPolar()
	{
		MOVE_RANGE = 70;
		ATTACK_RANGE = 90;
		ATTACK_HITRANGE = 200;
		const string ATTACK_DAMAGE = "$rand(16,26)";
		const float ATTACK_HITCHANCE = 0.6;
		const int NPC_BASE_EXP = 45;
		const float RETALIATE_CHANGETARGET_CHANCE = 0.5;
		DROP_ITEM1 = "skin_bear";
		DROP_ITEM1_CHANCE = 0.75;
	}

	void OnSpawn() override
	{
		SetHealth(360);
		SetWidth(64);
		SetHeight(95);
		SetName("Polar Bear");
		SetHearingSensitivity(4);
		SetDamageResistance("cold", 0.0);
		SetModel("monsters/bear.mdl");
		SetModelBody(0, 0);
	}

}

}
