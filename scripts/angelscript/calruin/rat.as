#pragma context server

#include "monsters/giantrat.as"

namespace MS
{

class Rat : CGameScript
{
	float ATTACK_HITCHANCE;
	int ATTACK_RANGE;
	int MOVE_RANGE;
	string MY_ENEMY;
	int NPC_GIVE_EXP;

	Rat()
	{
		MOVE_RANGE = 50;
		ATTACK_RANGE = 75;
		ATTACK_HITCHANCE = 0.55;
		MY_ENEMY = "enemy";
	}

	void OnSpawn() override
	{
		SetHealth(45);
		SetFOV(270);
		SetWidth(32);
		SetHeight(32);
		SetName("Corpse eater");
		SetRoam(true);
		SetHearingSensitivity(4);
		NPC_GIVE_EXP = 20;
		SetRace("vermin");
		SetStepSize(16);
		SetModel("monsters/giant_rat.mdl");
		SetModelBody(1, 0);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
	}

	void bite1()
	{
		DoDamage(m_hLastSeen, ATTACK_RANGE, Random(3.5, 5.0), ATTACK_HITCHANCE, "slash");
	}

}

}
