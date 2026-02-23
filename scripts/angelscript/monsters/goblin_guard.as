#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class GoblinGuard : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_RUN;
	string ANIM_WALK;
	string ATTACK_DAMAGE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLEE;
	int CAN_HUNT;
	string DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int HUNT_AGRO;
	string LAST_ENEMY;
	int MOVE_RANGE;
	int NPC_MUST_SEE_TARGET;
	float RETALIATE_CHANCE;

	GoblinGuard()
	{
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "swordswing1_L";
		ANIM_DEATH = "die_fallback";
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 130;
		MOVE_RANGE = 50;
		const string SOUND_STRUCK1 = "body/flesh1.wav";
		const string SOUND_STRUCK2 = "body/flesh2.wav";
		const string SOUND_STRUCK3 = "body/flesh3.wav";
		const string SOUND_HIT = "monsters/goblin/c_gargoyle_hit1.wav";
		const string SOUND_HIT1 = "monsters/goblin/c_gargoyle_hit1.wav";
		const string SOUND_HIT2 = "monsters/goblin/c_gargoyle_hit2.wav";
		const string SOUND_PAINYELL = "monsters/orc/pain.wav";
		const string SOUND_WARCRY1 = "monsters/goblin/c_goblin_bat1.wav";
		const string SOUND_ATTACK1 = "monsters/goblin/c_goblin_atk1.wav";
		const string SOUND_ATTACK2 = "monsters/goblin/c_goblin_atk2.wav";
		const string SOUND_ATTACK3 = "monsters/goblin/c_goblin_atk3.wav";
		const string SOUND_DEATH = "monsters/goblin/c_goblin_dead.wav";
		const string SOUND_DEATH2 = "monsters/goblin/c_goblin_dead.wav";
		const string SOUND_HELP = "monsters/goblin/c_goblin_bat2.wav";
		const float ATTACK_HITCHANCE = 0.8;
		CAN_HUNT = 1;
		HUNT_AGRO = 1;
		RETALIATE_CHANCE = 0.75;
		CAN_FLEE = 0;
		DROP_GOLD = RandomInt(0, 1);
		DROP_GOLD_MIN = 3;
		DROP_GOLD_MAX = 5;
		NPC_MUST_SEE_TARGET = 0;
		Precache(SOUND_DEATH);
	}

	void OnSpawn() override
	{
		SetHealth(120);
		SetWidth(32);
		SetHeight(60);
		SetName("Goblin Guard");
		SetRoam(true);
		SetHearingSensitivity(6);
		SetSkillLevel(35);
		SetRace("goblin");
		SetModel("monsters/goblin_new.mdl");
		SetModelBody(0, 0);
		SetModelBody(1, 1);
		SetModelBody(2, 4);
		SetModelBody(3, 0);
		SetModelBody(4, 0);
		SetIdleAnim("idle1");
		SetMoveAnim(ANIM_WALK);
	}

	void swing_sword()
	{
		ATTACK_DAMAGE = Random(8, 12);
		if (GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)
		{
			npcatk_dodamage(m_hAttackTarget, "direct", ATTACK_DAMAGE, ATTACK_HITCHANCE, GetEntityIndex(GetOwner()), "slash");
		}
		attack_sound();
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_HIT, SOUND_HIT2, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_HIT, SOUND_HIT2, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void attack_sound()
	{
		if (RandomInt(0, 1) == 0)
		{
			SetVolume(5);
			// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
			array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		else
		{
			if (RandomInt(0, 5) == 2)
			{
				EmitSound(GetOwner(), SOUND_WARCRY1);
			}
		}
	}

	void npc_targetsighted()
	{
		string LASTSEEN_ENEMY = GetEntityIndex(m_hLastSeen);
		if (!(LASTSEEN_ENEMY != LAST_ENEMY)) return;
		EmitSound(GetOwner(), CHAN_VOICE, SOUND_WARCRY1, 5);
		LAST_ENEMY = LASTSEEN_ENEMY;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetModelBody(2, 0);
	}

}

}
