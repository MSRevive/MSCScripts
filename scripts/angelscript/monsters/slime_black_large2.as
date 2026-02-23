#pragma context server

#include "monsters/slime_black_base.as"

namespace MS
{

class SlimeBlackLarge2 : CGameScript
{
	int NPC_GIVE_EXP;

	SlimeBlackLarge2()
	{
		const float ATTACK_HITCHANCE = 0.75;
		const string ATTACK_DAMAGE = Random(10, 25);
		const string CHILD_SCRIPT = "monsters/slime_black_small2";
		const int CHILD_DIST = 20;
		const int NPC_BASE_EXP = 80;
		SetName("Large Black Pudding");
		SetHealth(200);
		SetRace("demon");
		NPC_GIVE_EXP = 80;
	}

}

}
