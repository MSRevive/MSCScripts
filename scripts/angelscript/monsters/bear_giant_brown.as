#pragma context server

#include "monsters/bear_base_giant.as"

namespace MS
{

class BearGiantBrown : CGameScript
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
	int NPC_BASE_EXP;

	BearGiantBrown()
	{
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack";
		ATTACK_NORMAL_DAMAGE = 15;
		ATTACK_STANDING_DAMAGE = Random(18, 23);
		ATTACK_STOMPRANGE = 160;
		ATTACK_STOMPDMG = 10;
		ATTACK_HITCHANCE = 0.7;
		NPC_BASE_EXP = 90;
	}

	void OnSpawn() override
	{
		SetHealth(200);
		SetName("Giant brown bear");
		SetModelBody(0, 1);
	}

}

}
