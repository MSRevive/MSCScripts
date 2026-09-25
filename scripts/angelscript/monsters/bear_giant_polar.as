#pragma context server

#include "monsters/bear_base_giant.as"
#include "monsters/base_ice_race.as"

namespace MS
{

class BearGiantPolar : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	float ATTACK_HITCHANCE;
	int ATTACK_NORMAL_DAMAGE;
	int ATTACK_STANDING_DAMAGE;
	int ATTACK_STOMPDMG;
	int ATTACK_STOMPRANGE;
	int NPC_BASE_EXP;

	BearGiantPolar()
	{
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack";
		ATTACK_NORMAL_DAMAGE = "$rand(40,80)";
		ATTACK_STANDING_DAMAGE = "$rand(40,58)";
		ATTACK_STOMPRANGE = 200;
		ATTACK_STOMPDMG = 50;
		ATTACK_HITCHANCE = 0.7;
		NPC_BASE_EXP = 200;
	}

	void OnSpawn() override
	{
		SetHealth(1600);
		SetName("Giant Polar bear");
		SetDamageResistance("cold", 0.0);
		SetModelBody(0, 0);
	}

}

}
