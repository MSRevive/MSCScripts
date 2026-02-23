#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class OgreCaveThug : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_RUN_DEFAULT;
	string ANIM_WALK;
	string ANIM_WALK_DEFAULT;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int DID_WARCRY;
	string NEXT_CUSTOM_FLINCH;
	string NEXT_IDLE_SOUND;
	int NPC_GIVE_EXP;
	int REGEN_RATE;
	int RUN_STEP;
	string SLAM_COUNT;
	string SLAM_LOC;
	string STEP_COUNT;
	int SWIPE_ATTACK;
	string TEN_PERCENT_HP;
	string WEAK_THRESHOLD;

	OgreCaveThug()
	{
		const string ANIM_SEARCH = "idle_look";
		ANIM_IDLE = "idle1";
		const string ANIM_SWIPE = "attack1";
		const string ANIM_HEADBUTT = "attack2";
		const string ANIM_JUMP = "jump";
		const string ANIM_LEAP = "jump";
		ANIM_WALK_DEFAULT = "walk";
		ANIM_RUN_DEFAULT = "run1";
		ANIM_DEATH = "dieforward";
		const string ANIM_WARCRY = "warcry";
		ANIM_FLINCH = "bigflinch";
		const string ANIM_BEAM = "beam";
		const string ANIM_BEATDOWN = "anim_beatdown";
		const string ANIM_SLAM = "anim_slam";
		ANIM_WALK = ANIM_WALK_DEFAULT;
		ANIM_RUN = ANIM_RUN_DEFAULT;
		ANIM_ATTACK = ANIM_BEATDOWN;
		const string SOUND_IDLE1 = "bullchicken/bc_idle1.wav";
		const string SOUND_IDLE2 = "bullchicken/bc_idle2.wav";
		const string SOUND_IDLE3 = "bullchicken/bc_idle3.wav";
		const string SOUND_IDLE4 = "bullchicken/bc_idle4.wav";
		const string SOUND_IDLE5 = "bullchicken/bc_idle5.wav";
		const string SOUND_DEATH = "bullchicken/bc_die1.wav";
		const string SOUND_HEADBUTT = "bullchicken/bc_spithit1.wav";
		const string SOUND_SWIPEHIT1 = "zombie/claw_strike1.wav";
		const string SOUND_SWIPEHIT2 = "zombie/claw_strike2.wav";
		const string SOUND_SWIPEMISS1 = "zombie/claw_miss1.wav";
		const string SOUND_SWIPEMISS2 = "zombie/claw_miss2.wav";
		const string SOUND_STRUCK1 = "debris/flesh1.wav";
		const string SOUND_STRUCK2 = "debris/flesh2.wav";
		const string SOUND_STEP1 = "player/pl_slosh1.wav";
		const string SOUND_STEP2 = "player/pl_slosh2.wav";
		const string SOUND_PAIN_WEAK = "bullchicken/bc_pain2.wav";
		const string SOUND_PAIN_STRONG = "bullchicken/bc_pain1.wav";
		const string SOUND_WARCRY = "bullchicken/bc_attackgrowl3.wav";
		const string SOUND_LEAP = "bullchicken/bc_attackgrowl2.wav";
		const string SOUND_LEAP_LAND = "weapons/g_bounce2.wav";
		const string SOUND_FLINCH = "bullchicken/bc_pain3.wav";
		const string SOUND_BEATDOWN_START = "bullchicken/bc_attackgrowl2.wav";
		const string SOUND_SLAM_START = "bullchicken/bc_attackgrowl3.wav";
		NPC_GIVE_EXP = 2000;
		const float ATTACK_HITCHANCE = 0.95;
		const string SWIPE_DAMAGE = RandomInt(150, 275);
		const int SLAM_DAMAGE = 200;
		ATTACK_RANGE = 64;
		ATTACK_HITRANGE = 80;
	}

	void OnSpawn() override
	{
		SetName("Cave Ogre Thug");
		SetModel("monsters/ogre_cave_thug.mdl");
		SetHealth(5000);
		SetRace("orc");
		SetRoam(true);
		SetMoveAnim(ANIM_WALK);
		SetHeight(96);
		SetWidth(32);
		SetHearingSensitivity(2);
		SetBloodType("green");
		SetIdleAnim(ANIM_IDLE);
		SetDamageResistance("poison", 1.5);
		SetDamageResistance("acid", 1.5);
		RUN_STEP = 0;
		if (!(true)) return;
		ScheduleDelayedEvent(1.0, "idle_sounds");
		ScheduleDelayedEvent(2.0, "final_postspawn");
	}

	void final_postspawn()
	{
		WEAK_THRESHOLD = GetEntityMaxHealth(GetOwner());
		WEAK_THRESHOLD *= 0.5;
		TEN_PERCENT_HP = GetEntityMaxHealth(GetOwner());
		TEN_PERCENT_HP *= 0.1;
		REGEN_RATE = 2;
		if (NPC_HP_MULTI > 1)
		{
			REGEN_RATE *= NPC_HP_MULTI;
		}
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
		}
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (GetMonsterHP() < GetMonsterMaxHP())
		{
			HealEntity(GetOwner(), REGEN_RATE);
		}
		if (!(GetGameTime() > NEXT_IDLE_SOUND)) return;
		NEXT_IDLE_SOUND = GetGameTime();
		NEXT_IDLE_SOUND += Random(3.0, 10.0);
		if (!(m_hAttackTarget == "unset")) return;
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4, SOUND_IDLE5
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4, SOUND_IDLE5};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void attack1()
	{
		SWIPE_ATTACK = 1;
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, SWIPE_DAMAGE, ATTACK_HITCHANCE, "slash");
	}

	void frame_beatdown_start()
	{
		EmitSound(GetOwner(), 0, SOUND_BEATDOWN_START, 10);
	}

	void frame_beatdown()
	{
		LogDebug("frame_beatdown");
		SWIPE_ATTACK = 1;
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, SWIPE_DAMAGE, ATTACK_HITCHANCE, "slash");
		do_step();
	}

	void frame_beatdown_final()
	{
		SWIPE_ATTACK = 1;
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, SWIPE_DAMAGE, ATTACK_HITCHANCE, "slash");
		SLAM_COUNT += 1;
		if (SLAM_COUNT == 5)
		{
			ANIM_ATTACK = ANIM_SLAM;
			SLAM_COUNT = 0;
			PlayAnim("hold", ANIM_SLAM);
		}
		do_step();
	}

	void frame_slam_start()
	{
		EmitSound(GetOwner(), 0, SOUND_SLAM_START, 10);
	}

	void frame_slam()
	{
		ANIM_ATTACK = ANIM_BEATDOWN;
		string LAND_POS = /* TODO: $relpos */ $relpos(0, 64, 0);
		ClientEvent("new", "all", "effects/sfx_stun_burst", LAND_POS, 256, 0, 0);
		SLAM_LOC = LAND_POS;
		XDoDamage(LAND_POS, 128, SLAM_DAMAGE, 0, GetOwner(), GetOwner(), "none", "blunt_effect", "dmgevent:slam");
		do_step();
		ScheduleDelayedEvent(1.0, "break_slam");
	}

	void break_slam()
	{
		PlayAnim("once", "break");
	}

	void slam_dodamage()
	{
		if (!(param1)) return;
		if (GetRelationship(param2) == "enemy")
		{
			int L_IS_NME = 1;
		}
		int L_PUSH_VEL = 2000;
		if (!(L_IS_NME))
		{
			int PUSH_VEL = 500;
		}
		string TARG_ORG = GetEntityOrigin(param2);
		string MY_ORG = SLAM_POS;
		string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		string NEW_YAW = TARG_ANG;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, L_PUSH_VEL, 110)));
		if (!(L_IS_NME)) return;
		ApplyEffect(param2, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
	}

	void game_dodamage()
	{
		if ((SWIPE_ATTACK))
		{
			if ((param1))
			{
				// PlayRandomSound from: SOUND_SWIPEHIT1, SOUND_SWIPEHIT2
				array<string> sounds = {SOUND_SWIPEHIT1, SOUND_SWIPEHIT2};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
				if (RandomInt(1, 2) == 1)
				{
					int RL_VEL = -100;
				}
				else
				{
					int RL_VEL = 100;
				}
				AddVelocity(param2, /* TODO: $relvel */ $relvel(RL_VEL, 300, 110));
			}
			if (!(param1))
			{
				// PlayRandomSound from: SOUND_SWIPEMISS1, SOUND_SWIPEMISS2
				array<string> sounds = {SOUND_SWIPEMISS1, SOUND_SWIPEMISS2};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
		}
		SWIPE_ATTACK = 0;
	}

	void run_step1()
	{
		do_step();
	}

	void run_step2()
	{
		do_step();
	}

	void do_step()
	{
		STEP_COUNT += 1;
		if (STEP_COUNT == 1)
		{
			EmitSound(GetOwner(), 0, SOUND_STEP1, 5);
		}
		if (STEP_COUNT == 2)
		{
			STEP_COUNT = 0;
			EmitSound(GetOwner(), 0, SOUND_STEP2, 5);
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
			int DO_FLINCH = 1;
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN_WEAK
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN_WEAK};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (param1 > TEN_PERCENT_HP)
		{
			int DO_FLINCH = 1;
		}
		if (!(DO_FLINCH)) return;
		if (!(GetGameTime() > NEXT_CUSTOM_FLINCH)) return;
		NEXT_CUSTOM_FLINCH = GetGameTime();
		NEXT_CUSTOM_FLINCH += 30.0;
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 5.0;
		string RND_FLINCH = RandomInt(1, 6);
		if (RND_FLINCH == 1)
		{
			PlayAnim("critical", "flinch");
		}
		if (RND_FLINCH == 2)
		{
			PlayAnim("critical", "bigflinch");
		}
		if (RND_FLINCH == 3)
		{
			PlayAnim("critical", "raflinch");
		}
		if (RND_FLINCH == 4)
		{
			PlayAnim("critical", "raflinch");
		}
		if (RND_FLINCH == 5)
		{
			PlayAnim("critical", "llflinch");
		}
		if (RND_FLINCH == 6)
		{
			PlayAnim("critical", "rlflinch");
		}
	}

}

}
