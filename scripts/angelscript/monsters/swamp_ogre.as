#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SwampOgre : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_HEADBUTT;
	string ANIM_IDLE;
	string ANIM_JUMP;
	string ANIM_LEAP;
	string ANIM_RUN;
	string ANIM_RUN_DEFAULT;
	string ANIM_SEARCH;
	string ANIM_SWIPE;
	string ANIM_WALK;
	string ANIM_WALK_DEFAULT;
	string ANIM_WARCRY;
	float ATTACK_HITCHANCE;
	int CAN_FLINCH;
	int DID_WARCRY;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	float FLINCH_CHANCE;
	float FLINCH_DELAY;
	int FLINCH_HEALTH;
	float HEADBUTT_CHANCE;
	int HEADBUTT_DAMAGE;
	int HEADBUTT_DELAY;
	float HEADBUTT_FREQ;
	int HEADBUTT_ON;
	int LEAP_AWAY_INTERVAL;
	int LEAP_DAMAGE;
	int LEAP_ENABLED;
	int LEAP_RANGE_TOOCLOSE;
	int LEAP_RANGE_TOOFAR;
	float LEAP_STUNCHANCE;
	string MONSTER_MODEL;
	string NEXT_LEAP_AWAY;
	string NEXT_LEAP_AWAY_HP;
	float NPC_DELAYING_UNSTUCK;
	int NPC_FORCED_MOVEDEST;
	int NPC_GIVE_EXP;
	float ORC_HOP_DELAY;
	int ORC_JUMPING;
	int ORC_JUMP_THRESH;
	int RUN_STEP;
	int SEARCH_ANIM_DELAY;
	string SOUND_DEATH;
	string SOUND_FLINCH;
	string SOUND_HEADBUTT;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_IDLE3;
	string SOUND_IDLE4;
	string SOUND_IDLE5;
	string SOUND_LEAP;
	string SOUND_LEAP_LAND;
	string SOUND_PAIN_STRONG;
	string SOUND_PAIN_WEAK;
	string SOUND_STEP1;
	string SOUND_STEP2;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_SWIPEHIT1;
	string SOUND_SWIPEHIT2;
	string SOUND_SWIPEMISS1;
	string SOUND_SWIPEMISS2;
	string SOUND_WARCRY;
	string SWIPE_ATK;
	int SWIPE_ATTACK;
	int SWIPE_DAMAGE;
	int WEAK_THRESHOLD;

	SwampOgre()
	{
		ORC_HOP_DELAY = 1.0;
		ORC_JUMP_THRESH = 80;
		NPC_GIVE_EXP = 400;
		ANIM_SEARCH = "idle_look";
		ANIM_IDLE = "idle1";
		ANIM_SWIPE = "attack1";
		ANIM_HEADBUTT = "attack2";
		ANIM_JUMP = "jump";
		ANIM_LEAP = "jump";
		ANIM_WALK_DEFAULT = "walk";
		ANIM_RUN_DEFAULT = "run1";
		ANIM_DEATH = "dieforward";
		ANIM_WARCRY = "warcry";
		ANIM_FLINCH = "bigflinch";
		ANIM_WALK = ANIM_WALK_DEFAULT;
		ANIM_RUN = ANIM_RUN_DEFAULT;
		ANIM_ATTACK = ANIM_SWIPE;
		SOUND_IDLE1 = "bullchicken/bc_idle1.wav";
		SOUND_IDLE2 = "bullchicken/bc_idle2.wav";
		SOUND_IDLE3 = "bullchicken/bc_idle3.wav";
		SOUND_IDLE4 = "bullchicken/bc_idle4.wav";
		SOUND_IDLE5 = "bullchicken/bc_idle5.wav";
		SOUND_DEATH = "bullchicken/bc_die1.wav";
		SOUND_HEADBUTT = "bullchicken/bc_spithit1.wav";
		SOUND_SWIPEHIT1 = "zombie/claw_strike1.wav";
		SOUND_SWIPEHIT2 = "zombie/claw_strike2.wav";
		SOUND_SWIPEMISS1 = "zombie/claw_miss1.wav";
		SOUND_SWIPEMISS2 = "zombie/claw_miss2.wav";
		SOUND_STRUCK1 = "debris/flesh1.wav";
		SOUND_STRUCK2 = "debris/flesh2.wav";
		SOUND_STEP1 = "player/pl_dirt1.wav";
		SOUND_STEP2 = "player/pl_dirt2.wav";
		SOUND_PAIN_WEAK = "bullchicken/bc_pain2.wav";
		SOUND_PAIN_STRONG = "bullchicken/bc_pain1.wav";
		SOUND_WARCRY = "bullchicken/bc_attackgrowl3.wav";
		SOUND_LEAP = "bullchicken/bc_attackgrowl2.wav";
		SOUND_LEAP_LAND = "weapons/g_bounce2.wav";
		SOUND_FLINCH = "bullchicken/bc_pain3.wav";
		Precache(SOUND_DEATH);
		WEAK_THRESHOLD = 1000;
		SWIPE_DAMAGE = "$rand(50,75)";
		HEADBUTT_CHANCE = 1.0;
		HEADBUTT_FREQ = 7.0;
		HEADBUTT_DAMAGE = "$rand(50,75)";
		LEAP_DAMAGE = "$rand(10,30)";
		LEAP_STUNCHANCE = 0.3;
		LEAP_RANGE_TOOFAR = 512;
		LEAP_RANGE_TOOCLOSE = 128;
		LEAP_AWAY_INTERVAL = 500;
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 30;
		DROP_GOLD_MAX = 50;
		ATTACK_HITCHANCE = 0.95;
		CAN_FLINCH = 1;
		FLINCH_CHANCE = 0.2;
		FLINCH_DELAY = 10.0;
		FLINCH_HEALTH = 1500;
		MONSTER_MODEL = "monsters/swamp_ogre.mdl";
		Precache(MONSTER_MODEL);
	}

	void OnSpawn() override
	{
		SetName("Ogre");
		SetHealth(2000);
		SetRace("orc");
		SetRoam(true);
		SetModel(MONSTER_MODEL);
		SetMoveAnim(ANIM_WALK);
		SetHeight(64);
		SetWidth(32);
		SetHearingSensitivity(2);
		SetBloodType("green");
		SetIdleAnim(ANIM_IDLE);
		RUN_STEP = 0;
		if (!(true)) return;
		if ((G_SHAD_PRESENT))
		{
			SetRace("undead");
			SetProp(GetOwner(), "skin", 2);
		}
		else
		{
			SetRace("orc");
		}
		ScheduleDelayedEvent(1.0, "idle_sounds");
	}

	void npcatk_validatetarget()
	{
		if (!(IsValidPlayer(param1))) return;
		if ((DID_WARCRY)) return;
		PlayAnim("critical", ANIM_WARCRY);
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
		DID_WARCRY = 1;
	}

	void my_target_died()
	{
		if (!(false))
		{
			PlayAnim("critical", ANIM_WARCRY);
			EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
			DID_WARCRY = 0;
			ScheduleDelayedEvent(1.0, "enable_leap");
		}
		if ((false)) return;
		ORC_JUMPING = 0;
	}

	void enable_leap()
	{
		LEAP_ENABLED = 1;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (GetMonsterHP() < GetMonsterMaxHP())
		{
			HealEntity(GetOwner(), 0.1);
		}
		if (!(m_hAttackTarget != "unset")) return;
		if (!(GetEntityRange(m_hAttackTarget) <= LEAP_RANGE_TOOFAR)) return;
		if (!(GetEntityRange(m_hAttackTarget) > LEAP_RANGE_TOOCLOSE)) return;
		if (!(LEAP_ENABLED)) return;
		LEAP_ENABLED = 0;
		ScheduleDelayedEvent(5.0, "enable_leap");
		script_leap();
	}

	void script_leap()
	{
		PlayAnim("critical", ANIM_LEAP);
		ScheduleDelayedEvent(0.1, "leap_boost");
	}

	void leap_boost()
	{
		if ((I_R_FROZEN)) return;
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 600, 100));
	}

	void npc_selectattack()
	{
		if ((HEADBUTT_DELAY))
		{
			ANIM_ATTACK = ANIM_SWIPE;
		}
		else
		{
			if (RandomInt(1, 100) < HEADBUTT_CHANCE)
			{
				ANIM_ATTACK = ANIM_HEADBUTT;
				HEADBUTT_DELAY = 1;
				HEADBUTT_FREQ("headbutt_reset");
			}
		}
	}

	void headbutt_reset()
	{
		HEADBUTT_DELAY = 0;
	}

	void attack1()
	{
		SWIPE_ATTACK = 1;
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, SWIPE_DAMAGE, ATTACK_HITCHANCE);
	}

	void attack2()
	{
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, HEADBUTT_DAMAGE, ATTACK_HITCHANCE);
		HEADBUTT_ON = 1;
	}

	void game_dodamage()
	{
		if ((HEADBUTT_ON))
		{
			if ((param1))
			{
				EmitSound(GetOwner(), 0, SOUND_HEADBUTT, 10);
				ApplyEffect(m_hAttackTarget, "effects/debuff_stun", 5, GetEntityIndex(GetOwner()));
			}
			if (!(param1))
			{
				// PlayRandomSound from: SOUND_SWIPEMISS1, SOUND_SWIPEMISS2
				array<string> sounds = {SOUND_SWIPEMISS1, SOUND_SWIPEMISS2};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
			ANIM_ATTACK = ANIM_SWIPE;
			HEADBUTT_ON = 0;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(SWIPE_ATTACK)) return;
		SWIPE_ATTACK = 0;
		if ((param1))
		{
			SWIPE_ATK = 0;
			// PlayRandomSound from: SOUND_SWIPEHIT1, SOUND_SWIPEHIT2
			array<string> sounds = {SOUND_SWIPEHIT1, SOUND_SWIPEHIT2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			AddVelocity(m_hLastStruckByMe, /* TODO: $relvel */ $relvel(-100, 130, 120));
		}
		if (!(param1))
		{
			// PlayRandomSound from: SOUND_SWIPEMISS1, SOUND_SWIPEMISS2
			array<string> sounds = {SOUND_SWIPEMISS1, SOUND_SWIPEMISS2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (GetMonsterHP() > WEAK_THRESHOLD)
		{
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN_STRONG
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN_STRONG};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (GetMonsterHP() <= WEAK_THRESHOLD)
		{
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN_WEAK
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN_WEAK};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		string L_LEAP_THRESH = GetEntityMaxHealth(GetOwner());
		L_LEAP_THRESH *= 0.1;
		if (param1 > L_LEAP_THRESH)
		{
			if (GetGameTime() > NEXT_LEAP_AWAY)
			{
			}
			NEXT_LEAP_AWAY = GetGameTime();
			NEXT_LEAP_AWAY += Random(8.0, 12.0);
			leap_away();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (NEXT_LEAP_AWAY_HP == "NEXT_LEAP_AWAY_HP")
		{
			NEXT_LEAP_AWAY_HP = GetEntityMaxHealth(GetOwner());
			NEXT_LEAP_AWAY_HP *= 0.75;
		}
		string L_HP_AFTER = GetEntityHealth(GetOwner());
		if (!(L_HP_AFTER < NEXT_LEAP_AWAY_HP)) return;
		string L_QUARTER = GetEntityMaxHealth(GetOwner());
		L_QUARTER *= 0.25;
		NEXT_LEAP_AWAY_HP -= L_QUARTER;
		leap_away();
	}

	void leap_away()
	{
		PlayAnim("critical", ANIM_LEAP);
		SetMoveDest(m_hAttackTarget);
		ScheduleDelayedEvent(0.1, "leap_boost");
		npcatk_suspend_ai(3.0);
	}

	void leap_attack()
	{
		EmitSound(GetOwner(), 0, SOUND_LEAP, 10);
		if ((CanSee("enemy", 128)))
		{
			npcatk_dodamage(GetEntityIndex(m_hLastSeen), ATTACK_HITRANGE, LEAP_DAMAGE, ATTACK_HITCHANCE);
			if (RandomInt(1, 100) < LEAP_STUNCHANCE)
			{
				ApplyEffect(GetEntityIndex(m_hLastSeen), "effects/debuff_stun", 5, GetEntityIndex(GetOwner()));
			}
		}
	}

	void leap_done()
	{
		EmitSound(GetOwner(), 0, SOUND_LEAP_LAND, 10);
		SetMoveAnim(ANIM_RUN);
	}

	void npcatk_search_init_advanced()
	{
		if ((SEARCH_ANIM_DELAY)) return;
		NPC_DELAYING_UNSTUCK = 10.0;
		PlayAnim("critical", ANIM_SEARCH);
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4, SOUND_IDLE5
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4, SOUND_IDLE5};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		SEARCH_ANIM_DELAY = 1;
		ScheduleDelayedEvent(5.0, "reset_search_anim");
	}

	void reset_search_anim()
	{
		SEARCH_ANIM_DELAY = 0;
	}

	void OnFlinch()
	{
		EmitSound(GetOwner(), 0, SOUND_FLINCH, 10);
	}

	void idle_sounds()
	{
		Random(3, 10)("idle_sounds");
		if (!(m_hAttackTarget == "unset")) return;
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4, SOUND_IDLE5
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4, SOUND_IDLE5};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void run_step1()
	{
		EmitSound(GetOwner(), 0, SOUND_STEP1, 5);
	}

	void run_step2()
	{
		EmitSound(GetOwner(), 0, SOUND_STEP2, 5);
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if ((ORC_JUMPING)) return;
		if (!(IsValidPlayer(m_hAttackTarget))) return;
		ORC_JUMPING = 1;
		ScheduleDelayedEvent(1.0, "orc_jump_check");
	}

	void orc_jump_check()
	{
		if (!(ORC_JUMPING)) return;
		ORC_HOP_DELAY("orc_jump_check");
		if ((IS_FLEEING)) return;
		if (!(m_hAttackTarget != "unset")) return;
		if (!(false)) return;
		string ME_POS = GetMonsterProperty("origin");
		string MY_Z = (ME_POS).z;
		string TARGET_POS = GetEntityOrigin(m_hAttackTarget);
		string TARGET_Z = (TARGET_POS).z;
		string TARGET_Z_DIFFERENCE = TARGET_Z;
		TARGET_Z_DIFFERENCE -= MY_Z;
		if (TARGET_Z_DIFFERENCE > ORC_JUMP_THRESH)
		{
			orc_hop();
		}
	}

	void orc_hop()
	{
		NPC_FORCED_MOVEDEST = 1;
		SetMoveDest(m_hAttackTarget);
		PlayAnim("critical", ANIM_LEAP);
		EmitSound(GetOwner(), 0, SOUND_LEAP, 10);
		int JUMP_HEIGHT = RandomInt(550, 650);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 250, JUMP_HEIGHT));
	}

	void bo_zombie_mode()
	{
		npc_suicide();
	}

}

}
