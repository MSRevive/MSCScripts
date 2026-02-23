#pragma context server

#include "monsters/orc_base_ranged.as"
#include "monsters/orc_base.as"

namespace MS
{

class MorcArcher : CGameScript
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

	MorcArcher()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(10, 18);
		NPC_GIVE_EXP = 45;
		DROP_ITEM1 = "bows_longbow";
		DROP_ITEM1_CHANCE = 0.1;
		DROP_ITEM2 = "proj_arrow_jagged";
		DROP_ITEM2_CHANCE = 0.1;
		ANIM_ATTACK = "shootorcbow";
		FLINCH_CHANCE = 0.45;
		const int AIM_RATIO = 50;
		const int ARROW_DAMAGE_LOW = 20;
		const int ARROW_DAMAGE_HIGH = 35;
		MOVE_RANGE = 5000;
		ATTACK_RANGE = 5500;
		const int ATTACK_SPEED = 900;
		const int ATTACK_CONE_OF_FIRE = 2;
		DROPS_CONTAINER = 1;
		CONTAINER_DROP_CHANCE = 0.05;
		CONTAINER_SCRIPT = "chests/quiver_of_frost_arrows";
		Precache("monsters/morc.mdl");
	}

	void orc_spawn()
	{
		SetHealth(160);
		SetName("Marogar Archer");
		SetHearingSensitivity(2);
		SetStat("parry", 30);
		SetDamageResistance("all", ".8");
		SetDamageResistance("fire", 1.5);
		SetDamageResistance("cold", 0.1);
		Precache("monsters/morc.mdl");
		SetModel("monsters/morc.mdl");
		SetModelBody(0, 1);
		SetModelBody(1, 4);
		SetModelBody(2, 2);
	}

}

}
