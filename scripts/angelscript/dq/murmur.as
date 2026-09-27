#pragma context server

#include "monsters/bear_base_giant.as"

namespace MS
{

class Murmur : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	float ATTACK_HITCHANCE;
	int ATTACK_NORMAL_DAMAGE;
	float ATTACK_STANDING_DAMAGE;
	int ATTACK_STOMPDMG;
	int ATTACK_STOMPRANGE;
	int NPC_GIVE_EXP;

	Murmur()
	{
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack";
		ATTACK_NORMAL_DAMAGE = 40;
		ATTACK_STANDING_DAMAGE = Random(28, 30);
		ATTACK_STOMPRANGE = 250;
		ATTACK_STOMPDMG = 80;
		ATTACK_HITCHANCE = 0.7;
		NPC_GIVE_EXP = 110;
	}

	void OnSpawn() override
	{
		SetHealth(1000);
		SetName("Murmur");
		SetModelBody(0, 1);
	}

}

}
