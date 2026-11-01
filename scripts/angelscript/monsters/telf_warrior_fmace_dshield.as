#pragma context server

#include "monsters/elf_warrior_base.as"

namespace MS
{

class TelfWarriorFmaceDshield : CGameScript
{
	string ANIM_ATTACK;
	string ATTACK_STANCE;
	string ATTACK_TYPE;
	int CAN_BLOCK;
	float CHANCE_DOT;
	float CHANCE_STUN;
	int DMG_WAURA;
	int DOT_WAURA;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	float FREQ_WAURA;
	int NPC_GIVE_EXP;
	string SOUND_WAURA_LOOP;
	string SOUND_WAURA_START;
	string WAURA_DMG_TYPE;
	float WAURA_DURATION;
	string WAURA_EFFECT_SCRIPT;
	int WAURA_RANGE;
	string WAURA_TYPE;
	int WEAPON_AURA;
	string WEAPON_AURA_CL_SCRIPT;

	TelfWarriorFmaceDshield()
	{
		NPC_GIVE_EXP = 2500;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = 500;
		CHANCE_STUN = 0.2;
		ATTACK_TYPE = "blunt";
		ATTACK_STANCE = "1h";
		CHANCE_DOT = 1.0;
		CAN_BLOCK = 1;
		WEAPON_AURA = 1;
		WAURA_TYPE = "fire";
		WAURA_EFFECT_SCRIPT = "effects/dot_fire";
		WAURA_RANGE = 128;
		WEAPON_AURA_CL_SCRIPT = "monsters/telf_warrior_fmace_cl";
		DMG_WAURA = 400;
		DOT_WAURA = 150;
		WAURA_DMG_TYPE = "fire_effect";
		FREQ_WAURA = Random(20.0, 30.0);
		WAURA_DURATION = 5.0;
		SOUND_WAURA_START = "monsters/goblin/sps_fogfire.wav";
		SOUND_WAURA_LOOP = "magic/volcano_loop.wav";
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
