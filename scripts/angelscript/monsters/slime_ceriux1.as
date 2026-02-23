#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SlimeCeriux1 : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int DELAY_ATTACK;
	int MOVE_RANGE;
	int NO_SPAWN_STUCK_CHECK;
	int NPC_GIVE_EXP;
	string NPC_HACKED_MOVE_SPEED;

	SlimeCeriux1()
	{
		const string SOUND_DEATH = "monsters/sludge/bio.wav";
		const string SOUND_STRUCK1 = "barnacle/bcl_bite3.wav";
		const string SOUND_STRUCK2 = "barnacle/bcl_die3.wav";
		const string SOUND_IDLE = "barnacle/bcl_alert2.wav";
		const string SOUND_ATTACK1 = "barnacle/bcl_tongue1.wav";
		const string SOUND_ATTACK2 = "barnacle/bcl_chew3.wav";
		Precache(SOUND_DEATH);
		ANIM_IDLE = "Idle1";
		ANIM_RUN = "Idle2";
		ANIM_WALK = "move";
		ANIM_ATTACK = "Move";
		ANIM_DEATH = "die";
		MOVE_RANGE = 20;
		ATTACK_RANGE = 60;
		ATTACK_HITRANGE = 120;
		const float ATTACK_HITCHANCE = 0.75;
		const string ATTACK_DAMAGE = Random(1, 3);
		NO_SPAWN_STUCK_CHECK = 1;
		const int MOVE_FAST = 200;
		const int MOVE_NORMAL = 100;
		NPC_HACKED_MOVE_SPEED = MOVE_NORMAL;
		const float ATTACK_RATE = 1.0;
	}

	void OnSpawn() override
	{
		SetName("Sewer Slime");
		SetHealth(20);
		SetWidth(20);
		SetBloodType("green");
		SetHeight(20);
		SetHearingSensitivity(4);
		SetModel("monsters/slime_ceirux.mdl");
		SetRace("wildanimal");
		if (!(ME_NO_WANDER))
		{
			SetRoam(true);
		}
		if ((ME_NO_WANDER))
		{
			SetRoam(false);
		}
		SetSolid("none");
		NPC_GIVE_EXP = 10;
		ScheduleDelayedEvent(2.0, "slime_cycle");
	}

	void bite1()
	{
		npcatk_dodamage(HUNT_LASTTARGET, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "acid");
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

	void slime_cycle()
	{
		if (m_hAttackTarget == "unset")
		{
			if (RandomInt(1, 5) == 1)
			{
			}
			EmitSound(GetOwner(), 0, SOUND_IDLE, 10);
		}
		if (m_hAttackTarget != "unset")
		{
			if (RandomInt(1, 3) == 1)
			{
			}
			chicken_run(1.0, "combat_reposition");
		}
		ScheduleDelayedEvent(2.0, "slime_cycle");
	}

	void game_movingto_dest()
	{
		NPC_HACKED_MOVE_SPEED = MOVE_FAST;
		if ((SHIELD_ON))
		{
			NPC_HACKED_MOVE_SPEED = MOVE_NORMAL;
		}
		if (m_hAttackTarget == "unset")
		{
			NPC_HACKED_MOVE_SPEED = MOVE_NORMAL;
		}
		if ((PLAYING_STAB))
		{
			NPC_HACKED_MOVE_SPEED = 0;
		}
		if ((AM_SUMMONING))
		{
			NPC_HACKED_MOVE_SPEED = 0;
		}
		SetAnimMoveSpeed(NPC_HACKED_MOVE_SPEED);
	}

	void game_stopmoving()
	{
		SetAnimMoveSpeed(0);
	}

	void npcatk_attack()
	{
		if ((DELAY_ATTACK)) return;
		DELAY_ATTACK = 1;
		PlayAnim("critical", "Attack1");
		bite1();
		ATTACK_RATE("attack_delay_reset");
	}

	void attack_delay_reset()
	{
		DELAY_ATTACK = 0;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		npc_fade_away();
	}

	void cycle_up()
	{
		if ((ME_NO_WANDER))
		{
			SetRoam(true);
		}
	}

}

}
