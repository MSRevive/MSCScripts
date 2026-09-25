#pragma context server

#include "monsters/mummy_base.as"

namespace MS
{

class MummyCleric : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string ATTACK_TYPE;
	int DMG_STEELPIPE;
	int FLINCH_DAMAGE_THRESHOLD;
	float FLINCH_HEALTH_RATIO;
	int MUMMY_IS_CLERIC;
	string MUMMY_MELEE_DMG_TYPE;
	int MUMMY_STARTING_LIVES;
	float MUMMY_STUN_CHANCE;
	int NPC_GIVE_EXP;

	MummyCleric()
	{
		ANIM_WALK = "walk";
		ANIM_RUN = "walk2";
		ANIM_IDLE = "idle1";
		NPC_GIVE_EXP = 1000;
		ATTACK_RANGE = 80;
		ATTACK_HITRANGE = 96;
		ATTACK_MOVERANGE = 48;
		ANIM_ATTACK = "steelpipe";
		FLINCH_DAMAGE_THRESHOLD = 50;
		FLINCH_HEALTH_RATIO = 0.75;
		ATTACK_TYPE = "melee";
		ATTACK_HITCHANCE = 80;
		DMG_STEELPIPE = 400;
		MUMMY_STARTING_LIVES = 1;
		MUMMY_IS_CLERIC = 1;
		MUMMY_MELEE_DMG_TYPE = "blunt";
		MUMMY_STUN_CHANCE = 0.2;
	}

	void mummy_spawn()
	{
		SetName("Mummy High Priest");
		SetHealth(5000);
		SetModelBody(0, 1);
		SetModelBody(1, 4);
		SetModelBody(2, 4);
		SetModelBody(3, 0);
	}

}

}
