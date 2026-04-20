#pragma context server

#include "monsters/slime_black_base.as"

namespace MS
{

class SlimeBlackHuge : CGameScript
{
	string ANIM_RUN;
	float ATTACK_DAMAGE;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CHILD_DIST;
	string CHILD_SCRIPT;
	int MOVE_RANGE;
	int NO_COMBAT_REPOS;
	int NPC_BASE_EXP;
	int NPC_GIVE_EXP;

	SlimeBlackHuge()
	{
		MOVE_RANGE = 50;
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 150;
		ATTACK_HITCHANCE = 0.8;
		ATTACK_DAMAGE = Random(20, 50);
		ANIM_RUN = "walk";
		CHILD_SCRIPT = "monsters/slime_black_large2";
		CHILD_DIST = 30;
		NO_COMBAT_REPOS = 1;
		NPC_BASE_EXP = 150;
		Precache("monsters/slime_large.mdl");
	}

	void OnSpawn() override
	{
		SetName("Huge Black Pudding");
		SetHealth(400);
		SetModel("monsters/slime_huge.mdl");
		SetRace("demon");
		SetRoam(true);
		NPC_GIVE_EXP = 150;
	}

	void bite1()
	{
		npcatk_dodamage(/* TODO: $relpos */ $relpos(0, 0, 0), ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, 0.0, "reflective", "acid");
	}

}

}
