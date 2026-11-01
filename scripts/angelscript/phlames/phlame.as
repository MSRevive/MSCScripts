#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class Phlame : CGameScript
{
	int AM_TRANSFORMED;
	string ANIM_ATTACK;
	string ANIM_BEAM;
	string ANIM_BOULDERS;
	string ANIM_DODGE;
	string ANIM_FIRE_BREATH;
	string ANIM_GUIDED_BURST;
	string ANIM_IDLE;
	string ANIM_IDLE_DEF;
	string ANIM_LEAP;
	string ANIM_LOOK;
	string ANIM_METEOR;
	string ANIM_MODE;
	string ANIM_REPULSE;
	string ANIM_RUN;
	string ANIM_RUN_DEF;
	string ANIM_SEARCH;
	string ANIM_SUMMON;
	string ANIM_TRANSFORM;
	string ANIM_WALK;
	string ANIM_WALK_DEF;
	int ATTACH_EYE;
	int ATTACH_HAND;
	int ATTACH_STAFF;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string BIRD_SCRIPT;
	string BREATH_TARGS;
	string BREATH_YAW;
	int CAN_HEAR;
	string CL_EFFECT_ID;
	int CL_FX_ON;
	string CREATE_POINT;
	int DID_SUMMON;
	int DMG_EYE_BEAM;
	int DMG_REPULSE;
	int DMG_ROCKS;
	int DMG_STAFF;
	int DOT_FIRE;
	string EYE_BEAM_ID;
	int EYE_BEAM_ON;
	string EYE_BEAM_TARGET;
	int FIRE_BREATH_ON;
	string FIRST_SUMMON;
	float FREQ_CL_REFRESH;
	float FREQ_GLOAT;
	float FREQ_LOOK;
	float FREQ_PAIN;
	float FREQ_REPELL;
	float FREQ_SPECIAL;
	string HEALTH_25;
	string HEALTH_50;
	string HEALTH_75;
	int IMMUNE_VAMPIRE;
	int IS_ACTIVE;
	int IS_UNHOLY;
	string IS_WEAK;
	int IT_HATH_BEGUN;
	int MOVE_RANGE;
	string MY_ANGLES;
	string MY_ORG;
	string NEXT_EYE_TRACE;
	string NEXT_FX_REFRESH;
	string NEXT_GLOAT;
	string NEXT_GLOBAL_GLOAT;
	string NEXT_LEAP_AWAY;
	string NEXT_LOOK;
	string NEXT_PAIN;
	string NEXT_REPELL;
	string NEXT_SCAN;
	string NEXT_SPECIAL;
	int NO_SPAWN_STUCK_CHECK;
	int NO_STUCK_CHECKS;
	float NPC_BOSS_REGEN_FREQ;
	float NPC_BOSS_REGEN_RATE;
	int NPC_GIVE_EXP;
	int NPC_IS_BOSS;
	int NPC_NO_AUTO_ACTIVATE;
	int RENDER_AMT;
	string REPULSE_ATTACK;
	int REPULSE_ATTACK_MODE;
	string SOUND_BREATH_START;
	string SOUND_DEATH;
	string SOUND_EYE_BEAM_FIRE;
	string SOUND_EYE_BEAM_LOOP;
	string SOUND_EYE_BEAM_OFF;
	string SOUND_EYE_BEAM_PREP;
	string SOUND_GLOAT1;
	string SOUND_GLOAT2;
	string SOUND_GLOAT3;
	string SOUND_GLOAT4;
	string SOUND_PAIN1;
	string SOUND_PAIN_HEALTHY;
	string SOUND_PAIN_WEAK;
	string SOUND_STRONG_SWING1;
	string SOUND_STRONG_SWING2;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_SUMMON;
	string SOUND_SWING1;
	string SOUND_SWING2;
	int SPECIAL_ATTACK;
	int STAFF_STRIKE;
	int SUMMON_CYCLE;
	int SUSPEND_CL_FX;
	int TRANSFORM_COUNT;
	string TRANSFORM_VALID;

	Phlame()
	{
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk2handed";
		ANIM_RUN = "run2";
		ANIM_ATTACK = "staff_strike";
		ANIM_RUN_DEF = "run2";
		ANIM_WALK_DEF = "walk2handed";
		ANIM_IDLE_DEF = "idle";
		ANIM_TRANSFORM = "crouch_aim_dualmagicmissile";
		ANIM_SEARCH = "look_idle";
		ANIM_LOOK = "look_idle";
		ANIM_SUMMON = "summon";
		ANIM_METEOR = "cieling_strike";
		ANIM_BOULDERS = "cieling_strike";
		ANIM_REPULSE = "fdeploy_strike";
		ANIM_DODGE = "staff_aim";
		ANIM_BEAM = "staff_aim";
		ANIM_FIRE_BREATH = "aim_1";
		ANIM_GUIDED_BURST = "shoot_1";
		ANIM_LEAP = "long_jump";
		NPC_IS_BOSS = 1;
		NPC_BOSS_REGEN_RATE = 0.1;
		NPC_BOSS_REGEN_FREQ = 40.0;
		NPC_GIVE_EXP = 15000;
		MOVE_RANGE = 512;
		ATTACK_MOVERANGE = 512;
		ATTACK_RANGE = 200;
		ATTACK_HITRANGE = 250;
		FREQ_LOOK = 15.0;
		FREQ_GLOAT = Random(30.0, 60.0);
		FREQ_PAIN = Random(20.0, 30.0);
		FREQ_SPECIAL = 15.0;
		FREQ_CL_REFRESH = 30.0;
		FREQ_REPELL = 20.0;
		DMG_STAFF = 100;
		DOT_FIRE = 100;
		DMG_ROCKS = 400;
		DMG_EYE_BEAM = 200;
		DMG_REPULSE = 100;
		ATTACH_HAND = 1;
		ATTACH_STAFF = 2;
		ATTACH_EYE = 3;
		BIRD_SCRIPT = "phlames/phlame_bird";
		SOUND_GLOAT1 = "voices/phlame/vs_nx0headm_haha.wav";
		SOUND_GLOAT2 = "voices/phlame/vs_nx0headm_attk.wav";
		SOUND_GLOAT3 = "voices/phlame/vs_nx0headm_bat1.wav";
		SOUND_GLOAT4 = "voices/phlame/vs_nx0headm_bat3.wav";
		SOUND_SUMMON = "voices/phlame/vs_nx0headm_bat2.wav";
		SOUND_PAIN1 = "voices/phlame/vs_nx0headm_atk1.wav";
		SOUND_PAIN_HEALTHY = "voices/phlame/vs_nx0headm_yes.wav";
		SOUND_PAIN_WEAK = "voices/phlame/vs_nx0headm_no.wav";
		SOUND_STRUCK1 = "debris/flesh1.wav";
		SOUND_STRUCK2 = "debris/flesh2.wav";
		SOUND_SWING1 = "zombie/claw_miss1.wav";
		SOUND_SWING2 = "zombie/claw_miss2.wav";
		SOUND_STRONG_SWING1 = "zombie/claw_strike1.wav";
		SOUND_STRONG_SWING2 = "zombie/claw_strike2.wav";
		SOUND_EYE_BEAM_PREP = "weapons/egon_windup2.wav";
		SOUND_EYE_BEAM_LOOP = "weapons/egon_run3.wav";
		SOUND_EYE_BEAM_FIRE = "debris/beamstart1.wav";
		SOUND_EYE_BEAM_OFF = "debris/beamstart1.wav";
		SOUND_BREATH_START = "monsters/goblin/sps_fogfire.wav";
		SOUND_DEATH = "voices/phlame/vs_nx0headm_hit1.wav";
		Precache("c-tele1.spr");
		Precache("firemagic_8bit.spr");
		Precache("laserbeam.spr");
		Precache("red_aura_8bit.spr");
		Precache("3dmflaora.spr");
		Precache("calflame.spr");
		Precache("monsters/demonwing/demonwing_huge.wav");
	}

	void game_precache()
	{
		Precache("monsters/summon/rock_storm");
		Precache("phlames/phlame_cl");
		Precache(BIRD_SCRIPT);
	}

	void OnSpawn() override
	{
		SetName("Phlame the Ever Burning");
		SetRace("demon");
		SetHealth(17500);
		SetModel("monsters/phlame.mdl");
		SetWidth(32);
		SetHeight(90);
		SetRace("demon");
		SetHearingSensitivity(5);
		SetName("phlame_wiz");
		SetDamageResistance("all", 0.5);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 1.25);
		SetDamageResistance("lightning", 0.5);
		SetDamageResistance("poison", 0.25);
		SetDamageResistance("acid", 0.5);
		SetDamageResistance("holy", 1.25);
		IMMUNE_VAMPIRE = 1;
		IS_UNHOLY = 1;
		SetMoveAnim(ANIM_LOOK);
		SetIdleAnim(ANIM_LOOK);
		PlayAnim("once", ANIM_LOOK);
		SetMoveSpeed(0);
		SetInvincible(true);
		SetRoam(false);
		CatchSpeech("do_anime", "hentai");
		SetSayTextRange(1024);
		Effect("glow", GetOwner(), Vector3(255, 0, 0), 128, 20, 25);
		ScheduleDelayedEvent(35.0, "start_vines");
		npcatk_suspend_ai();
		CAN_HEAR = 0;
		NO_SPAWN_STUCK_CHECK = 1;
		NPC_NO_AUTO_ACTIVATE = 1;
		NO_STUCK_CHECKS = 1;
		SPECIAL_ATTACK = 0;
		TRANSFORM_COUNT = 0;
		SUMMON_CYCLE = 0;
		ScheduleDelayedEvent(3.0, "speak_begin");
		ScheduleDelayedEvent(20.0, "let_us_begin");
		ScheduleDelayedEvent(2.0, "final_props");
	}

	void do_anime()
	{
		if (!(ANIME_MODE))
		{
			ANIM_MODE = 1;
			SetModelBody(0, 1);
		}
		else
		{
			ANIM_MODE = 0;
			SetModelBody(0, 0);
		}
	}

	void OnPostSpawn() override
	{
		CL_FX_ON = 1;
		PlayAnim("once", ANIM_LOOK);
	}

	void final_props()
	{
		HEALTH_75 = GetEntityMaxHealth(GetOwner());
		HEALTH_50 = GetEntityMaxHealth(GetOwner());
		HEALTH_25 = GetEntityMaxHealth(GetOwner());
		HEALTH_75 *= 0.75;
		HEALTH_50 *= 0.5;
		HEALTH_25 *= 0.25;
	}

	void speak_begin()
	{
		SayText("Then... Let us... Begin...");
	}

	void let_us_begin()
	{
		if ((IT_HATH_BEGUN)) return;
		IT_HATH_BEGUN = 1;
		SetInvincible(false);
		ANIM_RUN = ANIM_WALK_DEF;
		ANIM_IDLE = ANIM_IDLE_DEF;
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		npcatk_resume_ai();
		NO_STUCK_CHECKS = 0;
		IS_ACTIVE = 1;
		NEXT_GLOAT = GetGameTime();
		NEXT_GLOAT += FREQ_GLOAT;
		NEXT_SPECIAL = GetGameTime();
		NEXT_SPECIAL += 5.0;
		FIRST_SUMMON = NEXT_SPECIAL;
		FIRST_SUMMON += 10.0;
		SetMoveSpeed(1);
		CAN_HEAR = 1;
	}

	void bs_global_command()
	{
		if (!(param3 == "death")) return;
		if (!(IsEntityAlive(GetOwner()))) return;
		if (!(GetGameTime() > NEXT_GLOBAL_GLOAT)) return;
		NEXT_GLOBAL_GLOAT = GetGameTime();
		NEXT_GLOBAL_GLOAT += 15.0;
		int RND_GLOAT = RandomInt(1, 4);
		if (RND_GLOAT == 1)
		{
			UseTrigger("snd_gloat1");
		}
		if (RND_GLOAT == 2)
		{
			UseTrigger("snd_gloat2");
		}
		if (RND_GLOAT == 3)
		{
			UseTrigger("snd_gloat3");
		}
		if (RND_GLOAT == 4)
		{
			UseTrigger("snd_gloat4");
		}
	}

	void do_gloat()
	{
		// PlayRandomSound from: SOUND_GLOAT1, SOUND_GLOAT2, SOUND_GLOAT3, SOUND_GLOAT4
		array<string> sounds = {SOUND_GLOAT1, SOUND_GLOAT2, SOUND_GLOAT3, SOUND_GLOAT4};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if ((EYE_BEAM_ON))
		{
			if (GetEntityRange(m_hLastStruck) < GetEntityRange(EYE_BEAM_TARGET))
			{
			}
			eye_beam_switchtargets(GetEntityIndex(m_hLastStruck));
		}
		if (GetEntityHealth(GetOwner()) < HEALTH_50)
		{
			IS_WEAK = 1;
		}
		else
		{
			IS_WEAK = 0;
		}
		if (GetGameTime() > NEXT_PAIN)
		{
			NEXT_PAIN = GetGameTime();
			NEXT_PAIN += FREQ_PAIN;
			if (!(IS_WEAK))
			{
				// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN_HEALTHY
				array<string> sounds = {SOUND_PAIN1, SOUND_PAIN_HEALTHY};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
			else
			{
				// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN_WEAK
				array<string> sounds = {SOUND_PAIN1, SOUND_PAIN_WEAK};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
		}
		else
		{
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 8);
		}
		if ((IS_WEAK))
		{
			ANIM_RUN = ANIM_RUN_DEF;
			SetMoveAnim(ANIM_RUN);
		}
		else
		{
			ANIM_RUN = ANIM_WALK_DEF;
			SetMoveAnim(ANIM_RUN);
		}
		if (!(IS_WEAK)) return;
		if ((BUSY_CASTING)) return;
		if (GetEntityRange(m_hLastStruck) < 200)
		{
			if (GetGameTime() > NEXT_LEAP_AWAY)
			{
			}
			NEXT_LEAP_AWAY = GetGameTime();
			NEXT_LEAP_AWAY += FREQ_LEAP_AWAY;
			do_leap_away();
		}
	}

	void game_dodamage()
	{
		if ((STAFF_STRIKE))
		{
			if ((param1))
			{
			}
			if (!(REPULSE_ATTACK))
			{
			}
			ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_FIRE);
		}
		if ((REPULSE_ATTACK))
		{
			if ((param1))
			{
			}
			string CUR_TARG = param2;
			string TARG_ORG = GetEntityOrigin(CUR_TARG);
			string MY_ORG = GetEntityOrigin(GetOwner());
			string NEW_YAW = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
			ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_FIRE);
			AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 3000, 600)));
		}
		STAFF_STRIKE = 0;
	}

	void frame_staff_strike()
	{
		int RND_STRENGTH = RandomInt(1, 2);
		if (RND_STRENGTH == 1)
		{
			// PlayRandomSound from: SOUND_SWING1, SOUND_SWING2
			array<string> sounds = {SOUND_SWING1, SOUND_SWING2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		else
		{
			// PlayRandomSound from: SOUND_STRONG_SWING1, SOUND_STRONG_SWING2
			array<string> sounds = {SOUND_STRONG_SWING1, SOUND_STRONG_SWING2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		string L_DMG = DMG_STAFF;
		if (RND_STRENGTH == 2)
		{
			L_DMG *= 4;
		}
		STAFF_STRIKE = 1;
		if (REPULSE_ATTACK_MODE > 0)
		{
			ClientEvent("update", "all", CL_EFFECT_ID, "repulse_attack");
			REPULSE_ATTACK = 1;
			DoDamage(/* TODO: $relpos */ $relpos(0, 0, 32), 512, DMG_REPULSE, 1.0, 0);
			REPULSE_ATTACK_MODE -= 1;
			ScheduleDelayedEvent(0.1, "repulse_reset");
		}
		else
		{
			DoDamage(m_hAttackTarget, ATTACK_HITRANGE, L_DMG, 0.9, "blunt");
		}
	}

	void repulse_reset()
	{
		REPULSE_ATTACK = 0;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		float GAME_TIME = GetGameTime();
		if ((CL_FX_ON))
		{
			if (!(SUSPEND_CL_FX))
			{
			}
			if (GAME_TIME > NEXT_FX_REFRESH)
			{
			}
			NEXT_FX_REFRESH = GAME_TIME;
			NEXT_FX_REFRESH += FREQ_CL_REFRESH;
			refresh_client_fx();
		}
		if (!(m_hAttackTarget != "unset")) return;
		if ((SUSPEND_AI)) return;
		if (REPULSE_ATTACK_MODE > 0)
		{
			PlayAnim("once", ANIM_ATTACK);
		}
		if (!(IS_ACTIVE)) return;
		if (GAME_TIME > NEXT_GLOAT)
		{
			NEXT_GLOAT = GAME_TIME;
			NEXT_GLOAT += FREQ_GLOAT;
			do_gloat();
		}
		if (GAME_TIME > NEXT_SPECIAL)
		{
			NEXT_SPECIAL = GAME_TIME;
			NEXT_SPECIAL += FREQ_SPECIAL;
			SPECIAL_ATTACK += 1;
			if (SPECIAL_ATTACK > 4)
			{
				SPECIAL_ATTACK = 0;
			}
			if (TRANSFORM_COUNT == 0)
			{
				if (GetEntityHealth(GetOwner()) < HEALTH_75)
				{
					do_transform();
					int EXIT_SUB = 1;
				}
			}
			if (!(EXIT_SUB))
			{
			}
			if (TRANSFORM_COUNT == 1)
			{
				if (GetEntityHealth(GetOwner()) < HEALTH_25)
				{
					do_transform();
					int EXIT_SUB = 1;
				}
			}
			if (!(EXIT_SUB))
			{
			}
			if (GAME_TIME > FIRST_SUMMON)
			{
				do_summon();
				if ((DID_SUMMON))
				{
				}
				DID_SUMMON = 0;
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if (SPECIAL_ATTACK == 1)
			{
				PlayAnim("critical", ANIM_REPULSE);
				SpawnNPC("monsters/summon/rock_storm", /* TODO: $relpos */ $relpos(0, 0, 32), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 4, DMG_ROCKS, 64, 120, 1
			}
			if (SPECIAL_ATTACK == 2)
			{
				do_eye_beam();
			}
			if (SPECIAL_ATTACK == 3)
			{
				if (GetEntityRange(m_hAttackTarget) < 512)
				{
					do_fire_breath();
				}
				else
				{
					SPECIAL_ATTACK += 1;
				}
			}
			if (SPECIAL_ATTACK == 4)
			{
				if (GetEntityRange(m_hAttackTarget) < 128)
				{
					do_repulse();
				}
				else
				{
					NEXT_SPECIAL = GetGameTime();
				}
				SPECIAL_ATTACK = 0;
			}
		}
		if (GAME_TIME > NEXT_REPELL)
		{
			if (REPULSE_ATTACK_MODE <= 0)
			{
			}
			if (!(SUSPEND_AI))
			{
			}
			NEXT_REPELL = GAME_TIME;
			NEXT_REPELL += FREQ_REPELL;
			string NEARBY_NMES = FindEntitiesInSphere("enemy", 256);
			if (NEARBY_NMES != "none")
			{
			}
			string N_NEARBY_NMES = GetTokenCount(NEARBY_NMES, ";");
			int DO_REPULSE_CHANCE = RandomInt(1, 3);
			LogDebug("repulse_check nmes N_NEARBY_NMES vs DO_REPULSE_CHANCE");
			if (DO_REPULSE_CHANCE < N_NEARBY_NMES)
			{
			}
			REPULSE_ATTACK_MODE += 1;
			PlayAnim("once", ANIM_ATTACK);
		}
	}

	void npcatk_lost_sight()
	{
		if (!(GetGameTime() > NEXT_LOOK)) return;
		NEXT_LOOK = GetGameTime();
		NEXT_LOOK += FREQ_LOOK;
		PlayAnim("once", ANIM_SEARCH);
	}

	void refresh_client_fx()
	{
		ClientEvent("new", "all", "phlames/phlame_cl", GetEntityIndex(GetOwner()), EYE_BEAM_ON, FIRE_BREATH_ON);
		CL_EFFECT_ID = "game.script.last_sent_id";
	}

	void do_eye_beam()
	{
		EYE_BEAM_TARGET = m_hAttackTarget;
		PlayAnim("once", "break");
		npcatk_suspend_ai();
		npcatk_suspend_movement(ANIM_BEAM);
		EmitSound(GetOwner(), 0, SOUND_EYE_BEAM_PREP, 10);
		EYE_BEAM_ON = 1;
		ClientEvent("update", "all", CL_EFFECT_ID, "eye_beam_on");
		ScheduleDelayedEvent(1.0, "do_eye_beam2");
	}

	void do_eye_beam2()
	{
		Effect("beam", "ents", "laserbeam.spr", 30, GetOwner(), ATTACH_EYE, EYE_BEAM_TARGET, 1, Vector3(255, 0, 255), 255, 10, EYE_BEAM_DURATION);
		EYE_BEAM_ID = m_hLastCreated;
		EmitSound(GetOwner(), 0, SOUND_EYE_BEAM_FIRE, 10);
		// svplaysound: svplaysound 1 10 SOUND_EYE_BEAM_LOOP
		EmitSound(1, 10, SOUND_EYE_BEAM_LOOP);
		eye_beam_loop();
		ScheduleDelayedEvent(10.0, "end_eye_beam");
		EYE_BEAM_DURATION("end_eye_beam");
	}

	void eye_beam_loop()
	{
		if (!(EYE_BEAM_ON)) return;
		ScheduleDelayedEvent(0.1, "eye_beam_loop");
		SetMoveDest(EYE_BEAM_TARGET);
		if (!(GetGameTime() > NEXT_EYE_TRACE)) return;
		NEXT_EYE_TRACE = GetGameTime();
		NEXT_EYE_TRACE += 0.5;
		if (!(IsEntityAlive(EYE_BEAM_TARGET)))
		{
			int GET_NEW_TARGET = 1;
		}
		else
		{
			string TRACE_START = GetEntityProperty(GetOwner(), "attachpos");
			string TRACE_END = GetEntityOrigin(EYE_BEAM_TARGET);
			string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		}
		if (TRACE_LINE != TRACE_END)
		{
			int GET_NEW_TARGET = 1;
		}
		else
		{
			if (!(GET_NEW_TARGET))
			{
			}
			DoDamage(EYE_BEAM_TARGET, "direct", DMG_EYE_BEAM, 1.0, GetOwner());
			AddVelocity(EYE_BEAM_TARGET, /* TODO: $relvel */ $relvel(0, 250, 110));
			ClientEvent("update", "all", CL_EFFECT_ID, "eye_beam_contact", GetEntityOrigin(EYE_BEAM_TARGET));
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string CAN_SEE_NME = false;
		if ((CAN_SEE_NME))
		{
			// TODO: UNCONVERTED: if ( CAN_SEE_NME) )
		}
		LogDebug("eye_beam_loop see_nme CAN_SEE_NME GetEntityName(m_hLastSeen)");
		if (GetEntityRange(m_hLastSeen) < GetEntityRange(EYE_BEAM_TARGET))
		{
			int GET_NEW_TARGET = 1;
		}
		if (!(GET_NEW_TARGET)) return;
		eye_beam_switchtargets(GetEntityIndex(m_hLastSeen));
		int GOT_NEW_TARGET = 1;
		if ((GOT_NEW_TARGET)) return;
		end_eye_beam();
	}

	void eye_beam_switchtargets()
	{
		EYE_BEAM_TARGET = param1;
		Effect("beam", "update", EYE_BEAM_ID, "end_target", EYE_BEAM_TARGET);
	}

	void end_eye_beam()
	{
		if (!(EYE_BEAM_ON)) return;
		EYE_BEAM_ON = 0;
		npcatk_resume_movement();
		npcatk_resume_ai();
		Effect("beam", "update", EYE_BEAM_ID, "brightness", 0);
		ClientEvent("update", "all", CL_EFFECT_ID, "eye_beam_off");
		// svplaysound: svplaysound 1 0 SOUND_EYE_BEAM_LOOP
		EmitSound(1, 0, SOUND_EYE_BEAM_LOOP);
		EmitSound(GetOwner(), 0, SOUND_EYE_BEAM_OFF, 10);
		ScheduleDelayedEvent(0.1, "end_eye_beam2");
	}

	void end_eye_beam2()
	{
		ClientEvent("update", "all", CL_EFFECT_ID, "eye_beam_off");
	}

	void do_summon()
	{
		LogDebug("do_summon G_NPC_SUMMON_COUNT MAX_SUMMON_COUNT");
		int MAX_SUMMON_COUNT = 2;
		if (GetPlayerCount() > 5)
		{
			int MAX_SUMMON_COUNT = 4;
		}
		if (G_NPC_SUMMON_COUNT <= MAX_SUMMON_COUNT)
		{
			int CLEARED_FOR_SUMMON = 1;
		}
		if (!(CLEARED_FOR_SUMMON)) return;
		DID_SUMMON = 1;
		SUMMON_CYCLE += 1;
		if (SUMMON_CYCLE == 3)
		{
			string SCORP_POS = NPC_HOME_LOC;
			SCORP_POS = "z";
			string MY_POS = GetEntityOrigin(GetOwner());
			if (Distance(MY_POS, SCORP_POS) > 128)
			{
				PlayAnim("critical", ANIM_SUMMON);
				EmitSound(GetOwner(), 0, SOUND_SUMMON, 10);
				UseTrigger("spawn_fboss_scorps");
			}
			else
			{
				SUMMON_CYCLE = RandomInt(1, 2);
			}
		}
		if (SUMMON_CYCLE == 1)
		{
			SetMoveDest(NPC_HOME_LOC);
			npcatk_suspend_ai();
			npcatk_suspend_movement(ANIM_METEOR, 1.0);
			PlayAnim("hold", ANIM_METEOR);
			ScheduleDelayedEvent(1.5, "break_summon_anim");
			EmitSound(GetOwner(), 0, SOUND_SUMMON, 10);
			UseTrigger("spawn_fboss_birds");
		}
		if (SUMMON_CYCLE == 2)
		{
			PlayAnim("critical", ANIM_SUMMON);
			EmitSound(GetOwner(), 0, SOUND_SUMMON, 10);
			UseTrigger("spawn_fboss_boars");
		}
		if (!(SUMMON_CYCLE > 3)) return;
		SUMMON_CYCLE = 0;
	}

	void break_summon_anim()
	{
		npcatk_resume_ai();
		PlayAnim("once", "break");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClientEvent("update", "all", CL_EFFECT_ID, "end_fx");
		if ((EYE_BEAM_ON))
		{
			Effect("beam", "update", EYE_BEAM_ID, "brightness", 0);
			// svplaysound: svplaysound 1 0 SOUND_EYE_BEAM_LOOP
			EmitSound(1, 0, SOUND_EYE_BEAM_LOOP);
		}
		UseTrigger("snd_fboss_death");
		CallExternal("all", "ext_summon_fade");
	}

	void do_fire_breath()
	{
		npcatk_suspend_ai();
		npcatk_suspend_movement(ANIM_FIRE_BREATH);
		ClientEvent("update", "all", CL_EFFECT_ID, "fire_breath_on");
		EmitSound(GetOwner(), 1, SOUND_BREATH_START, 10);
		PlayAnim("once", "break");
		PlayAnim("hold", ANIM_FIRE_BREATH);
		SetMoveDest(m_hAttackTarget);
		BREATH_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		FIRE_BREATH_ON = 1;
		ScheduleDelayedEvent(10.0, "end_fire_breath");
		fire_breath_loop();
	}

	void fire_breath_loop()
	{
		if (!(FIRE_BREATH_ON)) return;
		ScheduleDelayedEvent(0.1, "fire_breath_loop");
		BREATH_YAW += 1;
		if (BREATH_YAW > 359.99)
		{
			BREATH_YAW -= 359.99;
		}
		string FACE_POS = GetEntityOrigin(GetOwner());
		FACE_POS += /* TODO: $relpos */ $relpos(Vector3(0, BREATH_YAW, 0), Vector3(0, 1000, 0));
		SetMoveDest(FACE_POS);
		if (!(GetGameTime() > NEXT_SCAN)) return;
		NEXT_SCAN = GetGameTime();
		NEXT_SCAN += 1.0;
		BREATH_TARGS = FindEntitiesInSphere("enemy", 256);
		if (!(BREATH_TARGS != "none")) return;
		MY_ORG = GetEntityOrigin(GetOwner());
		MY_ANGLES = GetEntityAngles(GetOwner());
		for (int i = 0; i < GetTokenCount(BREATH_TARGS, ";"); i++)
		{
			breath_affect_targets();
		}
	}

	void breath_affect_targets()
	{
		string CUR_TARG = GetToken(BREATH_TARGS, i, ";");
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		if (!(WithinCone2D(TARG_ORG, GetMonsterProperty("origin"), GetMonsterProperty("angles")))) return;
		ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_FIRE);
		AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(0, 2000, 110));
	}

	void end_fire_breath()
	{
		FIRE_BREATH_ON = 0;
		npcatk_resume_movement();
		npcatk_resume_ai();
		ClientEvent("update", "all", CL_EFFECT_ID, "fire_breath_off");
		PlayAnim("critical", ANIM_ATTACK);
	}

	void do_repulse()
	{
		PlayAnim("critical", ANIM_ATTACK);
		REPULSE_ATTACK_MODE = 3;
	}

	void transform_check()
	{
		string CENTER_POINT = NPC_HOME_LOC;
		CENTER_POINT = "z";
		string MY_POS = GetEntityOrigin(GetOwner());
		if (Distance(MY_POS, CENTER_POINT) <= 200)
		{
			TRANSFORM_VALID = 1;
		}
		else
		{
			LogDebug("transform_check no_room");
			npcatk_suspend_ai(2.0);
			SetMoveAnim(ANIM_RUN_DEF);
			string MOVE_DEST = NPC_HOME_LOC;
			MOVE_DEST = "z";
			SetMoveDest(NPC_HOME_LOC);
			PlayAnim("critical", ANIM_LEAP);
			ScheduleDelayedEvent(0.1, "leap_forward_boost");
			NEXT_SPECIAL = GetGameTime();
			NEXT_SPECIAL += 2.0;
		}
	}

	void leap_forward_boost()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 300, 110));
	}

	void do_transform()
	{
		TRANSFORM_VALID = 0;
		transform_check();
		if (!(TRANSFORM_VALID)) return;
		TRANSFORM_COUNT += 1;
		AM_TRANSFORMED = 1;
		npcatk_suspend_ai();
		SetInvincible(true);
		npcatk_suspend_movement(ANIM_TRANSFORM);
		ClientEvent("update", "all", CL_EFFECT_ID, "do_transform", GetEntityOrigin(GetOwner()));
		SetProp(GetOwner(), "rendermode", 2);
		RENDER_AMT = 255;
		do_fade_out();
		// svplaysound: svplaysound 1 10 ambience/alienfazzle1.wav
		EmitSound(1, 10, "ambience/alienfazzle1.wav");
		EmitSound(GetOwner(), 2, "ambience/blackhole.wav", 10);
		CREATE_POINT = GetEntityOrigin(GetOwner());
		CREATE_POINT += "z";
		SetGravity(0);
		ClearFX();
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 100));
		SetNoPush(true);
		ScheduleDelayedEvent(2.0, "transform_finalize");
		CallExternal("all", "ext_summon_fade");
	}

	void do_fade_out()
	{
		RENDER_AMT -= 5;
		if (!(RENDER_AMT > 0)) return;
		ScheduleDelayedEvent(0.1, "do_fade_out");
		SetProp(GetOwner(), "renderamt", RENDER_AMT);
	}

	void transform_finalize()
	{
		UseTrigger("snd_phlame_bird_spawn");
		// svplaysound: svplaysound 1 0 ambience/alienfazzle1.wav
		EmitSound(1, 0, "ambience/alienfazzle1.wav");
		ClientEvent("update", "all", CL_EFFECT_ID, "transform_finalize", CREATE_POINT);
		ScheduleDelayedEvent(0.5, "remove_cl_fx");
		SUSPEND_CL_FX = 1;
		SetEntityOrigin(GetOwner(), Vector3(20000, -20000, -20000));
		SpawnNPC(BIRD_SCRIPT, CREATE_POINT, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), "phlame"
	}

	void remove_cl_fx()
	{
		ClientEvent("update", "all", CL_EFFECT_ID, "end_fx");
	}

	void transform_return()
	{
		AM_TRANSFORMED = 0;
		SetNoPush(false);
		SetInvincible(false);
		SetGravity(1);
		string RETURN_POINT = NPC_HOME_LOC;
		string ORG_RETURN_POINT = param1;
		RETURN_POINT = "z";
		RETURN_POINT += "z";
		SetEntityOrigin(GetOwner(), RETURN_POINT);
		SUSPEND_CL_FX = 0;
		NEXT_FX_REFRESH = GAME_TIME;
		NEXT_FX_REFRESH += FREQ_CL_REFRESH;
		refresh_client_fx();
		ClientEvent("update", "all", CL_EFFECT_ID, "transform_return", ORG_RETURN_POINT, RETURN_POINT);
		set_fade_in();
		ScheduleDelayedEvent(1.0, "npcatk_resume_ai");
		npcatk_resume_movement();
		ANIM_WALK = ANIM_WALK_DEF;
		ANIM_IDLE = ANIM_IDLE_DEF;
		ANIM_RUN = ANIM_WALK_DEF;
		SetMoveAnim(ANIM_WALK_DEF);
		SetIdleAnim(ANIM_IDLE_DEF);
		PlayAnim("critical", ANIM_TRANSFORM);
		Effect("glow", GetOwner(), Vector3(255, 0, 0), 128, 1, 1);
		NEXT_SPECIAL = GetGameTime();
		NEXT_SPECIAL += 3.0;
		FIRST_SUMMON = NEXT_SPECIAL;
		FIRST_SUMMON += 10.0;
	}

	void start_vines()
	{
		UseTrigger("spawn_fboss_vines");
	}

}

}
