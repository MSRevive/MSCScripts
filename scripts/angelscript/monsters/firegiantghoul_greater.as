#pragma context server

#include "monsters/firegiantghoul.as"

namespace MS
{

class FiregiantghoulGreater : CGameScript
{
	int ATTACK_DAMAGE;
	int FIN_EXP;
	int FIREBALL_DAMAGE;
	int MY_MAX_HP;
	string MY_NAME;
	int THROW_CHANCE;

	FiregiantghoulGreater()
	{
		MY_MAX_HP = 4000;
		MY_NAME = "Greater Undead Firegiant";
		FIREBALL_DAMAGE = 100;
		ATTACK_DAMAGE = 60;
		THROW_CHANCE = 30;
		FIN_EXP = 400;
	}

	void OnSpawn() override
	{
		SetDamageResistance("cold", 1.25);
	}

}

}
