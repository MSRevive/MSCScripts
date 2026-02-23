#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class DjinnOgreFire : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_RUN_DEFAULT;
	string ANIM_WALK;
	string ANIM_WALK_DEFAULT;
	string BREATH_ANG;
	int BREATH_COUNT;
	string BURST_TARGS;
	int CAN_FLINCH;
	string CLOUD_TARGS;
	string CL_IDX;
	int CL_REFRESH_LOOP_ON;
	int CUR_SPECIAL;
	int DID_WARCRY;
	int DOING_FIRE_BURST;
	int DOING_FIRE_STORM;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int FIRE_BREATH_ON;
	float FLINCH_CHANCE;
	float FLINCH_DELAY;
	int FLINCH_HEALTH;
	int HEADBUTT_DELAY;
	int HEADBUTT_ON;
	int LEAP_AWAY_INTERVAL;
	int LEAP_ENABLED;
	string NEXT_DMG_LEAP_AWAY;
	string NEXT_SCAN;
	string NEXT_SPECIAL;
	float NPC_DELAYING_UNSTUCK;
	int NPC_FORCED_MOVEDEST;
	int NPC_GIVE_EXP;
	int ORC_JUMPING;
	int RUN_STEP;
	int SEARCH_ANIM_DELAY;
	int SWIPE_ATTACK;

	DjinnOgreFire()
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
		ANIM_WALK = ANIM_WALK_DEFAULT;
		ANIM_RUN = ANIM_RUN_DEFAULT;
		ANIM_ATTACK = ANIM_SWIPE;
		const float ORC_HOP_DELAY = 1.0;
		const int ORC_JUMP_THRESH = 80;
		NPC_GIVE_EXP = 1500;
		const float DOT_FIRE = 20.0;
		const float DOT_FIRE_SPELL = 40.0;
		const string FREQ_SPECIAL = Random(10.0, 20.0);
		const string SOUND_BREATH = "monsters/goblin/sps_fogfire.wav";
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
		const string SOUND_STEP1 = "player/pl_dirt1.wav";
		const string SOUND_STEP2 = "player/pl_dirt2.wav";
		const string SOUND_PAIN_WEAK = "bullchicken/bc_pain2.wav";
		const string SOUND_PAIN_STRONG = "bullchicken/bc_pain1.wav";
		const string SOUND_WARCRY = "bullchicken/bc_attackgrowl3.wav";
		const string SOUND_LEAP = "bullchicken/bc_attackgrowl2.wav";
		const string SOUND_LEAP_LAND = "weapons/g_bounce2.wav";
		const string SOUND_FLINCH = "bullchicken/bc_pain3.wav";
		Precache(SOUND_DEATH);
		const int WEAK_THRESHOLD = 1000;
		const string SWIPE_DAMAGE = "$rand(50,75)";
		const float HEADBUTT_CHANCE = 1.0;
		const float HEADBUTT_FREQ = 7.0;
		const string HEADBUTT_DAMAGE = "$rand(50,75)";
		const string LEAP_DAMAGE = "$rand(10,30)";
		const float LEAP_STUNCHANCE = 0.3;
		const int LEAP_RANGE_TOOFAR = 512;
		const int LEAP_RANGE_TOOCLOSE = 128;
		LEAP_AWAY_INTERVAL = 500;
		const string FREQ_LEAP_AWAY = Random(5.0, 15.0);
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 30;
		DROP_GOLD_MAX = 50;
		const float ATTACK_HITCHANCE = 0.95;
		CAN_FLINCH = 1;
		FLINCH_CHANCE = 0.2;
		FLINCH_DELAY = 10.0;
		FLINCH_HEALTH = 1500;
		const string MONSTER_MODEL = "monsters/swamp_ogre.mdl";
		Precache(MONSTER_MODEL);
	}

	void game_precache()
	{
		Precache("monsters/djinn_ogre_fire_cl");
	}

	void OnSpawn() override
	{
		SetName("Lesser Fire Djinn");
		SetHealth(2000);
		SetRace("orc");
		if (!(START_SUSPEND))
		{
			SetRoam(true);
		}
		SetModel(MONSTER_MODEL);
		SetMoveAnim(ANIM_WALK);
		SetHeight(64);
		SetWidth(32);
		SetHearingSensitivity(2);
		SetBloodType("green");
		SetIdleAnim(ANIM_IDLE);
		SetProp(GetOwner(), "skin", 5);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 1.5);
		SetDamageResistance("holy", 0.5);
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
		CUR_SPECIAL = 1;
		if (!(START_SUSPEND))
		{
			ScheduleDelayedEvent(1.0, "idle_sounds");
		}
		ScheduleDelayedEvent(2.0, "final_postspawn");
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
			if (!(LEAP_ENABLED))
			{
			}
			ScheduleDelayedEvent(1.0, "enable_leap");
		}
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
		if ((DOING_FIRE_STORM)) return;
		if ((DOING_FIRE_BURST)) return;
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
			// PlayRandomSound from: SOUND_SWIPEHIT1, SOUND_SWIPEHIT2
			array<string> sounds = {SOUND_SWIPEHIT1, SOUND_SWIPEHIT2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			AddVelocity(m_hLastStruckByMe, /* TODO: $relvel */ $relvel(-100, 130, 120));
			ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_FIRE);
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
		if ((DOING_FIRE_STORM)) return;
		if ((DOING_FIRE_BURST)) return;
		if (param1 > 200)
		{
			if (GetGameTime() > NEXT_DMG_LEAP_AWAY)
			{
			}
			NEXT_DMG_LEAP_AWAY = GetGameTime();
			NEXT_DMG_LEAP_AWAY += FREQ_LEAP_AWAY;
			leap_away();
		}
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
		string JUMP_HEIGHT = RandomInt(550, 650);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 250, JUMP_HEIGHT));
	}

	void my_target_died()
	{
		if ((false)) return;
		ORC_JUMPING = 0;
	}

	void bo_zombie_mode()
	{
		npc_suicide();
	}

	void cycle_up()
	{
		NEXT_SPECIAL = GetGameTime();
		NEXT_SPECIAL += FREQ_SPECIAL;
	}

	void npc_targetsighted()
	{
		if ((DOING_FIRE_STORM)) return;
		if ((DOING_FIRE_BURST)) return;
		if ((SUSPEND_AI)) return;
		if ((I_R_FROZEN)) return;
		if (!(GetGameTime() > NEXT_SPECIAL)) return;
		NEXT_SPECIAL = GetGameTime();
		NEXT_SPECIAL += FREQ_SPECIAL;
		if (CUR_SPECIAL > 3)
		{
			CUR_SPECIAL = 1;
		}
		if (CUR_SPECIAL == 3)
		{
			if (GetEntityRange(m_hAttackTarget) < 512)
			{
			}
			do_fire_burst();
			CUR_SPECIAL += 1;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (CUR_SPECIAL == 2)
		{
			if (GetEntityRange(m_hAttackTarget) < 512)
			{
			}
			do_fire_burst();
			CUR_SPECIAL += 1;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (CUR_SPECIAL == 1)
		{
			if (GetEntityRange(m_hAttackTarget) < 256)
			{
			}
			do_fire_storm();
			CUR_SPECIAL += 1;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
	}

	void do_fire_burst()
	{
		DOING_FIRE_BURST = 1;
		XDoDamage(GetEntityOrigin(GetOwner()), 128, DOT_FIRE_SPELL, 0, GetOwner(), GetOwner(), "none", "fire_effect");
		npcatk_suspend_ai();
		npcatk_suspend_movement(ANIM_WARCRY);
		PlayAnim("critical", ANIM_WARCRY);
		ClientEvent("new", "all", "effects/sfx_fire_burst", GetEntityOrigin(GetOwner()), 768, 1, Vector3(255, 128, 0));
		BURST_TARGS = FindEntitiesInSphere("enemy", 768);
		if (!(BURST_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(BURST_TARGS, ";"); i++)
		{
			fire_burst_affect_targets();
		}
		ScheduleDelayedEvent(1.5, "end_fire_burst");
	}

	void end_fire_burst()
	{
		NEXT_SPECIAL = GetGameTime();
		NEXT_SPECIAL += FREQ_SPECIAL;
		npcatk_resume_ai();
		npcatk_resume_movement();
		DOING_FIRE_BURST = 0;
	}

	void fire_burst_affect_targets()
	{
		string CUR_TARG = GetToken(BURST_TARGS, i, ";");
		if ((IsValidPlayer(CUR_TARG)))
		{
			if (!(IsOnGround(CUR_TARG)))
			{
			}
			string EXIT_SUB = "";
		}
		if ((EXIT_SUB)) return;
		ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_FIRE_SPELL);
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string MY_ORG = GetEntityOrigin(GetOwner());
		string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		string NEW_YAW = TARG_ANG;
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 1000, 0)));
	}

	void do_fire_storm()
	{
		DOING_FIRE_STORM = 1;
		npcatk_suspend_ai();
		npcatk_suspend_movement(ANIM_BEAM);
		PlayAnim("critical", ANIM_WARCRY);
		NEXT_SPECIAL = GetGameTime();
		NEXT_SPECIAL += FREQ_SPECIAL;
		ClientEvent("update", "all", CL_IDX, "fire_storm_on");
		BREATH_ANG = GetEntityProperty(GetOwner(), "angles.yaw");
		BREATH_ANG -= 45;
		if (BREATH_ANG < 0)
		{
			BREATH_ANG += 359;
		}
		BREATH_COUNT = 0;
		ScheduleDelayedEvent(0.01, "fire_breath_loop");
		FIRE_BREATH_ON = 1;
		// svplaysound: svplaysound 1 10 SOUND_BREATH
		EmitSound(1, 10, SOUND_BREATH);
	}

	void fire_breath_loop()
	{
		if (!(DOING_FIRE_STORM)) return;
		BREATH_COUNT += 1;
		if (BREATH_COUNT == 45)
		{
			end_fire_breath();
		}
		if (!(BREATH_COUNT < 45)) return;
		ScheduleDelayedEvent(0.05, "fire_breath_loop");
		BREATH_ANG += 1;
		if (BREATH_ANG > 359)
		{
			BREATH_ANG -= 359;
		}
		string FACE_POS = GetEntityOrigin(GetOwner());
		FACE_POS += /* TODO: $relpos */ $relpos(Vector3(0, BREATH_ANG, 0), Vector3(0, 500, 0));
		SetMoveDest(FACE_POS);
		if (!(GetGameTime() > NEXT_SCAN)) return;
		NEXT_SCAN = GetGameTime();
		NEXT_SCAN += 0.25;
		string SCAN_POINT = /* TODO: $relpos */ $relpos(0, 128, 0);
		CLOUD_TARGS = /* TODO: $get_tbox */ $get_tbox("enemy", 128, SCAN_POINT);
		if (CLOUD_TARGS != "none")
		{
			for (int i = 0; i < GetTokenCount(CLOUD_TARGS, ";"); i++)
			{
				burn_targets();
			}
		}
	}

	void burn_targets()
	{
		string CUR_TARGET = GetToken(CLOUD_TARGS, i, ";");
		string TARG_ORG = GetEntityOrigin(CUR_TARGET);
		if (!(WithinCone2D(TARG_ORG, GetMonsterProperty("origin"), GetMonsterProperty("angles")))) return;
		if (!(GetEntityRange(CUR_TARGET) < 256)) return;
		ApplyEffect(CUR_TARGET, "effects/dot_fire", 10.0, GetEntityIndex(GetOwner()), DOT_FIRE_SPELL);
		AddVelocity(CUR_TARGET, /* TODO: $relvel */ $relvel(0, 800, 120));
	}

	void end_fire_breath()
	{
		NEXT_SPECIAL = GetGameTime();
		NEXT_SPECIAL += FREQ_SPECIAL;
		ClientEvent("update", "all", CL_IDX, "fire_storm_off");
		npcatk_resume_ai();
		npcatk_resume_movement();
		// svplaysound: svplaysound 1 0 SOUND_BREATH
		EmitSound(1, 0, SOUND_BREATH);
		DOING_FIRE_STORM = 0;
	}

	void final_postspawn()
	{
		LEAP_AWAY_INTERVAL = GetEntityHealth(GetOwner());
		LEAP_AWAY_INTERVAL *= 0.25;
		if (!(NPC_ADJ_LEVEL >= 2)) return;
		SetName("Fire Djinn");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (CL_IDX != "CL_IDX")
		{
			ClientEvent("update", "all", CL_IDX, "end_fx");
		}
	}

	void cycle_up()
	{
		if ((CL_REFRESH_LOOP_ON)) return;
		CL_REFRESH_LOOP_ON = 1;
		refresh_cl_loop();
	}

	void refresh_cl_loop()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		ScheduleDelayedEvent(10.0, "refresh_cl_loop");
		if (CL_IDX != "CL_IDX")
		{
			ClientEvent("update", "all", CL_IDX, "end_fx");
		}
		ClientEvent("new", "all", "monsters/djinn_ogre_fire_cl", GetEntityIndex(GetOwner()), 10.0, DOING_FIRE_STORM);
		CL_IDX = "game.script.last_sent_id";
	}

}

}
