#pragma context server

#include "monsters/elf_warrior_base.as"

namespace MS
{

class TelfWarriorIdagger : CGameScript
{
	string ANIM_ATTACK;
	string ATTACK_STANCE;
	int CAN_FREEZE_AURA;
	float CHANCE_DOT;
	int DMG_MELEE;
	string DMG_TYPE;
	int DOT_AMT;
	float DOT_DURATION;
	string DOT_SCRIPT;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	int NPC_GIVE_EXP;

	TelfWarriorIdagger()
	{
		NPC_GIVE_EXP = 3000;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = 500;
		DMG_TYPE = "pierce";
		ATTACK_STANCE = "assasin";
		CHANCE_DOT = 1.0;
		DOT_SCRIPT = "effects/dot_cold";
		DOT_AMT = 50;
		DOT_DURATION = 5.0;
		DMG_MELEE = 200;
		CAN_FREEZE_AURA = 1;
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
