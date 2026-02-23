#pragma context server

#include "monsters/orc_base_ranged.as"
#include "monsters/orc_base.as"

namespace MS
{

class MorcRanger : CGameScript
{
	string ANIM_ATTACK;
	int ARROW_TYPE;
	int ATTACK_RANGE;
	float CONTAINER_DROP_CHANCE;
	string CONTAINER_SCRIPT;
	int DROPS_CONTAINER;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	float FLINCH_CHANCE;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;

	MorcRanger()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(10, 18);
		NPC_GIVE_EXP = 100;
		DROP_ITEM1 = "bows_longbow";
		DROP_ITEM1_CHANCE = 0.1;
		DROPS_CONTAINER = 1;
		CONTAINER_DROP_CHANCE = 0.1;
		CONTAINER_SCRIPT = "chests/quiver_of_frost_arrows";
		ANIM_ATTACK = "shootorcbow";
		FLINCH_CHANCE = 0.45;
		const int AIM_RATIO = 50;
		const int ARROW_DAMAGE_LOW = 40;
		const int ARROW_DAMAGE_HIGH = 120;
		MOVE_RANGE = 5000;
		ATTACK_RANGE = 5500;
		const int ATTACK_SPEED = 900;
		const int ATTACK_CONE_OF_FIRE = 2;
		Precache("monsters/morc.mdl");
	}

	void orc_spawn()
	{
		SetHealth(320);
		SetName("Marogar Ice Archer");
		SetHearingSensitivity(10);
		SetStat("parry", 30);
		SetStat("archery", 20);
		SetDamageResistance("all", ".8");
		SetDamageResistance("fire", 1.5);
		SetDamageResistance("cold", 0.1);
		ARROW_TYPE = 1;
		Precache("monsters/morc.mdl");
		SetModel("monsters/morc.mdl");
		SetModelBody(0, 3);
		SetModelBody(1, 2);
		SetModelBody(2, 3);
	}

	void shoot_arrow()
	{
		string AIM_ANGLE = GetEntityDist(m_hLastSeen);
		AIM_ANGLE /= AIM_RATIO;
		SetAngles("add_view.x");
		string LCL_ATKDMG = Random(ARROW_DAMAGE_LOW, ARROW_DAMAGE_HIGH);
		if (ARROW_TYPE == 1)
		{
			string LAUNCH_ARROW = "proj_arrow_frost";
		}
		if (ARROW_TYPE == 2)
		{
			string LAUNCH_ARROW = "proj_arrow_jagged";
		}
		TossProjectile("proj_arrow_frost", /* TODO: $relpos */ $relpos(0, 0, 18), "none", ATTACK_SPEED, LCL_ATKDMG, ATTACK_CONE_OF_FIRE, "none");
		ARROW_TYPE += 1;
		if (ARROW_TYPE > 2)
		{
			ARROW_TYPE = 1;
		}
		SetModelBody(3, 0);
		EmitSound(GetOwner(), SOUND_BOW);
	}

}

}
