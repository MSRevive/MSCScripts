#pragma context server

#include "monsters/orc_base_ranged.as"
#include "monsters/orc_base.as"

namespace MS
{

class OrcScout : CGameScript
{
	string ANIM_ATTACK;
	int ATTACK_RANGE;
	float CONTAINER_DROP_CHANCE;
	string CONTAINER_SCRIPT;
	int DROPS_CONTAINER;
	string DROP_GOLD;
	string DROP_GOLD_AMT;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	string DROP_ITEM2;
	float DROP_ITEM2_CHANCE;
	float FLINCH_CHANCE;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;

	OrcScout()
	{
		DROP_GOLD = RandomInt(0, 1);
		DROP_GOLD_AMT = RandomInt(1, 4);
		NPC_GIVE_EXP = 10;
		DROP_ITEM1 = "bows_orcbow";
		DROP_ITEM1_CHANCE = 0.2;
		DROP_ITEM2 = "proj_arrow_wooden";
		DROP_ITEM2_CHANCE = 0.8;
		ANIM_ATTACK = "shootorcbow";
		FLINCH_CHANCE = 0.7;
		const int AIM_RATIO = 30;
		const int ARROW_DAMAGE_LOW = 1;
		const int ARROW_DAMAGE_HIGH = 2;
		MOVE_RANGE = 300;
		ATTACK_RANGE = 800;
		const int ATTACK_SPEED = 800;
		const int ATTACK_CONE_OF_FIRE = 2;
		DROPS_CONTAINER = 1;
		CONTAINER_DROP_CHANCE = 0.1;
		CONTAINER_SCRIPT = "chests/quiver_of_bluntwood";
	}

	void orc_spawn()
	{
		SetHealth(15);
		SetWidth(40);
		SetHeight(90);
		SetName("Blackhand scout");
		if (GetMapName() == "ms_wicardoven")
		{
			SetName("Voldar Peon");
			SetProp(GetOwner(), "skin", 3);
		}
		SetHearingSensitivity(1);
		SetStat("parry", 20);
		SetModelBody(0, 0);
		SetModelBody(1, 1);
		SetModelBody(2, 2);
	}

}

}
