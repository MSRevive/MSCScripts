#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class KLarva : CGameScript
{
	int AM_EATING;
	string ANIM_ATTACK;
	string ANIM_CLAW1;
	string ANIM_CLAW2;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_IDLE1;
	string ANIM_IDLE2;
	string ANIM_LICK;
	string ANIM_RUN;
	string ANIM_RUN_FAST;
	string ANIM_RUN_NORM;
	string ANIM_SEARCH;
	string ANIM_VICTORY;
	string ANIM_VICTORY_LOOP;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string ATTACK_TYPE;
	int CAN_FLINCH;
	int CHANCE_LICK_STUN;
	int DID_WARCRY;
	int DMG_CLAW1;
	int DMG_CLAW2;
	int DMG_LICK;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	int FLINCH_CHANCE;
	int FLINCH_DAMAGE_THRESHOLD;
	float FLINCH_DELAY;
	int FLINCH_HEALTH;
	float FREQ_IDLE;
	float FREQ_LOOK;
	int IS_UNHOLY;
	int NPC_GIVE_EXP;
	string SEARCH_DELAY;
	string SOUND_ANGRY1;
	string SOUND_ANGRY2;
	string SOUND_ANGRY3;
	string SOUND_CLAW_HIT1;
	string SOUND_CLAW_HIT2;
	string SOUND_CRAWL1;
	string SOUND_CRAWL2;
	string SOUND_DEATH;
	string SOUND_EAT;
	string SOUND_GETUP;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_IDLE3;
	string SOUND_IDLE4;
	string SOUND_IDLE5;
	string SOUND_IDLE6;
	string SOUND_LICK_HIT;
	string SOUND_MISS1;
	string SOUND_MISS2;
	string SOUND_SEARCH1;
	string SOUND_SEARCH2;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_WARCRY;

	KLarva()
	{
		IS_UNHOLY = 1;
		ANIM_WALK = "walk";
		ANIM_RUN = "runlong";
		ANIM_IDLE = "idle1";
		ANIM_ATTACK = "attack1";
		ANIM_DEATH = "diesimple";
		ANIM_FLINCH = "flinch";
		ANIM_IDLE1 = "idle1";
		ANIM_IDLE2 = "idle2";
		ANIM_SEARCH = "idle1";
		ANIM_LICK = "attack1";
		ANIM_CLAW1 = "attack2";
		ANIM_CLAW2 = "attack3";
		ANIM_RUN_FAST = "runshort";
		ANIM_RUN_NORM = "runlong";
		ANIM_VICTORY = "victoryeat1";
		ANIM_VICTORY_LOOP = "eat_loop";
		ATTACK_RANGE = 60;
		ATTACK_HITRANGE = 120;
		ATTACK_MOVERANGE = 50;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(10, 20);
		NPC_GIVE_EXP = 150;
		CAN_FLINCH = 1;
		FLINCH_CHANCE = 90;
		FLINCH_HEALTH = 600;
		FLINCH_DAMAGE_THRESHOLD = 30;
		FLINCH_DELAY = 30.0;
		ATTACK_HITCHANCE = 80;
		DMG_LICK = RandomInt(20, 40);
		DMG_CLAW1 = RandomInt(30, 80);
		DMG_CLAW2 = RandomInt(30, 80);
		FREQ_IDLE = Random(5, 10);
		CHANCE_LICK_STUN = 50;
		FREQ_LOOK = 10.0;
		SOUND_LICK_HIT = "barnacle/bcl_tongue1.wav";
		SOUND_WARCRY = "barnacle/bcl_alert2.wav";
		SOUND_MISS1 = "zombie/claw_miss1.wav";
		SOUND_MISS2 = "zombie/claw_miss2.wav";
		SOUND_CLAW_HIT1 = "zombie/claw_strike1.wav";
		SOUND_CLAW_HIT2 = "zombie/claw_strike2.wav";
		SOUND_IDLE1 = "bullchicken/bc_idle1.wav";
		SOUND_IDLE2 = "bullchicken/bc_idle3.wav";
		SOUND_IDLE3 = "bullchicken/bc_idle4.wav";
		SOUND_IDLE4 = "bullchicken/bc_idle5.wav";
		SOUND_IDLE5 = "houndeye/he_die2.wav";
		SOUND_IDLE6 = "houndeye/he_die3.wav";
		SOUND_SEARCH1 = "bullchicken/bc_die3.wav";
		SOUND_SEARCH2 = "houndeye/he_alert2.wav";
		SOUND_EAT = "monsters/gonome/gonome_eat.wav";
		SOUND_CRAWL1 = "barnacle/bcl_chew1.wav";
		SOUND_CRAWL2 = "barnacle/bcl_chew2.wav";
		SOUND_ANGRY1 = "agrunt/ag_alert2.wav";
		SOUND_ANGRY2 = "agrunt/ag_alert3.wav";
		SOUND_ANGRY3 = "agrunt/ag_alert4.wav";
		SOUND_STRUCK1 = "debris/flesh1.wav";
		SOUND_STRUCK2 = "debris/flesh2.wav";
		SOUND_GETUP = "bullchicken/bc_pain4.wav";
		SOUND_DEATH = "agrunt/ag_die2.wav";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(FREQ_IDLE);
		if (m_hAttackTarget != "unset")
		{
			// PlayRandomSound from: SOUND_ANGRY1, SOUND_ANGRY2, SOUND_ANGRY3
			array<string> sounds = {SOUND_ANGRY1, SOUND_ANGRY2, SOUND_ANGRY3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (m_hAttackTarget == "unset")
		{
		}
		if ((AM_EATING))
		{
			if (GetMonsterHP() < GetMonsterMaxHP())
			{
				HealEntity(GetOwner(), 100);
			}
			EmitSound(GetOwner(), 0, SOUND_EAT, 10);
		}
		if (!(AM_EATING))
		{
		}
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4, SOUND_IDLE5, SOUND_IDLE6
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4, SOUND_IDLE5, SOUND_IDLE6};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		int RND_IDLE = RandomInt(1, 2);
		if (RND_IDLE == 1)
		{
			PlayAnim("critical", ANIM_IDLE1);
		}
		if (RND_IDLE == 2)
		{
			PlayAnim("critical", ANIM_IDLE2);
		}
	}

	void OnSpawn() override
	{
		larva_spawn();
	}

	void larva_spawn()
	{
		SetName("Kharaztorant Larva");
		SetModel("monsters/k_larva.mdl");
		SetHealth(800);
		SetRace("demon");
		SetWidth(32);
		SetHeight(48);
		SetRoam(true);
		SetHearingSensitivity(6);
	}

	void OnPostSpawn() override
	{
		SetDamageResistance("holy", 1.0);
		SetDamageResistance("fire", 0.5);
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
	}

	void npcatk_lost_sight()
	{
		if ((false)) return;
		// PlayRandomSound from: SOUND_SEARCH1, SOUND_SEARCH2
		array<string> sounds = {SOUND_SEARCH1, SOUND_SEARCH2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (!(SEARCH_DELAY))
		{
			SEARCH_DELAY = 1;
			FREQ_LOOK("reset_search_delay");
			PlayAnim("once", ANIM_SEARCH);
		}
		AS_ATTACKING = GetGameTime();
	}

	void reset_search_delay()
	{
		SEARCH_DELAY = 0;
	}

	void my_target_died()
	{
		PlayAnim("critical", ANIM_VICTORY);
		EmitSound(GetOwner(), 0, SOUND_EAT, 10);
		SetRoam(false);
		SetIdleAnim(ANIM_VICTORY_LOOP);
		SetMoveAnim(ANIM_VICTORY_LOOP);
		AM_EATING = 1;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
		AM_EATING = 0;
	}

	void npc_targetsighted()
	{
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
		AM_EATING = 0;
		if ((DID_WARCRY)) return;
		DID_WARCRY = 1;
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
		PlayAnim("critical", ANIM_IDLE2);
		AS_ATTACKING = GetGameTime();
	}

	void npc_selectattack()
	{
		int RND_ATK = RandomInt(1, 6);
		if (RND_ATK <= 2)
		{
			ANIM_ATTACK = ANIM_CLAW1;
		}
		if (RND_ATK > 3)
		{
			ANIM_ATTACK = ANIM_CLAW2;
		}
		if (RND_ATK == 6)
		{
			ANIM_ATTACK = ANIM_LICK;
		}
	}

	void crawl_step()
	{
		// PlayRandomSound from: SOUND_CRAWL1, SOUND_CRAWL2
		array<string> sounds = {SOUND_CRAWL1, SOUND_CRAWL2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 8);
	}

	void attack_lick()
	{
		ATTACK_TYPE = "attack_lick";
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_LICK, ATTACK_HITCHANCE, "blunt");
		ANIM_ATTACK = ANIM_CLAW1;
	}

	void attack_claw1()
	{
		ATTACK_TYPE = "attack_claw1";
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_CLAW1, ATTACK_HITCHANCE, "blunt");
	}

	void attack_claw2()
	{
		ATTACK_TYPE = "attack_claw2";
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_CLAW2, ATTACK_HITCHANCE, "blunt");
		ANIM_ATTACK = ANIM_CLAW1;
	}

	void game_dodamage()
	{
		if (!(param1))
		{
			// PlayRandomSound from: SOUND_MISS1, SOUND_MISS2
			array<string> sounds = {SOUND_MISS1, SOUND_MISS2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (ATTACK_TYPE == "attack_claw1")
		{
			if ((param1))
			{
			}
			// PlayRandomSound from: SOUND_CLAW_HIT1, SOUND_CLAW_HIT2
			array<string> sounds = {SOUND_CLAW_HIT1, SOUND_CLAW_HIT2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (ATTACK_TYPE == "attack_lick")
		{
			if ((param1))
			{
			}
			EmitSound(GetOwner(), 0, SOUND_LICK_HIT, 10);
			if (RandomInt(1, 100) < CHANCE_LICK_STUN)
			{
			}
			AddVelocity(param2, /* TODO: $relvel */ $relvel(-200, -10, 10));
			LogDebug("temp apply stun");
			ApplyEffect(param2, "effects/dot_poison", Random(3, 5), GetEntityIndex(GetOwner()), 0);
		}
		if (ATTACK_TYPE == "attack_claw2")
		{
			if ((param1))
			{
			}
			AddVelocity(param2, /* TODO: $relvel */ $relvel(-400, -100, 50));
			// PlayRandomSound from: SOUND_CLAW_HIT1, SOUND_CLAW_HIT2
			array<string> sounds = {SOUND_CLAW_HIT1, SOUND_CLAW_HIT2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		ATTACK_TYPE = "none";
	}

	void OnFlinch()
	{
		EmitSound(GetOwner(), 0, SOUND_DEATH, 10);
		ScheduleDelayedEvent(1.0, "snap_to");
	}

	void snap_to()
	{
		EmitSound(GetOwner(), 0, SOUND_GETUP, 10);
	}

}

}
