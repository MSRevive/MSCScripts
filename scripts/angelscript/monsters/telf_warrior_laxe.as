#pragma context server

#include "monsters/elf_warrior_base.as"

namespace MS
{

class TelfWarriorLaxe : CGameScript
{
	string ANIM_ATTACK;
	string ATTACK_STANCE;
	float CHANCE_DOT;
	string DMG_TYPE;
	int DOT_AMT;
	float DOT_DURATION;
	string DOT_SCRIPT;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	int NPC_GIVE_EXP;
	string SOUND_SHOCKAMB1;
	string SOUND_SHOCKAMB2;
	string SOUND_SHOCKAMB3;
	int WEAPON_AURA;

	TelfWarriorLaxe()
	{
		NPC_GIVE_EXP = 2500;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = 500;
		DMG_TYPE = "slash";
		ATTACK_STANCE = "2haxe";
		CHANCE_DOT = 1.0;
		DOT_SCRIPT = "effects/dot_lightning";
		DOT_AMT = 50;
		DOT_DURATION = 5.0;
		WEAPON_AURA = 1;
		SOUND_SHOCKAMB1 = "debris/zap1.wav";
		SOUND_SHOCKAMB2 = "debris/zap3.wav";
		SOUND_SHOCKAMB3 = "debris/zap8.wav";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(5.0, 10.0));
		if ((IsEntityAlive(GetOwner())))
		{
		}
		// PlayRandomSound from: SOUND_SHOCKAMB1, SOUND_SHOCKAMB2, SOUND_SHOCKAMB3
		array<string> sounds = {SOUND_SHOCKAMB1, SOUND_SHOCKAMB2, SOUND_SHOCKAMB3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		Effect("beam", "ents", "lgtning.spr", 20, GetOwner(), 1, GetOwner(), 2, Vector3(255, 255, 0), 200, 100, 1.0);
	}

	void elf_spawn()
	{
		SetName("Torkalath Slasher");
		SetHealth(7000);
		SetDamageResistance("all", 0.5);
		SetRace("torkie");
		SetModelBody(1, 3);
	}

	void OnPostSpawn() override
	{
		ANIM_ATTACK = "battleaxe_swing1_L";
	}

}

}
