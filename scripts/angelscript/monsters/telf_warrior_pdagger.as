#pragma context server

#include "monsters/elf_warrior_base.as"

namespace MS
{

class TelfWarriorPdagger : CGameScript
{
	string ANIM_ATTACK;
	string ATTACK_STANCE;
	float BASE_MOVESPEED;
	int CAN_KICK;
	int CAN_THROW;
	float CHANCE_DOT;
	int DMG_MELEE;
	string DMG_TYPE;
	int DOT_AMT;
	float DOT_DURATION;
	string DOT_SCRIPT;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	int LEAP_AFTER_KICK;
	int NPC_GIVE_EXP;

	TelfWarriorPdagger()
	{
		NPC_GIVE_EXP = 3000;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = 500;
		DMG_TYPE = "pierce";
		ATTACK_STANCE = "assasin";
		CHANCE_DOT = 1.0;
		DOT_SCRIPT = "effects/dot_poison";
		DOT_AMT = 40;
		DOT_DURATION = 10.0;
		CAN_KICK = 1;
		LEAP_AFTER_KICK = 1;
		CAN_THROW = 1;
		DMG_MELEE = 200;
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
