#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SlimeLavaSmall : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	float ATTACK_DAMAGE;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	string MOMMY_KILLER;
	int MOVE_RANGE;
	int NO_SPAWN_STUCK_CHECK;
	int NPC_BASE_EXP;
	int NPC_GIVE_EXP;
	int NPC_MUST_SEE_TARGET;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_DEATH;
	string SOUND_IDLE;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;

	SlimeLavaSmall()
	{
		SOUND_DEATH = "monsters/sludge/bio.wav";
		SOUND_STRUCK1 = "barnacle/bcl_bite3.wav";
		SOUND_STRUCK2 = "barnacle/bcl_die3.wav";
		SOUND_IDLE = "barnacle/bcl_alert2.wav";
		SOUND_ATTACK1 = "barnacle/bcl_tongue1.wav";
		SOUND_ATTACK2 = "barnacle/bcl_chew3.wav";
		Precache(SOUND_DEATH);
		ANIM_IDLE = "walk";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "attack";
		ANIM_DEATH = "die";
		MOVE_RANGE = 10;
		ATTACK_RANGE = 80;
		ATTACK_HITRANGE = 120;
		ATTACK_HITCHANCE = 0.85;
		ATTACK_DAMAGE = Random(33, 66);
		NPC_MUST_SEE_TARGET = 0;
		NO_SPAWN_STUCK_CHECK = 1;
		NPC_BASE_EXP = 10;
	}

	void OnSpawn() override
	{
		SetName("small Lava Pudding");
		SetHealth(350);
		SetWidth(40);
		SetBloodType("red");
		SetHeight(64);
		SetModel("dwarvencave/slime_ecave.mdl");
		SetModelBody(0, 0);
		SetRace("wildanimal");
		SetRoam(true);
		SetSolid("none");
		NPC_GIVE_EXP = 250;
		SetHearingSensitivity(8);
		ScheduleDelayedEvent(0.5, "slime_cycle");
		SetDamageResistance("pierce", 0.25);
		SetDamageResistance("slash", 0.75);
		SetDamageResistance("blunt", 1.0);
		SetDamageResistance("cold", 1.5);
		SetDamageResistance("fire", 0);
		SetDamageResistance("stun", 0.25);
	}

	void bite1()
	{
		npcatk_dodamage(HUNT_LASTTARGET, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "fire");
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
