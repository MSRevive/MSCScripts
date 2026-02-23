#pragma context server

#include "monsters/orc_base_ranged.as"
#include "monsters/orc_base.as"

namespace MS
{

class OrcArcherBlackhand : CGameScript
{
	string ANIM_ATTACK;
	int ATTACK_RANGE;
	float CONTAINER_DROP_CHANCE;
	string CONTAINER_SCRIPT;
	int DROPS_CONTAINER;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	string DROP_ITEM2;
	float DROP_ITEM2_CHANCE;
	float FLINCH_CHANCE;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;

	OrcArcherBlackhand()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(8, 16);
		NPC_GIVE_EXP = 40;
		DROP_ITEM1 = "bows_shortbow";
		DROP_ITEM1_CHANCE = 0.2;
		DROP_ITEM2 = "proj_arrow_broadhead";
		DROP_ITEM2_CHANCE = 0.8;
		ANIM_ATTACK = "shootorcbow";
		FLINCH_CHANCE = 0.45;
		const int AIM_RATIO = 50;
		const int ARROW_DAMAGE_LOW = 6;
		const int ARROW_DAMAGE_HIGH = 10;
		MOVE_RANGE = 500;
		ATTACK_RANGE = 2000;
		const int ATTACK_SPEED = 900;
		const int ATTACK_CONE_OF_FIRE = 2;
		DROPS_CONTAINER = 1;
		CONTAINER_DROP_CHANCE = 0.1;
		CONTAINER_SCRIPT = "chests/quiver_of_wooden";
	}

	void orc_spawn()
	{
		SetHealth(60);
		SetName("Blackhand Archer");
		if (GetMapName() == "ms_wicardoven")
		{
			SetName("Voldar Recruit");
			SetProp(GetOwner(), "skin", 3);
		}
		SetHearingSensitivity(2);
		SetStat("parry", 30);
		SetDamageResistance("all", ".8");
		SetModelBody(0, 1);
		SetModelBody(1, 2);
		SetModelBody(2, 2);
	}

}

}
