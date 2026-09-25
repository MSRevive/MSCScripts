#pragma context server

#include "monsters/elf_warrior_base.as"

namespace MS
{

class TelfWarriorEsword : CGameScript
{
	string ANIM_ATTACK;
	string ATTACK_STANCE;
	int DMG_MELEE;
	string DMG_TYPE;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	int NPC_GIVE_EXP;

	TelfWarriorEsword()
	{
		NPC_GIVE_EXP = 2000;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = 500;
		DMG_TYPE = "slash";
		ATTACK_STANCE = "2hsword";
		DMG_MELEE = 800;
	}

	void elf_spawn()
	{
		SetName("Torkalath Blademistress");
		SetHealth(4000);
		SetDamageResistance("all", 0.5);
		SetRace("torkie");
		SetModelBody(1, 4);
	}

	void OnPostSpawn() override
	{
		ANIM_ATTACK = "longsword_swipe_L";
	}

}

}
