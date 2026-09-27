#pragma context server

#include "monsters/bandit.as"

namespace MS
{

class Slavemaster : CGameScript
{
	int ATTACK1_DAMAGE;
	int NPC_GIVE_EXP;
	int WEAPON;

	Slavemaster()
	{
		WEAPON = 3;
	}

	void swordey()
	{
		if (!(WEAPON == 3)) return;
		SetName("Slave Master");
		ATTACK1_DAMAGE = 1;
		NPC_GIVE_EXP = 0;
	}

}

}
