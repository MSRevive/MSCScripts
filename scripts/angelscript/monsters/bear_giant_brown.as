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

	BearGiantBrown()
	{
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack";
		const int ATTACK_NORMAL_DAMAGE = 15;
		const string ATTACK_STANDING_DAMAGE = Random(18, 23);
		const int ATTACK_STOMPRANGE = 160;
		const int ATTACK_STOMPDMG = 10;
		const float ATTACK_HITCHANCE = 0.7;
		const int NPC_BASE_EXP = 90;
	}

	void OnSpawn() override
	{
		SetHealth(200);
		SetName("Giant brown bear");
		SetModelBody(0, 1);
	}

}

}
