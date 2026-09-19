#pragma context server

#include "orc_for/tiers1.as"
#include "monsters/orc_warrior.as"

namespace MS
{

class OrcWarriorSa : CGameScript
{
	float ATTACK_ACCURACY;

	OrcWarriorSa()
	{
		ATTACK_ACCURACY = 0.8;
	}

}

}
