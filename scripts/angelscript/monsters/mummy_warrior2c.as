#pragma context server

#include "monsters/mummy_base.as"

namespace MS
{

class MummyWarrior2c : CGameScript
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
	float BASE_FRAMERATE;
	float BASE_MOVESPEED;
	int DMG_PIKE;
	int DMG_SLASH;
	int DMG_STAB;
	int DMG_STEELPIPE;
	float FREQ_MUMMY_PIKE_TOSS;
	int MUMMY_PIKE_SPEED;
	string MUMMY_PROJ_NAME;
	int MUMMY_STARTING_LIVES;
	int MUMMY_THROWS_PIKE;
	int NPC_GIVE_EXP;

	MummyWarrior2c()
	{
		ANIM_WALK = "walk";
		ANIM_RUN = "walk2";
		ANIM_IDLE = "idle1";
		ANIM_ATTACK = "stab";
		ANIM_ATTACK_SHORT = "steelpipe";
		ANIM_ATTACK_LONG = "stab";
		NPC_GIVE_EXP = 5000;
		ATTACK_TYPE = "long";
		DMG_SLASH = 600;
		MUMMY_STARTING_LIVES = 1;
		ATTACK_HITCHANCE = 90;
		ATTACK_RANGE_SHORT = 64;
		ATTACK_HITRANGE_SHORT = 96;
		ATTACK_RANGE_LONG = 130;
		ATTACK_HITRANGE_LONG = 150;
		DMG_STEELPIPE = 200;
		DMG_STAB = 600;
		MUMMY_THROWS_PIKE = 1;
		FREQ_MUMMY_PIKE_TOSS = 10.0;
		DMG_PIKE = 400;
		MUMMY_PIKE_SPEED = 400;
		MUMMY_PROJ_NAME = "proj_mummy_pike";
	}

	void mummy_spawn()
	{
		SetName("Mummified Warlord");
		SetHealth(8000);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("holy", 1.0);
		SetModelBody(0, 1);
		SetModelBody(1, 3);
		SetModelBody(2, 6);
		SetModelBody(3, 0);
		SetMoveSpeed(2.0);
		BASE_MOVESPEED = 2.0;
		SetAnimFrameRate(1.5);
		BASE_FRAMERATE = 1.5;
	}

}

}
