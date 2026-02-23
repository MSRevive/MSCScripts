#pragma context server

#include "monsters/elf_warrior_base.as"

namespace MS
{

class TelfWarriorFmaceDshield : CGameScript
{
	string ANIM_ATTACK;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	int NPC_GIVE_EXP;

	TelfWarriorFmaceDshield()
	{
		NPC_GIVE_EXP = 2500;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = 500;
		const float CHANCE_STUN = 0.2;
		const string ATTACK_TYPE = "blunt";
		const string ATTACK_STANCE = "1h";
		const float CHANCE_DOT = 1.0;
		const int CAN_BLOCK = 1;
		const int WEAPON_AURA = 1;
		const string WAURA_TYPE = "fire";
		const string WAURA_EFFECT_SCRIPT = "effects/dot_fire";
		const int WAURA_RANGE = 128;
		const string WEAPON_AURA_CL_SCRIPT = "monsters/telf_warrior_fmace_cl";
		const int DMG_WAURA = 400;
		const int DOT_WAURA = 150;
		const string WAURA_DMG_TYPE = "fire_effect";
		const string FREQ_WAURA = Random(20.0, 30.0);
		const float WAURA_DURATION = 5.0;
		const string SOUND_WAURA_START = "monsters/goblin/sps_fogfire.wav";
		const string SOUND_WAURA_LOOP = "magic/volcano_loop.wav";
		Precache("xfireball3.spr");
	}

	void elf_spawn()
	{
		SetName("Torkalath Warrior");
		SetHealth(5000);
		SetDamageResistance("all", 0.5);
		ANIM_ATTACK = "swordswing1_R";
		SetRace("torkie");
		SetModelBody(1, 2);
		SetModelBody(2, 1);
	}

	void OnPostSpawn() override
	{
		ANIM_ATTACK = "swordswing1_R";
	}

}

}
