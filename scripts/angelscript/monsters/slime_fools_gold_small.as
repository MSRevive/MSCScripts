#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SlimeFoolsGoldSmall : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int IS_BLOODLESS;
	string MOMMY_KILLER;
	int MOVE_RANGE;
	int NO_SPAWN_STUCK_CHECK;
	int NPC_GIVE_EXP;
	int NPC_MUST_SEE_TARGET;

	SlimeFoolsGoldSmall()
	{
		const string SOUND_DEATH = "misc/gold.wav";
		const string SOUND_STRUCK1 = "misc/gold.wav";
		const string SOUND_STRUCK2 = "misc/gold.wav";
		const string SOUND_IDLE = "misc/gold.wav";
		const string SOUND_ATTACK1 = "misc/goldold.wav";
		const string SOUND_ATTACK2 = "misc/goldold.wav";
		Precache(SOUND_DEATH);
		ANIM_IDLE = "walk";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "attack";
		ANIM_DEATH = "die";
		MOVE_RANGE = 10;
		ATTACK_RANGE = 80;
		ATTACK_HITRANGE = 120;
		const float ATTACK_HITCHANCE = 0.77;
		const string ATTACK_DAMAGE = Random(7, 77);
		NPC_MUST_SEE_TARGET = 0;
		NO_SPAWN_STUCK_CHECK = 1;
		const int NPC_BASE_EXP = 10;
	}

	void OnSpawn() override
	{
		SetName("Fools Gold");
		SetHealth(777);
		SetWidth(40);
		SetBloodType("red");
		SetHeight(64);
		SetModel("dwarvencave/slime_ecave.mdl");
		SetModelBody(0, 2);
		SetRace("demon");
		SetRoam(true);
		SetSolid("none");
		NPC_GIVE_EXP = 777;
		SetHearingSensitivity(8);
		ScheduleDelayedEvent(0.5, "slime_cycle");
		SetDamageResistance("pierce", 0.2);
		SetDamageResistance("slash", 0.4);
		SetDamageResistance("blunt", 1.0);
		SetDamageResistance("fire", 1.2);
		SetDamageResistance("acid", 2.0);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("lightning", 0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("stun", 0.33);
		IS_BLOODLESS = 1;
	}

	void bite1()
	{
		npcatk_dodamage(HUNT_LASTTARGET, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "blunt");
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void game_dynamically_created()
	{
		MOMMY_KILLER = param2;
		npcatk_suspend_ai(0.5);
		SetMoveDest(param1);
		ScheduleDelayedEvent(0.75, "avenge_mommy", param2);
	}

	void avenge_mommy()
	{
		npcatk_settarget(MOMMY_KILLER, "he_killed_mommy!");
	}

	void slime_cycle()
	{
		if (m_hAttackTarget == "unset")
		{
			if (RandomInt(1, 10) == 1)
			{
			}
			EmitSound(GetOwner(), 0, SOUND_IDLE, 10);
		}
		if (m_hAttackTarget != "unset")
		{
			if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)
			{
			}
			if (RandomInt(1, 3) == 1)
			{
			}
			chicken_run(1.0, "combat_reposition");
		}
		ScheduleDelayedEvent(2.0, "slime_cycle");
	}

}

}
