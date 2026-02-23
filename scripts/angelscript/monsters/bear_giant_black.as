#pragma context server

#include "monsters/bear_base_giant.as"

namespace MS
{

class BearGiantBlack : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;

	BearGiantBlack()
	{
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack";
		const int ATTACK_NORMAL_DAMAGE = 30;
		const string ATTACK_STANDING_DAMAGE = Random(18, 33);
		const int ATTACK_STOMPRANGE = 225;
		const int ATTACK_STOMPDMG = 30;
		const float ATTACK_HITCHANCE = 0.7;
		const int NPC_BASE_EXP = 190;
	}

	void OnSpawn() override
	{
		SetHealth(500);
		SetName("Giant Black bear");
		SetModelBody(0, 2);
	}

}

}
