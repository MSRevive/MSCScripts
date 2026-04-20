#pragma context server

#include "monsters/troll.as"

namespace MS
{

class Cavetroll2 : CGameScript
{
	int ATTACK1_RANGE;
	int ATTACK2_RANGE;
	int ATTACK_RANGE;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int MOVE_RANGE;
	int NPC_BASE_EXP;
	int NPC_GIVE_EXP;
	string PUSH_VEL;

	Cavetroll2()
	{
		NPC_BASE_EXP = 200;
		DROP_GOLD_MIN = 50;
		DROP_GOLD_MAX = 85;
		ATTACK_RANGE = 130;
		ATTACK1_RANGE = 210;
		ATTACK2_RANGE = 160;
		MOVE_RANGE = 130;
		NPC_GIVE_EXP = 200;
	}

	void troll_spawn()
	{
		SetHealth(800);
		SetName("Hideous Cave Troll");
		SetRoam(false);
		SetHearingSensitivity(8);
	}

	void attack_1()
	{
		PUSH_VEL = /* TODO: $relvel */ $relvel(10, 200, 10);
		if (GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)
		{
			npcatk_dodamage(m_hAttackTarget, "direct", Random(25.0, 40.0), 0.9, "blunt");
		}
		attack_sound();
	}

	void attack_2()
	{
		PUSH_VEL = /* TODO: $relvel */ $relvel(10, 200, 10);
		if (GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)
		{
			npcatk_dodamage(m_hAttackTarget, "direct", Random(30.0, 40.0), 1.0, "blunt");
		}
		attack_sound();
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

}

}
