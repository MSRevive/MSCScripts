#pragma context server

#include "monsters/firegiantghoul.as"

namespace MS
{

class FiregiantghoulLesser : CGameScript
{
	int ATTACK_DAMAGE;
	int FIN_EXP;
	int FIREBALL_DAMAGE;
	int MY_MAX_HP;
	string MY_NAME;
	int THROW_CHANCE;

	FiregiantghoulLesser()
	{
		MY_MAX_HP = 400;
		MY_NAME = "Decayed Undead Firegiant";
		FIREBALL_DAMAGE = 25;
		ATTACK_DAMAGE = 15;
		THROW_CHANCE = 10;
		FIN_EXP = 150;
	}

}

}
