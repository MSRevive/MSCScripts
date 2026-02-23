#pragma context server

#include "monsters/firegiantghoul.as"

namespace MS
{

class FiregiantghoulLesser : CGameScript
{
	FiregiantghoulLesser()
	{
		const int MY_MAX_HP = 400;
		const string MY_NAME = "Decayed Undead Firegiant";
		const int FIREBALL_DAMAGE = 25;
		const int ATTACK_DAMAGE = 15;
		const int THROW_CHANCE = 10;
		const int FIN_EXP = 150;
	}

}

}
