#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_lightning_shield.as"

namespace MS
{

class DjinnLightningLesserAlt : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HIDX;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string BEAM1_ID;
	string BEAM2_ID;
	int BEAM_ACTIVE;
	string BEAM_TARGET;
	string BEAM_TYPE;
	int CAN_FLINCH;
	string CL_SCRIPT_IDX;
	int DID_WARCRY;
	int DMG_FROM_BEAM;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	float FLINCH_CHANCE;
	float FLINCH_DELAY;
	int FLINCH_HEALTH;
	string FWD_JUMP_STR;
	int HEADBUTT_ATTACK;
	int IS_UNHOLY;
	string MAX_SUSPEND_AI;
	int MOVE_RANGE;
	string NEXT_BLAST;
	string NEXT_HEADBUTT;
	string NEXT_JUMP;
	string NEXT_RNDJUMP;
	string NEXT_SHIELD;
	int NPC_DIRECT_ATTACK;
	int NPC_GIVE_EXP;
	int NPC_MUST_SEE_TARGET;
	int SWIPE_ATTACK;
	string UP_JUMP_STR;
	string WEAK_THRESHOLD;

	DjinnLightningLesserAlt()
	{
		ANIM_IDLE = "idle1";
		ANIM_WALK = "walk";
		ANIM_RUN = "run1";
		ANIM_DEATH = "dieforward";
		ANIM_FLINCH = "bigflinch";
		ANIM_ATTACK = "attack1";
		const string ANIM_SWIPE = "attack1";
		const string ANIM_HEADBUTT = "attack2";
		const string ANIM_JUMP = "jump";
		const string ANIM_LEAP = "jump";
		const string ANIM_SEARCH = "idle_look";
		const string ANIM_WALK_DEFAULT = "walk";
		const string ANIM_RUN_DEFAULT = "run1";
		const string ANIM_IDLE_DEFAULT = "idle1";
		const string ANIM_WARCRY = "warcry";
		const string ANIM_JUMPING_JACKS = "idle2";
		const string ANIM_BEAM = "beam";
		NPC_GIVE_EXP = 2000;
		IS_UNHOLY = 1;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = 500;
		ATTACK_MOVERANGE = 88;
		MOVE_RANGE = 88;
		ATTACK_RANGE = 140;
		ATTACK_HITRANGE = 160;
		const int RANGE_SWIPE = 140;
		const int RANGE_HEADBUTT = 100;
		CAN_FLINCH = 1;
		FLINCH_CHANCE = 0.1;
		FLINCH_DELAY = 10.0;
		FLINCH_HEALTH = 2000;
		const float FREQ_JUMP = 5.0;
		const int MAX_JUMP_RANGE = 600;
		const string FREQ_RNDJUMP = Random(10.0, 20.0);
		const float FREQ_HEADBUTT = 7.0;
		const int CHANCE_SHOCK = 30;
		const float DOT_SHOCK = 40.0;
		const int DMG_SWIPE = 100;
		const int DMG_HEADBUTT = 50;
		const float ATTACK_HITCHANCE = 0.95;
		const string CL_SCRIPT = "monsters/djinn_lightning_lesser_cl";
		const float FREQ_FX_REFRESH = 15.0;
		const float FREQ_SHIELD = 45.0;
		const string FREQ_BLAST = Random(10.0, 20.0);
		const int DMG_BEAM = 100;
		const int DMG_BEAM_SECONDARY = 100;
		const string SOUND_BCHARGE = "magic/bolt_start.wav";
		const string SOUND_LOOP = "magic/bolt_loop.wav";
		const string SOUND_BFIRE = "magic/bolt_end.wav";
		const string SOUND_SHOCK1 = "debris/zap8.wav";
		const string SOUND_SHOCK2 = "debris/zap3.wav";
		const string SOUND_SHOCK3 = "debris/zap4.wav";
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
		const int LSHIELD_PASSIVE = 0;
		const int LSHIELD_RADIUS = 256;
		const int LSHIELD_REPELL_STRENGTH = 500;
		const string SOUND_ZAP_LOOP = "magic/bolt_loop.wav";
		const string SOUND_ZAP_START = "magic/bolt_end.wav";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(3.0, 10.0));
		if ((IsEntityAlive(GetOwner())))
		{
		}
		if (m_hAttackTarget == "unset")
		{
		}
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4, SOUND_IDLE5
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4, SOUND_IDLE5};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(FREQ_FX_REFRESH);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		if (CL_SCRIPT_IDX != "CL_SCRIPT_IDX")
		{
			ClientEvent("update", "all", CL_SCRIPT_IDX, "remove_fx");
		}
		ClientEvent("new", "all", CL_SCRIPT, GetEntityIndex(GetOwner()), FREQ_FX_REFRESH);
		CL_SCRIPT_IDX = "game.script.last_sent_id";
	}

	void OnRepeatTimer_2()
	{
		SetRepeatDelay(10.0);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		if ((SUSPEND_AI))
		{
		}
		if (GetGameTime() > MAX_SUSPEND_AI)
		{
		}
		npcatk_resume_ai();
	}

	void game_precache()
	{
		Precache(CL_SCRIPT);
	}

	void OnSpawn() override
	{
		SetName("Lesser Lightning Djinn");
		SetHealth(5000);
		SetRace("demon");
		SetRoam(true);
		SetGold(0);
		SetModel("monsters/swamp_ogre.mdl");
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		SetHeight(64);
		SetWidth(32);
		SetHearingSensitivity(8);
		SetBloodType("green");
		SetProp(GetOwner(), "skin", 4);
		string DEF_ATTACK_RANGE = GetMonsterProperty("moveprox");
		DEF_ATTACK_RANGE *= 1.5;
		LogDebug("npc_spawn DEF_ATTACK_RANGE");
		SetDamageResistance("all", 0.7);
		SetDamageResistance("lightning", 0.0);
		SetDamageResistance("holy", 0.5);
		SetDamageResistance("acid", 2.0);
		SetDamageResistance("poison", 1.25);
		ATTACK_HIDX = 0;
		WEAK_THRESHOLD = GetEntityMaxHealth(GetOwner());
		WEAK_THRESHOLD *= 0.3;
		ScheduleDelayedEvent(0.1, "setup_client");
		ScheduleDelayedEvent(0.2, "init_beam1");
		ScheduleDelayedEvent(0.3, "init_beam2");
	}

	void setup_client()
	{
		ClientEvent("new", "all", CL_SCRIPT, GetEntityIndex(GetOwner()), FREQ_FX_REFRESH);
		CL_SCRIPT_IDX = "game.script.last_sent_id";
	}

	void init_beam1()
	{
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 1, GetOwner(), 0, Vector3(200, 255, 50), 0, 10, -1);
		BEAM1_ID = GetEntityIndex(m_hLastCreated);
	}

	void init_beam2()
	{
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 2, GetOwner(), 0, Vector3(200, 255, 50), 0, 10, -1);
		BEAM2_ID = GetEntityIndex(m_hLastCreated);
	}

	void npc_targetsighted()
	{
		if (!(IsValidPlayer(param1))) return;
		if ((DID_WARCRY)) return;
		string GAME_TIME = GetGameTime();
		NEXT_JUMP = GAME_TIME;
		NEXT_JUMP += FREQ_JUMP;
		NEXT_BLAST = GAME_TIME;
		NEXT_BLAST += FREQ_BLAST;
		NEXT_SHIELD = GAME_TIME;
		NEXT_SHIELD += FREQ_SHIELD;
		PlayAnim("critical", ANIM_WARCRY);
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
		DID_WARCRY = 1;
	}

	void cycle_down()
	{
		DID_WARCRY = 0;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		beams_remove();
	}

	void beams_remove()
	{
		Effect("beam", "update", BEAM1_ID, "brightness", 0);
		Effect("beam", "update", BEAM2_ID, "brightness", 0);
		Effect("beam", "update", BEAM1_ID, "remove", 0.1);
		Effect("beam", "update", BEAM2_ID, "remove", 0.1);
	}

	void do_hop()
	{
		PlayAnim("critical", ANIM_LEAP);
		EmitSound(GetOwner(), 0, SOUND_LEAP, 10);
		UP_JUMP_STR = param1;
		UP_JUMP_STR *= 5;
		npcatk_suspend_ai(1.0);
		FWD_JUMP_STR = GetEntityRange(m_hAttackTarget);
		LogDebug("do_hop UP_JUMP_STR FWD_JUMP_STR");
		ScheduleDelayedEvent(0.1, "do_jump_boost");
	}

	void do_jump_boost()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, FWD_JUMP_STR, UP_JUMP_STR));
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(m_hAttackTarget != "unset")) return;
		if ((SUSPEND_AI)) return;
		if ((I_R_FROZEN)) return;
		string GAME_TIME = GetGameTime();
		if (GAME_TIME > NEXT_BLAST)
		{
			if ((false))
			{
			}
			do_blast();
			NEXT_BLAST = GAME_TIME;
			NEXT_BLAST += FREQ_BLAST;
			string GAME_TIME_PLUS = GAME_TIME;
			GAME_TIME_PLUS += 5.0;
			if (GAME_TIME_PLUS > NEXT_SHIELD)
			{
			}
			NEXT_SHIELD += 10.0;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GAME_TIME > NEXT_SHIELD)
		{
			if (GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)
			{
			}
			do_shield();
			NEXT_SHIELD = GAME_TIME;
			NEXT_SHIELD += FREQ_SHIELD;
			string GAME_TIME_PLUS = GAME_TIME;
			GAME_TIME_PLUS += 10.0;
			if (GAME_TIME_PLUS > NEXT_BLAST)
			{
			}
			NEXT_BLAST += 15.0;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GAME_TIME > NEXT_JUMP)
		{
			if (GetEntityRange(m_hAttackTarget) < MAX_JUMP_RANGE)
			{
			}
			string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
			string TARG_Z = GetEntityProperty(m_hAttackTarget, "origin.z");
			if ((IsValidPlayer(m_hAttackTarget)))
			{
				TARG_Z -= 38;
			}
			string Z_DIFF = TARG_Z;
			Z_DIFF -= MY_Z;
			if (Z_DIFF > ATTACK_RANGE)
			{
				do_hop(Z_DIFF);
				int EXIT_SUB = 1;
				NEXT_JUMP = GAME_TIME;
				NEXT_JUMP += FREQ_JUMP;
				NEXT_RNDJUMP = GAME_TIME;
				NEXT_RNDJUMP += FREQ_RNDJUMP;
			}
		}
		if ((EXIT_SUB)) return;
		if (GAME_TIME > NEXT_RNDJUMP)
		{
			if (GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)
			{
			}
			NEXT_RNDJUMP = GAME_TIME;
			NEXT_RNDJUMP += FREQ_RNDJUMP;
			do_hop(RandomInt(80, 200));
		}
	}

	void run_step1()
	{
		EmitSound(GetOwner(), 0, SOUND_STEP1, 5);
	}

	void run_step2()
	{
		EmitSound(GetOwner(), 0, SOUND_STEP2, 5);
	}

	void attack1()
	{
		SWIPE_ATTACK = 1;
		if (!(NPC_DIRECT_ATTACK))
		{
			DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SWIPE, ATTACK_HITCHANCE, "slash");
		}
		else
		{
			DoDamage(m_hAttackTarget, "direct", DMG_SWIPE, ATTACK_HITCHANCE, GetOwner());
		}
		string ATTACK_START = GetEntityProperty(GetOwner(), "attachpos");
		string TARG_ORG = GetEntityOrigin(m_hAttackTarget);
		string ANG_TO_TARG = /* TODO: $angles3d */ $angles3d(ATTACK_START, TARG_ORG);
		ANG_TO_TARG = "x";
		ClientEvent("update", "all", CL_SCRIPT_IDX, "hand_sprite", ANG_TO_TARG, ATTACK_HIDX);
		ATTACK_HIDX += 1;
		if (ATTACK_HIDX > 1)
		{
			ATTACK_HIDX = 0;
		}
		if (!(GetGameTime() > NEXT_HEADBUTT)) return;
		ANIM_ATTACK = ANIM_HEADBUTT;
		ATTACK_RANGE = RANGE_HEADBUTT;
	}

	void attack2()
	{
		HEADBUTT_ATTACK = 1;
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_HEADBUTT, ATTACK_HITCHANCE, "slash");
		ANIM_ATTACK = ANIM_SWIPE;
		ATTACK_RANGE = RANGE_SWIPE;
		NEXT_HEADBUTT = GetGameTime();
		NEXT_HEADBUTT += FREQ_HEADBUTT;
	}

	void leap_done()
	{
		EmitSound(GetOwner(), 0, SOUND_LEAP_LAND, 10);
		SetMoveAnim(ANIM_RUN);
	}

	void game_dodamage()
	{
		if ((DMG_FROM_BEAM))
		{
			if (BEAM_TYPE == "push")
			{
				SetVelocity(BEAM_TARGET, /* TODO: $relvel */ $relvel(MON_ANGLES, Vector3(0, 1000, 110)));
			}
			else
			{
				SetVelocity(BEAM_TARGET, /* TODO: $relvel */ $relvel(MON_ANGLES, Vector3(0, -1000, 110)));
			}
		}
		DMG_FROM_BEAM = 0;
		if ((SWIPE_ATTACK))
		{
			if (!(param1))
			{
				// PlayRandomSound from: SOUND_SWIPEMISS1, SOUND_SWIPEMISS2
				array<string> sounds = {SOUND_SWIPEMISS1, SOUND_SWIPEMISS2};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
			if ((param1))
			{
			}
			// PlayRandomSound from: SOUND_SWIPEHIT1, SOUND_SWIPEHIT2
			array<string> sounds = {SOUND_SWIPEHIT1, SOUND_SWIPEHIT2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			if (RandomInt(1, 100) < CHANCE_SHOCK)
			{
			}
			EmitSound(GetOwner(), 2, SOUND_BFIRE, 10);
			Effect("glow", GetOwner(), Vector3(255, 255, 0), 64, 1, 1);
			if (GetEntityRange(param2) < ATTACK_HITRANGE)
			{
			}
			ApplyEffect(param2, "effects/dot_lightning", RandomInt(2, 5), GetEntityIndex(GetOwner()), DOT_SHOCK);
		}
		SWIPE_ATTACK = 0;
		if ((HEADBUTT_ATTACK))
		{
			if (!(param1))
			{
				// PlayRandomSound from: SOUND_SWIPEMISS1, SOUND_SWIPEMISS2
				array<string> sounds = {SOUND_SWIPEMISS1, SOUND_SWIPEMISS2};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
			if ((param1))
			{
			}
			EmitSound(GetOwner(), 0, SOUND_HEADBUTT, 10);
			if (GetEntityRange(param2) < RANGE_HEADBUTT)
			{
			}
			ApplyEffect(param2, "effects/debuff_stun", 5, GetEntityIndex(GetOwner()));
		}
		HEADBUTT_ATTACK = 0;
	}

	void OnFlinch()
	{
		EmitSound(GetOwner(), 0, SOUND_FLINCH, 10);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (GetEntityHealth(GetOwner()) > WEAK_THRESHOLD)
		{
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN_STRONG
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN_STRONG};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (GetEntityHealth(GetOwner()) <= WEAK_THRESHOLD)
		{
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN_WEAK
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN_WEAK};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if ((I_R_FROZEN)) return;
		if (param1 > 200)
		{
			if (RandomInt(1, 2) == 1)
			{
			}
			leap_away();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GetEntityRange(m_hLastStruck) < ATTACK_RANGE)
		{
			if (RandomInt(1, 10) == 1)
			{
			}
			leap_away();
		}
	}

	void leap_away()
	{
		PlayAnim("critical", ANIM_LEAP);
		SetMoveDest(m_hAttackTarget);
		ScheduleDelayedEvent(0.1, "leap_boost");
		npcatk_suspend_ai(2.0);
	}

	void leap_boost()
	{
		if ((I_R_FROZEN)) return;
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 600, 100));
	}

	void do_shield()
	{
		LogDebug("do_shield");
		npcatk_suspend_ai();
		suspend_movement(ANIM_JUMPING_JACKS);
		lshield_activate(10.0);
		ScheduleDelayedEvent(10.0, "end_shield");
	}

	void end_shield()
	{
		npcatk_resume_ai();
		resume_movement();
	}

	void suspend_movement()
	{
		CAN_FLINCH = 0;
		SetRoam(false);
		ANIM_RUN = param1;
		ANIM_IDLE = param1;
		SetMoveAnim(param1);
		SetIdleAnim(param1);
		PlayAnim("critical", param1);
	}

	void resume_movement()
	{
		CAN_FLINCH = 1;
		SetRoam(true);
		ANIM_RUN = ANIM_RUN_DEFAULT;
		ANIM_IDLE = ANIM_IDLE_DEFAULT;
		SetMoveAnim(ANIM_RUN_DEFAULT);
		SetIdleAnim(ANIM_IDLE_DEFAULT);
	}

	void do_blast()
	{
		LogDebug("do_blast entered");
		BEAM_TARGET = m_hAttackTarget;
		npcatk_suspend_ai();
		suspend_movement(ANIM_BEAM);
		LogDebug("do_blast setup_beams");
		Effect("beam", "update", BEAM1_ID, "end_target", BEAM_TARGET, 1);
		Effect("beam", "update", BEAM1_ID, "brightness", 200);
		Effect("beam", "update", BEAM2_ID, "end_target", BEAM_TARGET, 2);
		Effect("beam", "update", BEAM2_ID, "brightness", 200);
		LogDebug("do_blast setup_sounds");
		EmitSound(GetOwner(), 0, SOUND_ZAP_START, 10);
		// svplaysound: svplaysound 1 10 SOUND_ZAP_LOOP
		EmitSound(1, 10, SOUND_ZAP_LOOP);
		if (GetEntityRange(BEAM_TARGET) > 300)
		{
			BEAM_TYPE = "pull";
		}
		else
		{
			BEAM_TYPE = "push";
		}
		DoDamage(BEAM_TARGET, 2048, DMG_BEAM, 1.0, "lightning");
		ApplyEffect(BEAM_TARGET, "effects/dot_lightning", 5.0, GetEntityIndex(GetOwner()), DOT_SHOCK);
		BEAM_ACTIVE = 1;
		beam_loop();
		ScheduleDelayedEvent(2.0, "end_beam");
	}

	void end_beam()
	{
		BEAM_ACTIVE = 0;
		npcatk_resume_ai();
		resume_movement();
		// svplaysound: svplaysound 1 0 SOUND_ZAP_LOOP
		EmitSound(1, 0, SOUND_ZAP_LOOP);
		Effect("beam", "update", BEAM1_ID, "end_target", GetOwner(), 0);
		Effect("beam", "update", BEAM1_ID, "brightness", 0);
		Effect("beam", "update", BEAM2_ID, "end_target", GetOwner(), 1);
		Effect("beam", "update", BEAM2_ID, "brightness", 0);
	}

	void beam_loop()
	{
		if (!(BEAM_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "beam_loop");
		SetMoveDest(BEAM_TARGET);
		DMG_FROM_BEAM = 1;
		DoDamage(BEAM_TARGET, 2048, DMG_BEAM_SECONDARY, 1.0, "lightning");
		DMG_FROM_BEAM = 0;
		string MON_ANGLES = GetEntityAngles(GetOwner());
		MON_ANGLES = "x";
	}

	void set_direct_attack()
	{
		NPC_DIRECT_ATTACK = 1;
		NPC_MUST_SEE_TARGET = 0;
	}

	void OnSuspendAI()
	{
		MAX_SUSPEND_AI = GetGameTime();
		MAX_SUSPEND_AI += 20.0;
	}

}

}
