#pragma context server

#include "monsters/elf_warrior_base.as"

namespace MS
{

class TelfWarriorPdagger : CGameScript
{
	string ANIM_ATTACK;
	float BASE_MOVESPEED;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	int NPC_GIVE_EXP;

	TelfWarriorPdagger()
	{
		NPC_GIVE_EXP = 3000;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = 500;
		const string DMG_TYPE = "pierce";
		const string ATTACK_STANCE = "assasin";
		const float CHANCE_DOT = 1.0;
		const string DOT_SCRIPT = "effects/dot_poison";
		const int DOT_AMT = 40;
		const float DOT_DURATION = 10.0;
		const int CAN_KICK = 1;
		const int LEAP_AFTER_KICK = 1;
		const int CAN_THROW = 1;
		const int DMG_MELEE = 200;
	}

	void elf_spawn()
	{
		SetName("Torkalath Assassin");
		SetHealth(4000);
		SetDamageResistance("all", 0.5);
		SetRace("torkie");
		SetMoveSpeed(2.0);
		BASE_MOVESPEED = 2.0;
		SetModelBody(1, 1);
	}

	void OnPostSpawn() override
	{
		ANIM_ATTACK = "swordjab1_R";
	}

}

}
