#pragma context server

#include "monsters/bear_base.as"

namespace MS
{

class BearBrown : CGameScript
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

	BearBrown()
	{
		MOVE_RANGE = 70;
		ATTACK_RANGE = 90;
		ATTACK_HITRANGE = 200;
		ATTACK_DAMAGE = "$rand(10,15)";
		ATTACK_HITCHANCE = 0.6;
		NPC_BASE_EXP = 50;
		RETALIATE_CHANGETARGET_CHANCE = 0.5;
		DROP_ITEM1 = "skin_bear";
		DROP_ITEM1_CHANCE = 0.75;
	}

	void OnSpawn() override
	{
		SetHealth(180);
		SetWidth(64);
		SetHeight(95);
		SetName("Brown Bear");
		SetHearingSensitivity(3);
		SetModel("monsters/bear.mdl");
		SetModelBody(0, 1);
	}

}

}
