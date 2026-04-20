#pragma context server

#include "monsters/mummy_base.as"

namespace MS
{

class MummyWarrior1c : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_ATTACK_LONG;
	string ANIM_ATTACK_SHORT;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITCHANCE;
	int ATTACK_HITRANGE_LONG;
	int ATTACK_HITRANGE_SHORT;
	int ATTACK_RANGE_LONG;
	int ATTACK_RANGE_SHORT;
	string ATTACK_TYPE;
	float BASE_MOVESPEED;
	int DMG_PIKE;
	int DMG_SLASH;
	int DMG_STAB;
	int DMG_STEELPIPE;
	float FREQ_MUMMY_PIKE_TOSS;
	int MUMMY_PIKE_NOGLOW;
	int MUMMY_PIKE_SPEED;
	string MUMMY_PROJ_NAME;
	int MUMMY_STARTING_LIVES;
	int MUMMY_THROWS_PIKE;
	int NPC_GIVE_EXP;

	MummyWarrior1c()
	{
		ANIM_WALK = "walk";
		ANIM_RUN = "walk2";
		ANIM_IDLE = "idle1";
		ANIM_ATTACK = "stab";
		ANIM_ATTACK_SHORT = "steelpipe";
		ANIM_ATTACK_LONG = "stab";
		NPC_GIVE_EXP = 2000;
		ATTACK_TYPE = "long";
		DMG_SLASH = 300;
		MUMMY_STARTING_LIVES = 1;
		ATTACK_HITCHANCE = 90;
		ATTACK_RANGE_SHORT = 64;
		ATTACK_HITRANGE_SHORT = 96;
		ATTACK_RANGE_LONG = 130;
		ATTACK_HITRANGE_LONG = 150;
		DMG_STEELPIPE = 100;
		DMG_STAB = 300;
		MUMMY_STARTING_LIVES = 1;
		MUMMY_THROWS_PIKE = 1;
		FREQ_MUMMY_PIKE_TOSS = 4.0;
		DMG_PIKE = 400;
		MUMMY_PIKE_SPEED = 800;
		MUMMY_PROJ_NAME = "proj_mummy_spear";
		MUMMY_PIKE_NOGLOW = 1;
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
