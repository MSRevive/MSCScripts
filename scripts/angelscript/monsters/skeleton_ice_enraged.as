#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class SkeletonIceEnraged : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_BLAST;
	string ANIM_RUN;
	string ANIM_SMASH;
	string ANIM_SWIPE;
	string ANIM_WALK;
	float ATTACK_HITCHANCE;
	int BOLT_CHECKING;
	int BOLT_DAMAGE;
	float BOLT_FREQUENCY;
	int DAMAGE_TRACKER;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	float FREEZE_CHANCE;
	float FREQ_RETREAT;
	int ICE_BLASTING;
	string NEXT_RETREAT;
	int NPC_GIVE_EXP;
	int RUN_THRESHOLD;
	string SET_GREEK;
	int SKEL_HP;
	float SKEL_RESPAWN_CHANCE;
	int SKEL_RESPAWN_LIVES;
	int SMASH_DAMAGE;
	string SOUND_BOLT;
	float STUCK_CHECK_FREQUENCY;
	int SWIPE_DAMAGE;

	SkeletonIceEnraged()
	{
		FREQ_RETREAT = 20.0;
		SKEL_HP = 1000;
		ATTACK_HITCHANCE = 0.85;
		NPC_GIVE_EXP = 200;
		SMASH_DAMAGE = RandomInt(50, 100);
		SWIPE_DAMAGE = RandomInt(10, 20);
		ANIM_ATTACK = "attack1";
		ANIM_WALK = "run";
		ANIM_RUN = "run";
		ANIM_SWIPE = "attack1";
		ANIM_SMASH = "attack2";
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 20;
		DROP_GOLD_MAX = 45;
		SKEL_RESPAWN_CHANCE = 0.5;
		SKEL_RESPAWN_LIVES = 1;
		ANIM_BLAST = "rlflinch";
		SOUND_BOLT = "magic/ice_strike.wav";
		BOLT_FREQUENCY = "$randf(15,60)";
		BOLT_DAMAGE = 30;
		FREEZE_CHANCE = 0.5;
		RUN_THRESHOLD = 200;
		STUCK_CHECK_FREQUENCY = 2.0;
		Precache("items/proj_ice_bolt");
		Precache("monsters/skeleton_enraged.mdl");
	}

	void skeleton_spawn()
	{
		SetName("Enraged Ice Bone");
		SetRace("undead");
		SetRoam(true);
		SetDamageResistance("all", ".7");
		SetDamageResistance("fire", 1.2);
		SetDamageResistance("lightning", ".5");
		SetDamageResistance("cold", 0.0);
		SetAnimMoveSpeed(2.0);
		SetModel("monsters/skeleton_enraged.mdl");
		SetHearingSensitivity(5);
		SetMoveAnim(ANIM_RUN);
		SetModelBody(0, 5);
		SetModelBody(1, 5);
		SetStat("concentration", 30);
		SetStat("spellcasting", 30);
		DAMAGE_TRACKER = 0;
		if (StringToLower(GetMapName()) == "thanatos")
		{
			SET_GREEK = 1;
		}
		if ((SET_GREEK))
		{
			SetModelBody(0, 10);
		}
	}

	void OnPostSpawn() override
	{
		RUN_THRESHOLD = GetEntityMaxHealth(GetOwner());
		RUN_THRESHOLD *= 0.25;
	}

	void cast_bolts()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		BOLT_CHECKING = 0;
		if ((ICE_BLASTING)) return;
		if ((PLAYING_DEAD)) return;
		PlayAnim("critcal", ANIM_BLAST);
		ICE_BLASTING = 1;
		DoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), 2048, 0, 1.0, 0);
		ICE_BLASTING = 0;
	}

	void game_dodamage()
	{
		if (!(ICE_BLASTING))
		{
			if (!(FREEZE_ATTACK))
			{
				if (ANIM_ATTACK == ANIM_SMASH)
				{
					if (RandomInt(1, 4) == 1)
					{
						ApplyEffect(param2, "effects/dot_cold", 5, GetEntityIndex(GetOwner()), RandomInt(3, 5), "none");
					}
				}
			}
		}
		if ((ICE_BLASTING))
		{
			if ((param1))
			{
			}
			if (GetRelationship(param2) == "enemy")
			{
			}
			EmitSound(GetOwner(), CHAN_VOICE, SOUND_BOLT, 10);
			SetMoveDest(param2);
			TossProjectile("proj_ice_bolt", /* TODO: $relpos */ $relpos(0, 5, 10), GetEntityIndex(param2), 500, BOLT_DAMAGE, 1, "none");
		}
	}

	void npc_targetsighted()
	{
		if ((BOLT_CHECKING)) return;
		BOLT_CHECKING = 1;
		ScheduleDelayedEvent(4.0, "cast_bolts");
	}

	void attack_1()
	{
		attack_snd();
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, SWIPE_DAMAGE, ATTACK_HITCHANCE, "slash");
		if (RandomInt(1, 4) == 1)
		{
			ANIM_ATTACK = ANIM_SMASH;
		}
		ScheduleDelayedEvent(2.0, "reset_atk");
	}

	void reset_atk()
	{
		ANIM_ATTACK = ANIM_SWIPE;
	}

	void attack_2()
	{
		attack_snd();
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, SMASH_DAMAGE, ATTACK_HITCHANCE, "blunt");
		ANIM_ATTACK = ANIM_SWIPE;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if ((CHICKEN_RUN)) return;
		DAMAGE_TRACKER += param1;
		if (!(DAMAGE_TRACKER > RUN_THRESHOLD)) return;
		if (!(GetGameTime() > NEXT_RETREAT)) return;
		NEXT_RETREAT = GetGameTime();
		NEXT_RETREAT += FREQ_RETREAT;
		DAMAGE_TRACKER = 0;
		chicken_run(3.0);
	}

}

}
