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
	int NPC_GIVE_EXP;

	Murmur()
	{
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack";
		const int ATTACK_NORMAL_DAMAGE = 40;
		const string ATTACK_STANDING_DAMAGE = Random(28, 30);
		const int ATTACK_STOMPRANGE = 250;
		const int ATTACK_STOMPDMG = 80;
		const float ATTACK_HITCHANCE = 0.7;
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
