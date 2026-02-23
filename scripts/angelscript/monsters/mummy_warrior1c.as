#pragma context server

#include "monsters/mummy_base.as"

namespace MS
{

class MummyWarrior1c : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	float BASE_MOVESPEED;
	int NPC_GIVE_EXP;

	MummyWarrior1c()
	{
		ANIM_WALK = "walk";
		ANIM_RUN = "walk2";
		ANIM_IDLE = "idle1";
		ANIM_ATTACK = "stab";
		const string ANIM_ATTACK_SHORT = "steelpipe";
		const string ANIM_ATTACK_LONG = "stab";
		NPC_GIVE_EXP = 2000;
		const string ATTACK_TYPE = "long";
		const int DMG_SLASH = 300;
		const int MUMMY_STARTING_LIVES = 1;
		const int ATTACK_HITCHANCE = 90;
		const int ATTACK_RANGE_SHORT = 64;
		const int ATTACK_HITRANGE_SHORT = 96;
		const int ATTACK_RANGE_LONG = 130;
		const int ATTACK_HITRANGE_LONG = 150;
		const int DMG_STEELPIPE = 100;
		const int DMG_STAB = 300;
		const int MUMMY_STARTING_LIVES = 1;
		const int MUMMY_THROWS_PIKE = 1;
		const float FREQ_MUMMY_PIKE_TOSS = 4.0;
		const int DMG_PIKE = 400;
		const int MUMMY_PIKE_SPEED = 800;
		const string MUMMY_PROJ_NAME = "proj_mummy_spear";
		const int MUMMY_PIKE_NOGLOW = 1;
	}

	void mummy_spawn()
	{
		SetName("Mummified Legionnaire");
		SetDamageResistance("all", 0.75);
		SetHealth(4000);
		SetModelBody(0, 0);
		SetModelBody(1, 3);
		SetModelBody(2, 6);
		SetModelBody(3, 0);
		SetMoveSpeed(2.0);
		BASE_MOVESPEED = 2.0;
	}

}

}
