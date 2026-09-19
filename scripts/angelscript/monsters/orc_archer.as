#pragma context server

#include "monsters/orc_base_ranged.as"
#include "monsters/orc_base.as"

namespace MS
{

class OrcArcher : CGameScript
{
	int AIM_RATIO;
	string ANIM_ATTACK;
	int ARROW_DAMAGE_HIGH;
	int ARROW_DAMAGE_LOW;
	int ATTACK_CONE_OF_FIRE;
	int ATTACK_RANGE;
	int ATTACK_SPEED;
	float CONTAINER_DROP_CHANCE;
	string CONTAINER_SCRIPT;
	int DROPS_CONTAINER;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	string DROP_ITEM2;
	float DROP_ITEM2_CHANCE;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;

	OrcArcher()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(2, 8);
		NPC_GIVE_EXP = 25;
		ANIM_ATTACK = "shootorcbow";
		AIM_RATIO = 30;
		ARROW_DAMAGE_LOW = 3;
		ARROW_DAMAGE_HIGH = 5;
		MOVE_RANGE = 400;
		ATTACK_RANGE = 800;
		ATTACK_SPEED = 700;
		ATTACK_CONE_OF_FIRE = 3;
		DROP_ITEM1 = "bows_orcbow";
		DROP_ITEM1_CHANCE = 0.2;
		DROP_ITEM2 = "proj_arrow_wooden";
		DROP_ITEM2_CHANCE = 0.8;
		DROPS_CONTAINER = 1;
		CONTAINER_DROP_CHANCE = 0.1;
		CONTAINER_SCRIPT = "chests/quiver_of_bluntwood";
	}

	void orc_spawn()
	{
		SetHealth(40);
		SetName("Orc Archer");
		SetHearingSensitivity(1.5);
		SetStat("parry", 20);
		SetModelBody(0, 1);
		SetModelBody(1, 1);
		SetModelBody(2, 2);
	}

}

}
