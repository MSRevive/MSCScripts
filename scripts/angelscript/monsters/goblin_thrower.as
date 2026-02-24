#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class GoblinThrower : CGameScript
{
	int AIM_RATIO;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_CONE_OF_FIRE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int ATTACK_SPEED;
	int CAN_FLEE;
	int CAN_HUNT;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int HUNT_AGRO;
	string LAST_ENEMY;
	int MOVE_RANGE;
	float RETALIATE_CHANCE;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_DEATH;
	string SOUND_DEATH2;
	string SOUND_HELP;
	string SOUND_HIT;
	string SOUND_HIT1;
	string SOUND_HIT2;
	string SOUND_PAINYELL;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SOUND_WARCRY1;
	int STONE_DAMAGE_HIGH;
	int STONE_DAMAGE_LOW;

	GoblinThrower()
	{
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "swordswing1_L";
		ANIM_DEATH = "die_fallback";
		MOVE_RANGE = 300;
		ATTACK_RANGE = 400;
		ATTACK_HITRANGE = 400;
		STONE_DAMAGE_LOW = 4;
		STONE_DAMAGE_HIGH = 7;
		ATTACK_CONE_OF_FIRE = 0;
		AIM_RATIO = 50;
		ATTACK_SPEED = 1000;
		SOUND_STRUCK1 = "body/flesh1.wav";
		SOUND_STRUCK2 = "body/flesh2.wav";
		SOUND_STRUCK3 = "body/flesh3.wav";
		SOUND_HIT = "monsters/goblin/c_gargoyle_hit1.wav";
		SOUND_HIT1 = "monsters/goblin/c_gargoyle_hit1.wav";
		SOUND_HIT2 = "monsters/goblin/c_gargoyle_hit2.wav";
		SOUND_PAINYELL = "monsters/orc/pain.wav";
		SOUND_WARCRY1 = "monsters/goblin/c_goblin_bat1.wav";
		SOUND_ATTACK1 = "monsters/goblin/c_goblin_atk1.wav";
		SOUND_ATTACK2 = "monsters/goblin/c_goblin_atk2.wav";
		SOUND_ATTACK3 = "monsters/goblin/c_goblin_atk3.wav";
		SOUND_DEATH = "monsters/goblin/c_goblin_dead.wav";
		SOUND_DEATH2 = "monsters/goblin/c_goblin_dead.wav";
		SOUND_HELP = "monsters/goblin/c_goblin_bat2.wav";
		CAN_HUNT = 1;
		HUNT_AGRO = 1;
		RETALIATE_CHANCE = 0.5;
		CAN_FLEE = 0;
		DROP_GOLD = RandomInt(0, 1);
		DROP_GOLD_MIN = 0;
		DROP_GOLD_MAX = 3;
		Precache(SOUND_DEATH);
	}

	void OnSpawn() override
	{
		SetHealth(35);
		SetWidth(25);
		SetHeight(60);
		SetName("Goblin Slinger");
		SetRoam(true);
		SetHearingSensitivity(7);
		SetSkillLevel(20);
		SetRace("goblin");
		SetModel("monsters/goblin_new.mdl");
		SetModelBody(0, 1);
		SetModelBody(1, 4);
		SetModelBody(2, 0);
		SetModelBody(3, 0);
		SetIdleAnim("idle1");
		SetMoveAnim(ANIM_WALK);
	}

	void swing_sword()
	{
		string AIM_ANGLE = GetEntityDist(m_hLastSeen);
		AIM_ANGLE /= AIM_RATIO;
		SetAngles("add_view.x");
		float LCL_ATKDMG = Random(STONE_DAMAGE_LOW, STONE_DAMAGE_HIGH);
		TossProjectile("proj_stone", /* TODO: $relpos */ $relpos(0, 0, 18), "none", ATTACK_SPEED, LCL_ATKDMG, ATTACK_CONE_OF_FIRE, "none");
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

}

}
