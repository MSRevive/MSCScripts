#pragma context server

#include "monsters/elf_warrior_base.as"

namespace MS
{

class TelfWarriorIdagger : CGameScript
{
	string ANIM_ATTACK;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	int NPC_GIVE_EXP;

	TelfWarriorIdagger()
	{
		NPC_GIVE_EXP = 3000;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = 500;
		const string DMG_TYPE = "pierce";
		const string ATTACK_STANCE = "assasin";
		const float CHANCE_DOT = 1.0;
		const string DOT_SCRIPT = "effects/dot_cold";
		const int DOT_AMT = 50;
		const float DOT_DURATION = 5.0;
		const int DMG_MELEE = 200;
		const int CAN_FREEZE_AURA = 1;
	}

	void game_precache()
	{
		Precache("effects/sfx_ice_burst");
	}

	void elf_spawn()
	{
		SetName("Torkalath Frostmistress");
		SetHealth(5000);
		SetDamageResistance("all", 0.5);
		SetRace("torkie");
		SetModelBody(1, 6);
	}

	void OnPostSpawn() override
	{
		ANIM_ATTACK = "swordjab1_R";
	}

}

}
