#pragma context server

#include "monsters/giantrat.as"

namespace MS
{

class Rat : CGameScript
{
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	int HUNT_AGRO;
	int NPC_GIVE_EXP;
	int ORIG_HUNT_AGRO;

	Rat()
	{
	}

	void OnSpawn() override
	{
		SetHealth(4);
		SetWidth(32);
		SetHeight(32);
		SetName("Angry Giant Rat");
		SetRoam(true);
		SetHearingSensitivity(10);
		NPC_GIVE_EXP = 3;
		SetRace("demon");
		SetModel("monsters/giant_rat.mdl");
		SetModelBody(1, 0);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
	}

	void OnPostSpawn() override
	{
		HUNT_AGRO = 1;
		ORIG_HUNT_AGRO = 1;
		DROP_ITEM1 = DROP_ITEM1;
		DROP_ITEM1_CHANCE = 0.0;
	}

}

}
