#pragma context server

#include "monsters/bear_base.as"
#include "monsters/base_ice_race.as"

namespace MS
{

class BearPolar : CGameScript
{
	int ATTACK_DAMAGE;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	int MOVE_RANGE;
	int NPC_BASE_EXP;
	float RETALIATE_CHANGETARGET_CHANCE;

	BearPolar()
	{
		MOVE_RANGE = 70;
		ATTACK_RANGE = 90;
		ATTACK_HITRANGE = 200;
		ATTACK_DAMAGE = "$rand(16,26)";
		ATTACK_HITCHANCE = 0.6;
		NPC_BASE_EXP = 45;
		RETALIATE_CHANGETARGET_CHANCE = 0.5;
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
