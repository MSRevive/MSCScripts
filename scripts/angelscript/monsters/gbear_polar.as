#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class GbearPolar : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_ATTACK1;
	string ANIM_ATTACK2;
	string ANIM_ATTACK3;
	string ANIM_BREATH_LOOP;
	string ANIM_BREATH_START;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_IDLE_NORM;
	string ANIM_LOOK1;
	string ANIM_LOOK2;
	string ANIM_LUNGE1;
	string ANIM_LUNGE2;
	string ANIM_LUNGE3;
	string ANIM_PUSHL;
	string ANIM_PUSHR;
	string ANIM_RUN;
	string ANIM_RUN_NORM;
	string ANIM_SWIM;
	string ANIM_WALK;
	string ANIM_WALK_NORM;
	string ANIM_WARCRY1;
	string ANIM_WARCRY2;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_HITRANGE_NORM;
	int ATTACK_HITRANGE_SWIM;
	int ATTACK_RANGE;
	int ATTACK_RANGE_LUNGE_MAX;
	int ATTACK_RANGE_LUNGE_MIN;
	int ATTACK_RANGE_NORM;
	float BREATH_DURATION;
	int BREATH_ON;
	string BREATH_TARGS;
	string BURST_START;
	string BURST_TARGS;
	string CLIENT_FX_ID;
	int DID_WARCRY;
	int DMG_BURST;
	float DMG_CLAW;
	float FREQ_BREATH;
	float FREQ_FLINCH;
	float FREQ_FX_REFRESH;
	float FREQ_LUNGE;
	float FREQ_STOMP;
	float FREQ_SWIM_SOUND;
	string MONSTER_MODEL;
	int MOVE_RANGE;
	float MSC_PUSH_RESIST;
	string NEXT_BREATH;
	string NEXT_BREATH_OFF_CHECK;
	string NEXT_FLINCH;
	string NEXT_LUNGE;
	string NEXT_STOMP;
	int NPC_GIVE_EXP;
	string NPC_HALF_HEALTH;
	int RUN_STEP;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_DEATH;
	string SOUND_DIVE;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_PAIN3;
	string SOUND_PAIN4;
	string SOUND_RUNSTEP1;
	string SOUND_RUNSTEP2;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SOUND_SWIM1;
	string SOUND_SWIM2;
	string SOUND_SWIM3;
	string SOUND_SWIM4;
	string SOUND_WARCRY;
	string SWIMMING_MODE;

	GbearPolar()
	{
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack1";
		ANIM_DEATH = "longdeath";
		ANIM_RUN_NORM = "run";
		ANIM_WALK_NORM = "walk";
		ANIM_IDLE_NORM = "idle";
		ANIM_ATTACK1 = "attack1";
		ANIM_ATTACK2 = "attack2";
		ANIM_ATTACK3 = "attack3";
		ANIM_LUNGE1 = "long_attack1";
		ANIM_LUNGE2 = "long_attack2";
		ANIM_LUNGE3 = "long_attack_throw";
		ANIM_BREATH_START = "breath_start";
		ANIM_BREATH_LOOP = "breath_loop";
		ANIM_WARCRY1 = "warcry";
		ANIM_WARCRY2 = "alert";
		ANIM_LOOK1 = "sniff_left";
		ANIM_LOOK2 = "sniff_right";
		ANIM_PUSHL = "attack_pushl";
		ANIM_PUSHR = "attack_pushr";
		ANIM_SWIM = "swim";
		ANIM_FLINCH = "flinch";
		SOUND_ATTACK1 = "monsters/bear/c_bear_atk1.wav";
		SOUND_ATTACK2 = "monsters/bear/c_bear_atk2.wav";
		SOUND_ATTACK3 = "monsters/bear/c_bear_atk3.wav";
		SOUND_PAIN1 = "monsters/bear/c_bear_hit1.wav";
		SOUND_PAIN2 = "monsters/bear/c_bear_hit2.wav";
		SOUND_PAIN3 = "monsters/bear/c_bear_bat1.wav";
		SOUND_PAIN4 = "monsters/bear/c_bear_bat2.wav";
		SOUND_DEATH = "monsters/bear/c_bear_dead.wav";
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		SOUND_WARCRY = "monsters/bear/c_beardire_bat1.wav";
		SOUND_RUNSTEP1 = "monsters/bear/giantbearstep1.wav";
		SOUND_RUNSTEP2 = "monsters/bear/giantbearstep2.wav";
		SOUND_SWIM1 = "player/pl_wade1.wav";
		SOUND_SWIM2 = "player/pl_wade2.wav";
		SOUND_SWIM3 = "player/pl_wade3.wav";
		SOUND_SWIM4 = "player/pl_wade4.wav";
		SOUND_DIVE = "body/splash1.wav";
		MSC_PUSH_RESIST = 0.5;
		NPC_GIVE_EXP = 500;
		MOVE_RANGE = 150;
		ATTACK_RANGE = 150;
		ATTACK_HITRANGE = 200;
		ATTACK_RANGE_NORM = 125;
		ATTACK_HITRANGE_NORM = 150;
		ATTACK_HITRANGE_SWIM = 300;
		ATTACK_RANGE_LUNGE_MIN = 175;
		ATTACK_RANGE_LUNGE_MAX = 250;
		DMG_CLAW = Random(60, 100);
		DMG_BURST = 200;
		BREATH_DURATION = 4.0;
		FREQ_LUNGE = 2.0;
		FREQ_FLINCH = 20.0;
		FREQ_STOMP = Random(30.0, 45.0);
		FREQ_FX_REFRESH = 45.0;
		FREQ_BREATH = Random(30.0, 45.0);
		FREQ_SWIM_SOUND = 5.0;
		MONSTER_MODEL = "monsters/bear_polar.mdl";
	}

	void OnSpawn() override
	{
		SetName("Greater Polar Bear");
		SetModel(MONSTER_MODEL);
		SetWidth(96);
		SetHeight(96);
		SetRoam(true);
		SetHearingSensitivity(6);
		SetRace("wildanimal");
		SetHealth(3000);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("fire", 1.25);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		RUN_STEP = 0;
		ScheduleDelayedEvent(2.0, "get_finals");
	}

	void get_finals()
	{
		NPC_HALF_HEALTH = GetEntityMaxHealth(GetOwner());
		NPC_HALF_HEALTH *= 0.5;
		if ((NO_FROSTY_BREATH)) return;
		if ((NO_BREATH_ATTACK)) return;
		refresh_cl_fx();
	}

	void npc_targetsighted()
	{
		if ((DID_WARCRY)) return;
		DID_WARCRY = 1;
		int RND_WARCRY = RandomInt(1, 2);
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 5.0;
		SetRoam(false);
		if (RND_WARCRY == 1)
		{
			PlayAnim("critical", ANIM_WARCRY1);
		}
		if (RND_WARCRY == 2)
		{
			PlayAnim("critical", ANIM_WARCRY2);
		}
		NEXT_BREATH = GetGameTime();
		NEXT_BREATH += FREQ_BREATH;
	}

	void cycle_down()
	{
		DID_WARCRY = 0;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (GetGameTime() > NEXT_BREATH_OFF_CHECK)
		{
			if (!(NO_BREATH_ATTACK))
			{
			}
			NEXT_BREATH_OFF_CHECK = GetGameTime();
			NEXT_BREATH_OFF_CHECK += 10.0;
			if (!(BREATH_ON))
			{
			}
			ClientEvent("update", "all", CLIENT_FX_ID, "breath_off");
		}
		if ((IsInWater(GetOwner())))
		{
			if (!(SWIMMING_MODE))
			{
			}
			EmitSound(GetOwner(), 2, SOUND_DIVE, 10);
			SetGravity(0.75);
			if (GetEntityRange(m_hAttackTarget) < 200)
			{
				SetGravity(0);
			}
			SWIMMING_MODE = 1;
			ANIM_RUN = "swim";
			ANIM_WALK = "swim";
			ANIM_IDLE = "swim";
			SetMoveAnim("swim");
			SetIdleAnim("swim");
			ATTACK_HITRANGE = ATTACK_HITRANGE_SWIM;
		}
		else
		{
			if ((SWIMMING_MODE))
			{
			}
			SetGravity(1);
			SWIMMING_MODE = 0;
			ANIM_RUN = ANIM_RUN_NORM;
			ANIM_WALK = ANIM_WALK_NORM;
			ANIM_IDLE = ANIM_IDLE_NORM;
			SetMoveAnim(ANIM_RUN_NORM);
			SetIdleAnim(ANIM_IDLE_NORM);
			ATTACK_HITRANGE = ATTACK_HITRANGE_NORM;
			float TIME_PLUS5 = GetGameTime();
			TIME_PLUS5 += 5.0;
			if (TIME_PLUS5 > NEXT_STOMP)
			{
				NEXT_STOMP = TIME_PLUS5;
				NEXT_STOMP += Random(10.0, 15.0);
			}
			if (TIME_PLUS5 > NEXT_BREATH)
			{
				NEXT_BREATH = TIME_PLUS5;
				NEXT_STOMP += Random(15.0, 20.0);
			}
		}
		if (!(m_hAttackTarget != "unset")) return;
		if ((SWIMMING_MODE))
		{
			if (GetEntityProperty(m_hAttackTarget, "range2d") < 200)
			{
				SetGravity(0);
			}
			else
			{
				int FWD_BOOST = 100;
				SetGravity(0.75);
			}
			if (GetGameTime() > NEXT_SWIM_SOUND)
			{
				NEXT_SWIM_SOUND = GetGameTime();
				NEXT_SWIM_SOUND += FREQ_SWIM_SOUND;
				// PlayRandomSound from: SOUND_SWIM1, SOUND_SWIM2, SOUND_SWIM3, SOUND_SWIM4
				array<string> sounds = {SOUND_SWIM1, SOUND_SWIM2, SOUND_SWIM3, SOUND_SWIM4};
				EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
			ATTACK_HITRANGE = ATTACK_HITRANGE_SWIM;
			string MOVE_DEST_Z = (GetMonsterProperty("movedest.origin")).z;
			string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
			if (MOVE_DEST_Z > MY_Z)
			{
				if ((IsInWater(GetOwner())))
				{
				}
				string Z_DIFF = MOVE_DEST_Z;
				Z_DIFF -= MY_Z;
				if (Z_DIFF > 50)
				{
				}
				AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, FWD_BOOST, 5));
			}
			if (MOVE_DEST_Z < MY_Z)
			{
				string Z_DIFF = MY_Z;
				Z_DIFF -= MOVE_DEST_Z;
				if (Z_DIFF > 50)
				{
				}
				AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, FWD_BOOST, -50));
			}
			SetAngles("face");
		}
		if ((SWIMMING_MODE)) return;
		string TARG_RANGE = GetEntityRange(m_hAttackTarget);
		if (TARG_RANGE < ATTACK_RANGE_LUNGE_MAX)
		{
			if (TARG_RANGE > ATTACK_RANGE_LUNGE_MIN)
			{
			}
			if (GetGameTime() > NEXT_LUNGE)
			{
			}
			int RND_LUNGE = RandomInt(1, 3);
			ATTACK_RANGE = ATTACK_RANGE_LUNGE_MAX;
			ATTACK_HITRANGE = ATTACK_RANGE_LUNGE_MAX;
			if (RND_LUNGE == 1)
			{
				ANIM_ATTACK = "long_attack1";
			}
			if (RND_LUNGE == 2)
			{
				ANIM_ATTACK = "long_attack2";
			}
			if (RND_LUNGE == 3)
			{
				ANIM_ATTACK = "long_attack_throw";
			}
		}
		if (GetGameTime() > NEXT_STOMP)
		{
			if (TARG_RANGE < ATTACK_RANGE_LUNGE_MIN)
			{
			}
			ANIM_ATTACK = ANIM_WARCRY1;
		}
		if ((NO_BREATH_ATTACK)) return;
		if (GetGameTime() > NEXT_BREATH)
		{
			if (TARG_RANGE < 600)
			{
			}
			ANIM_ATTACK = "breath_start";
		}
	}

	void ext_bear_swim()
	{
		if (m_hAttackTarget != "unset")
		{
			int GO_SWIM = 1;
		}
		if ((HUNTING_PLAYER))
		{
			int GO_SWIM = 1;
		}
		if (!(GO_SWIM)) return;
		SetMonsterClip(0);
	}

	void ext_bear_unswim()
	{
		SetMonsterClip(1);
	}

	void frame_attack()
	{
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_CLAW, 0.9, "slash");
		float RND_LR = Random(-100.0, 100.0);
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 5);
		AddVelocity(m_hAttackTarget, /* TODO: $relvel */ $relvel(RND_LR, 110, 110));
		int RND_ATK = RandomInt(1, 3);
		if (RND_ATK == 1)
		{
			ANIM_ATTACK = "attack1";
		}
		if (RND_ATK == 2)
		{
			ANIM_ATTACK = "attack2";
		}
		if (RND_ATK == 3)
		{
			ANIM_ATTACK = "attack3";
		}
		if ((NO_FROSTY_BREATH)) return;
		if (RandomInt(1, 3) == 1)
		{
			ClientEvent("update", "all", CLIENT_FX_ID, "quick_breath");
		}
	}

	void frame_long_attack()
	{
		ANIM_ATTACK = "attack1";
		ATTACK_RANGE = ATTACK_RANGE_NORM;
		ATTACK_HITRANGE = ATTACK_HITRANGE_NORM;
		NEXT_LUNGE = GetGameTime();
		NEXT_LUNGE += FREQ_LUNGE;
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (!(NO_FROSTY_BREATH))
		{
			ClientEvent("update", "all", CLIENT_FX_ID, "quick_breath");
		}
		DoDamage(m_hAttackTarget, ATTACK_RANGE_LUNGE_MAX, DMG_CLAW, 0.9, "slash");
		float RND_LR = Random(-200.0, 200.0);
		AddVelocity(m_hAttackTarget, /* TODO: $relvel */ $relvel(RND_LR, 300, 110));
	}

	void frame_long_attack_throw()
	{
		ANIM_ATTACK = "attack1";
		ATTACK_RANGE = ATTACK_RANGE_NORM;
		ATTACK_HITRANGE = ATTACK_HITRANGE_NORM;
		NEXT_LUNGE = GetGameTime();
		NEXT_LUNGE += FREQ_LUNGE;
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (!(NO_FROSTY_BREATH))
		{
			ClientEvent("update", "all", CLIENT_FX_ID, "quick_breath");
		}
		DoDamage(m_hAttackTarget, ATTACK_RANGE_LUNGE_MAX, DMG_CLAW, 0.9, "slash");
		float RND_LR = Random(-200.0, 200.0);
		AddVelocity(m_hAttackTarget, /* TODO: $relvel */ $relvel(RND_LR, 1000, 200));
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (GetEntityHealth(GetOwner()) < NPC_HALF_HEALTH)
		{
			if (GetGameTime() > NEXT_FLINCH)
			{
			}
			NEXT_FLINCH = GetGameTime();
			NEXT_FLINCH += FREQ_FLINCH;
			PlayAnim("critical", ANIM_FLINCH);
			int PAIN_SOUND = 1;
		}
		if (!(PAIN_SOUND))
		{
			// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3, SOUND_PAIN4, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
			array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3, SOUND_PAIN4, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		else
		{
			// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3, SOUND_PAIN4
			array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3, SOUND_PAIN4};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			if (!(NO_FROSTY_BREATH))
			{
			}
			ClientEvent("update", "all", CLIENT_FX_ID, "quick_breath");
		}
	}

	void frame_warcry()
	{
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
		if (!(NO_FROSTY_BREATH))
		{
			ClientEvent("update", "all", CLIENT_FX_ID, "quick_breath");
		}
		ANIM_ATTACK = "attack1";
	}

	void frame_land()
	{
		NEXT_STOMP = GetGameTime();
		NEXT_STOMP += FREQ_STOMP;
		ANIM_ATTACK = "attack1";
		ScheduleDelayedEvent(1.0, "restore_roam");
		BURST_START = /* TODO: $relpos */ $relpos(0, 150, 0);
		ClientEvent("new", "all", "effects/sfx_stun_burst", BURST_START, 256, 0);
		BURST_TARGS = FindEntitiesInSphere("enemy", 256);
		if (!(BURST_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(BURST_TARGS, ";"); i++)
		{
			burst_affect_targets();
		}
	}

	void burst_affect_targets()
	{
		string CUR_TARG = GetToken(BURST_TARGS, i, ";");
		ApplyEffect(CUR_TARG, "effects/debuff_stun", 8.0, GetEntityIndex(GetOwner()));
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string MY_ORG = BURST_START;
		string NEW_YAW = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		XDoDamage(CUR_TARG, "direct", DMG_BURST, 1.0, GetOwner(), GetOwner(), "none", "blunt");
		AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 1000, 200)));
	}

	void frame_alert()
	{
		ScheduleDelayedEvent(1.0, "restore_roam");
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
		if ((NO_FROSTY_BREATH)) return;
		ClientEvent("update", "all", CLIENT_FX_ID, "quick_breath");
	}

	void restore_roam()
	{
		SetRoam(true);
	}

	void frame_run_step()
	{
		RUN_STEP += 1;
		if (RUN_STEP == 1)
		{
			EmitSound(GetOwner(), 0, SOUND_RUNSTEP1, 5);
		}
		else
		{
			EmitSound(GetOwner(), 0, SOUND_RUNSTEP2, 5);
			RUN_STEP = 0;
		}
	}

	void refresh_cl_fx()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if ((NO_FROSTY_BREATH)) return;
		if ((NO_BREATH_ATTACK)) return;
		ClientEvent("new", "all", "monsters/gbear_polar_cl", GetEntityIndex(GetOwner()), FREQ_FX_REFRESH, BREATH_ON);
		CLIENT_FX_ID = "game.script.last_sent_id";
		FREQ_FX_REFRESH("refresh_cl_fx");
	}

	void frame_breath_go()
	{
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
		do_breath();
	}

	void do_breath()
	{
		NEXT_BREATH = GetGameTime();
		NEXT_BREATH += FREQ_BREATH;
		EmitSound(GetOwner(), 0, "magic/cold_breath.wav", 10);
		SetRoam(false);
		npcatk_suspend_ai(BREATH_DURATION);
		npcatk_suspend_movement(ANIM_BREATH_LOOP, BREATH_DURATION);
		ClientEvent("update", "all", CLIENT_FX_ID, "breath_on");
		BREATH_ON = 1;
		breath_loop();
		BREATH_DURATION("breath_end");
	}

	void breath_loop()
	{
		if (!(BREATH_ON)) return;
		ScheduleDelayedEvent(0.5, "breath_loop");
		BREATH_TARGS = FindEntitiesInSphere("enemy", 768);
		if (!(BREATH_TARGS != "none")) return;
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
		ApplyEffect(CUR_TARG, "effects/dot_cold_freeze", 6.0, GetEntityIndex(GetOwner()), 10.0);
		if (!(GetEntityRange(CUR_TARG) < 200)) return;
		AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(0, 800, 110));
	}

	void breath_end()
	{
		ANIM_ATTACK = "attack1";
		ScheduleDelayedEvent(1.0, "restore_roam");
		BREATH_ON = 0;
		ClientEvent("update", "all", CLIENT_FX_ID, "breath_off");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((NO_FROSTY_BREATH)) return;
		ClientEvent("update", "all", CLIENT_FX_ID, "quick_breath_last");
	}

}

}
