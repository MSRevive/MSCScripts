#pragma context server

#include "monsters/slime_black_base.as"

namespace MS
{

class SlimeBlackLarge2 : CGameScript
{
	float ATTACK_DAMAGE;
	float ATTACK_HITCHANCE;
	int CHILD_DIST;
	string CHILD_SCRIPT;
	int NPC_BASE_EXP;
	int NPC_GIVE_EXP;

	SlimeBlackLarge2()
	{
		ATTACK_HITCHANCE = 0.75;
		ATTACK_DAMAGE = Random(10, 25);
		CHILD_SCRIPT = "monsters/slime_black_small2";
		CHILD_DIST = 20;
		NPC_BASE_EXP = 80;
		SetName("Large Black Pudding");
		SetHealth(200);
		SetRace("demon");
		NPC_GIVE_EXP = 80;
	}

}

}
