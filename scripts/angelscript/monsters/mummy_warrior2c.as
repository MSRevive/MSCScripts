#pragma context server

#include "monsters/mummy_base.as"

namespace MS
{

class MummyWarrior2c : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	float BASE_FRAMERATE;
	float BASE_MOVESPEED;
	int NPC_GIVE_EXP;

	MummyWarrior2c()
	{
		ANIM_WALK = "walk";
		ANIM_RUN = "walk2";
		ANIM_IDLE = "idle1";
		ANIM_ATTACK = "stab";
		const string ANIM_ATTACK_SHORT = "steelpipe";
		const string ANIM_ATTACK_LONG = "stab";
		NPC_GIVE_EXP = 5000;
		const string ATTACK_TYPE = "long";
		const int DMG_SLASH = 600;
		const int MUMMY_STARTING_LIVES = 1;
		const int ATTACK_HITCHANCE = 90;
		const int ATTACK_RANGE_SHORT = 64;
		const int ATTACK_HITRANGE_SHORT = 96;
		const int ATTACK_RANGE_LONG = 130;
		const int ATTACK_HITRANGE_LONG = 150;
		const int DMG_STEELPIPE = 200;
		const int DMG_STAB = 600;
		const int MUMMY_THROWS_PIKE = 1;
		const float FREQ_MUMMY_PIKE_TOSS = 10.0;
		const int DMG_PIKE = 400;
		const int MUMMY_PIKE_SPEED = 400;
		const string MUMMY_PROJ_NAME = "proj_mummy_pike";
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
