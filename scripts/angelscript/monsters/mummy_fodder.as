#pragma context server

#include "monsters/mummy_base.as"

namespace MS
{

class MummyFodder : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	float AS_STUCK_FREQ;
	int ATTACK_HITCHANCE;
	string ATTACK_TYPE;
	int DMG_SLASH;
	float FLINCH_HEALTH_RATIO;
	int MUMMY_STARTING_LIVES;
	int NPC_GIVE_EXP;

	MummyFodder()
	{
		ANIM_WALK = "walk";
		ANIM_RUN = "walk1";
		ANIM_IDLE = "idle1";
		ANIM_DEATH = "dieforward";
		NPC_GIVE_EXP = 200;
		ANIM_ATTACK = "stab1";
		FLINCH_HEALTH_RATIO = 0.5;
		AS_STUCK_FREQ = 0.5;
		ATTACK_TYPE = "unarmed";
		ATTACK_HITCHANCE = 80;
		DMG_SLASH = 100;
		MUMMY_STARTING_LIVES = RandomInt(1, 4);
	}

	void mummy_spawn()
	{
		SetName("Crypt Fiend");
		SetHealth(1000);
		SetModelBody(0, 0);
		SetModelBody(1, 0);
		SetModelBody(2, 0);
		SetModelBody(3, 0);
		SetDamageResistance("holy", 1.5);
	}

}

}
