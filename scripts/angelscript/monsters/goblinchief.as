#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class Goblinchief : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_RUN;
	string ANIM_WALK;
	float ATTACK_DAMAGE;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLEE;
	int CAN_HUNT;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int HUNT_AGRO;
	string LAST_ENEMY;
	int MOVE_RANGE;
	float NPC_BOSS_REGEN_RATE;
	float NPC_BOSS_RESTORATION;
	string NPC_GIVE_EXP;
	string NPC_IS_BOSS;
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

	Goblinchief()
	{
		if (StringToLower(GetMapName()) == "goblintown")
		{
			NPC_IS_BOSS = 1;
			NPC_GIVE_EXP = 400;
		}
		else
		{
			if (StringToLower(GetMapName()) == "gertenheld_forest")
			{
				NPC_GIVE_EXP = 50;
			}
			else
			{
				NPC_GIVE_EXP = 150;
			}
		}
		NPC_BOSS_REGEN_RATE = 0.1;
		NPC_BOSS_RESTORATION = 1.0;
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "battleaxe_swing1_L";
		ANIM_DEATH = "die_fallback";
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 130;
		MOVE_RANGE = 50;
		ATTACK_HITCHANCE = 0.6;
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
		RETALIATE_CHANCE = 0.75;
		CAN_FLEE = 0;
		DROP_GOLD = RandomInt(0, 1);
		DROP_GOLD_MIN = 5;
		DROP_GOLD_MAX = 10;
		Precache(SOUND_DEATH);
	}

	void OnSpawn() override
	{
		SetHealth(500);
		SetWidth(32);
		SetHeight(60);
		SetName("Goblin Chief");
		SetRoam(true);
		SetHearingSensitivity(6);
		SetRace("goblin");
		SetModel("monsters/goblin_new_boss.mdl");
		SetModelBody(0, 0);
		SetModelBody(1, 2);
		SetModelBody(2, 5);
		SetModelBody(3, 0);
		SetModelBody(4, 0);
		SetIdleAnim("idle1");
		SetMoveAnim(ANIM_WALK);
		GiveItem(GetOwner(), "item_goblinhead");
	}

	void swing_axe()
	{
		ATTACK_DAMAGE = Random(15, 28);
		npcatk_dodamage(GetEntityIndex(m_hLastSeen), ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "slash");
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
			if (RandomInt(0, 5) == 0)
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
