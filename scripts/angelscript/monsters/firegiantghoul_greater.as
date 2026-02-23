#pragma context server

#include "monsters/firegiantghoul.as"

namespace MS
{

class FiregiantghoulGreater : CGameScript
{
	FiregiantghoulGreater()
	{
		const int MY_MAX_HP = 4000;
		const string MY_NAME = "Greater Undead Firegiant";
		const int FIREBALL_DAMAGE = 100;
		const int ATTACK_DAMAGE = 60;
		const int THROW_CHANCE = 30;
		const int FIN_EXP = 400;
	}

	void OnSpawn() override
	{
		SetDamageResistance("cold", 1.25);
	}

}

}
