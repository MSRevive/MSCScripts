#pragma context server

#include "monsters/giantrat.as"

namespace MS
{

class Sewerrat : CGameScript
{
	float ATTACK_DAMAGE;
	float ATTACK_HITCHANCE;
	int ATTACK_RANGE;

	Sewerrat()
	{
		ATTACK_DAMAGE = 0.9;
		ATTACK_RANGE = 70;
		ATTACK_HITCHANCE = 0.55;
	}

	void OnSpawn() override
	{
		SetHealth(15);
		SetWidth(40);
		SetHeight(64);
		SetName("Sewer Rat");
		SetRoam(true);
		SetHearingSensitivity(1);
		SetSkillLevel(6);
		SetRace("demon");
		SetModel("monsters/giant_rat.mdl");
		SetModelBody(1, 0);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
	}

}

}
