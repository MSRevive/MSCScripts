#pragma context server

#include "monsters/bear_base.as"

namespace MS
{

class Grizzly : CGameScript
{
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;

	Grizzly()
	{
		MOVE_RANGE = 70;
		ATTACK_RANGE = 90;
		ATTACK_HITRANGE = 130;
		const string ATTACK_DAMAGE = "$rand(15,20)";
		const float ATTACK_HITCHANCE = 0.6;
		NPC_GIVE_EXP = 55;
		const float RETALIATE_CHANGETARGET_CHANCE = 0.5;
		DROP_ITEM1 = "skin_bear";
		DROP_ITEM1_CHANCE = 0.75;
	}

	void OnSpawn() override
	{
		SetHealth(200);
		SetWidth(64);
		SetHeight(95);
		SetName("Grizzly");
		SetHearingSensitivity(5);
		SetModel("monsters/bear.mdl");
		SetModelBody(0, 1);
	}

}

}
