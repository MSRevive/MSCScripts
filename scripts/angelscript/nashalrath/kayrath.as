#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class Kayrath : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int CYCLES_ON;
	int FIRE_ON;
	int FIRE_PREPPING;
	string FIRE_ROT;
	string FIRE_ROTATE;
	string FIRE_TARGS;
	string FIRE_TYPE;
	string HALF_HEALTH;
	int IS_UNHOLY;
	string NEXT_KICK;
	string NEXT_SCAN;
	string NEXT_SEARCH;
	string NEXT_SMASH;
	string NEXT_STOMP;
	string NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	int NPC_MUST_SEE_TARGET;
	string STUN_BURST_DMG;
	string STUN_BURST_POS;
	string STUN_BURST_RAD;
	string STUN_BURST_REPEL;
	string STUN_LIST;

	Kayrath()
	{
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle3";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack";
		ANIM_DEATH = "die";
		ANIM_FLINCH = "Flinchheavy";
		const string ANIM_SWING = "attack";
		const string ANIM_SMASH = "smash";
		const string ANIM_STOMP = "stomp";
		const string ANIM_KICK = "kickcar";
		const string ANIM_PIERCE = "bitehead";
		const string ANIM_FIRE_PREP = "shootflames1";
		const string ANIM_FIRE_HOLD = "shootflames2";
		const string ANIM_RAWR = "idle2";
		const string ANIM_SEARCH = "idle4";
		ATTACK_RANGE = 200;
		ATTACK_MOVERANGE = 100;
		ATTACK_HITRANGE = 250;
		IS_UNHOLY = 1;
		NPC_MUST_SEE_TARGET = 0;
		const int MOVERANGE_NORMAL = 100;
		const int SMASH_RANGE = 150;
		const int SWING_RANGE = 200;
		const int KICK_RANGE = 150;
		const int ATTACH_HORN = 0;
		const int ATTACH_RIGHT = 1;
		const int ATTACH_LEFT = 2;
		const int DMG_SWING = 200;
		const int DMG_SMASH = 400;
		const int DMG_STOMP = 400;
		const int DOT_FIRE = 150;
		const int DOT_POISON = 75;
		const float FIRE_DURATION = 6.0;
		const float CUSTOM_FLINCH_CHANCE = 0.25;
		const string FREQ_STOMP = Random(20.0, 30.0);
		const string FREQ_KICK = Random(20.0, 30.0);
		const string FREQ_SMASH = Random(20.0, 30.0);
		const string FREQ_FIRE = Random(30.0, 40.0);
		const float FREQ_SEARCH = 20.0;
		const string FREQ_RANDRAWR = Random(20.0, 40.0);
		const int BONEIDX_STOMPFOOT = 6;
		const string SOUND_YAWN1 = "garg/gar_breathe1.wav";
		const string SOUND_YAWN2 = "garg/gar_breathe2.wav";
		const string SOUND_YAWN3 = "garg/gar_breathe3.wav";
		const string SOUND_RAWR = "garg/gar_alert2.wav";
		const string SOUND_RUNSTEP1 = "garg/gar_step1.wav";
		const string SOUND_RUNSTEP2 = "garg/gar_step2.wav";
		const string SOUND_WALKSTEP1 = "player/pl_grate1.wav";
		const string SOUND_WALKSTEP2 = "player/pl_grate2.wav";
		const string SOUND_SWING = "weapons/swinghuge.wav";
		const string SOUND_KICK = "weapons/swinghuge.wav";
		const string SOUND_STOMP = "magic/boom.wav";
		const string SOUND_DEATH = "garg/gar_die1.wav";
		const string SOUND_FIRE_PREP = "garg/gar_flameon1.wav";
		const string SOUND_FIRE_LOOP = "garg/gar_flamerun1.wav";
		const string SOUND_FIRE_END = "garg/gar_flameoff1.wav";
		const string SOUND_RANDRAWR1 = "garg/gar_attack1.wav";
		const string SOUND_RANDRAWR2 = "garg/gar_attack2.wav";
		const string SOUND_RANDRAWR3 = "garg/gar_attack3.wav";
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "debris/bustflesh2.wav";
		const string SOUND_PAIN1 = "garg/gar_pain1.wav";
		const string SOUND_PAIN2 = "garg/gar_pain2.wav";
		const string SOUND_PAIN3 = "garg/gar_pain3.wav";
		const string SOUND_SEARCH = "garg/gar_alert1.wav";
		const string FIRE_CLSCRIPT = "nashalrath/kayrath_cl";
		if ((StringToLower(GetMapName())).findFirst("nashalrath") >= 0)
		{
			NPC_IS_BOSS = 1;
			NPC_GIVE_EXP = 8000;
		}
		else
		{
			NPC_GIVE_EXP = 1000;
		}
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(FREQ_RANDRAWR);
		if (m_hAttackTarget != "unset")
		{
		}
		if (!(FIRE_PREPPING))
		{
		}
		if (!(FIRE_ON))
		{
		}
		// PlayRandomSound from: SOUND_RANDRAWR1, SOUND_RANDRAWR2, SOUND_RANDRAWR3
		array<string> sounds = {SOUND_RANDRAWR1, SOUND_RANDRAWR2, SOUND_RANDRAWR3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void game_precache()
	{
		Precache(SOUND_STOMP);
		Precache("poison_cloud.spr");
		Precache("explode1.spr");
		Precache("3dmflaora.spr");
		Precache(FIRE_CLSCRIPT);
	}

	void OnSpawn() override
	{
		SetName("Kay'rath");
		SetModel("monsters/kayrath.mdl");
		SetWidth(75);
		SetHeight(200);
		SetHealth(15000);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("cold", 0.5);
		SetDamageResistance("holy", 1.25);
		SetDamageResistance("stun", 0);
		SetRace("demon");
		SetRoam(false);
		SetHearingSensitivity(4);
		if (!(true)) return;
		HALF_HEALTH = GetEntityMaxHealth(GetOwner());
		HALF_HEALTH *= 0.5;
		npcatk_suspend_ai();
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 15.0;
		FREQ_FIRE("do_fire");
		CallExternal(GAME_MASTER, "gm_fade_in", GetEntityIndex(GetOwner()), 5);
	}

	void fade_in_done()
	{
		npcatk_resume_ai();
		SetRoam(true);
		SetProp(GetOwner(), "rendermode", 0);
		SetProp(GetOwner(), "renderamt", 255);
	}

	void cycle_up()
	{
		if ((CYCLES_ON)) return;
		CYCLES_ON = 1;
		PlayAnim("critical", ANIM_RAWR);
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 15.0;
		EmitSound(GetOwner(), 0, SOUND_RAWR, 10);
		string GAME_TIME = GetGameTime();
		NEXT_KICK = GAME_TIME;
		NEXT_KICK += FREQ_KICK;
		NEXT_SMASH = GAME_TIME;
		NEXT_SMASH += FREQ_SMASH;
		NEXT_STOMP = GAME_TIME;
		NEXT_STOMP += FREQ_STOMP;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (param1 > 250)
		{
			// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3
			array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			int EXIT_SUB = 1;
			if (!(FIRE_PREPPING))
			{
			}
			if (!(FIRE_ON))
			{
			}
			if (RandomInt(1, 100) <= CUSTOM_FLINCH_CHANCE)
			{
			}
			PlayAnim("critical", ANIM_FLINCH);
		}
		if ((EXIT_SUB)) return;
		if (GetEntityHealth(GetOwner()) > HALF_HEALTH)
		{
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		else
		{
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

	void frame_swing()
	{
		EmitSound(GetOwner(), 0, SOUND_SWING, 10);
		string LOC_DMG = GetEntityProperty(GetOwner(), "attachpos");
		LOC_DMG += /* TODO: $relpos */ $relpos(Vector3(0, GetMonsterProperty("angles.yaw"), 0), Vector3(0, 100, -32));
		XDoDamage(LOC_DMG, 200, DMG_SWING, 0, GetOwner(), GetOwner(), "none", "blunt");
		string GAME_TIME = GetGameTime();
		if (GAME_TIME > NEXT_STOMP)
		{
			ANIM_ATTACK = ANIM_STOMP;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GAME_TIME > NEXT_SMASH)
		{
			ANIM_ATTACK = ANIM_SMASH;
			ATTACK_RANGE = SMASH_RANGE;
			string NEW_MOVE_RANGE = SMASH_RANGE;
			NEW_MOVE_RANGE /= 2;
			ATTACK_MOVERANGE = NEW_MOVE_RANGE;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GAME_TIME > NEXT_KICK)
		{
			ANIM_ATTACK = ANIM_KICK;
			ATTACK_RANGE = KICK_RANGE;
			string NEW_MOVE_RANGE = KICK_RANGE;
			NEW_MOVE_RANGE /= 2;
			ATTACK_MOVERANGE = NEW_MOVE_RANGE;
		}
	}

	void frame_stomp()
	{
		ANIM_ATTACK = ANIM_SWING;
		string BURST_POS = GetEntityProperty(GetOwner(), "svbonepos");
		string GRND_BURST = /* TODO: $get_ground_height */ $get_ground_height(BURST_POS);
		BURST_POS = "z";
		stunburst_go(BURST_POS, 256, 1, DMG_STOMP);
		NEXT_STOMP = GetGameTime();
		NEXT_STOMP += FREQ_STOMP;
	}

	void frame_smash()
	{
		ANIM_ATTACK = ANIM_SWING;
		ATTACK_RANGE = SWING_RANGE;
		ATTACK_MOVERANGE = MOVERANGE_NORMAL;
		string BURST_POS = GetEntityProperty(GetOwner(), "attachpos");
		string GRND_BURST = /* TODO: $get_ground_height */ $get_ground_height(BURST_POS);
		BURST_POS = "z";
		stunburst_go(BURST_POS, 128, 0, DMG_SMASH);
		NEXT_SMASH = GetGameTime();
		NEXT_SMASH += FREQ_SMASH;
	}

	void frame_kick()
	{
		EmitSound(GetOwner(), 0, SOUND_SWING, 10);
		ANIM_ATTACK = ANIM_SWING;
		ATTACK_RANGE = SWING_RANGE;
		ATTACK_MOVERANGE = MOVERANGE_NORMAL;
		DoDamage(m_hAttackTarget, KICK_RANGE, DMG_KICK, 1.0, "blunt");
		NEXT_KICK = GetGameTime();
		NEXT_KICK += FREQ_KICK;
		if (!(GetEntityRange(m_hAttackTarget) < KICK_RANGE)) return;
		ApplyEffect(m_hAttackTarget, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
		AddVelocity(m_hAttackTarget, /* TODO: $relvel */ $relvel(0, 1000, 110));
	}

	void frame_fire_prep_done()
	{
		if ((FIRE_ON)) return;
		fire_start();
	}

	void frame_walkstep1()
	{
		EmitSound(GetOwner(), 0, SOUND_WALKSTEP1, 10);
	}

	void frame_walkstep2()
	{
		EmitSound(GetOwner(), 0, SOUND_WALKSTEP2, 10);
	}

	void frame_runstep1()
	{
		EmitSound(GetOwner(), 0, SOUND_RUNSTEP1, 10);
	}

	void frame_runstep2()
	{
		EmitSound(GetOwner(), 0, SOUND_RUNSTEP2, 10);
	}

	void stunburst_go()
	{
		STUN_BURST_POS = param1;
		STUN_BURST_RAD = param2;
		STUN_BURST_REPEL = param3;
		STUN_BURST_DMG = param4;
		LogDebug("stunburst_go pos: STUN_BURST_POS rad: STUN_BURST_RAD repel: STUN_BURST_REPEL dmg: STUN_BURST_DMG");
		DoDamage(STUN_BURST_POS, STUN_BURST_RAD, STUN_BURST_DMG, 1.0, 0);
		ClientEvent("new", "all", "effects/sfx_stun_burst", STUN_BURST_POS, STUN_BURST_RAD, 0, Vector3(0, 0, 0));
		ScheduleDelayedEvent(0.25, "stun_targets");
	}

	void stun_targets()
	{
		STUN_LIST = FindEntitiesInSphere("enemy", STUN_BURST_RAD);
		LogDebug("stun_targets STUN_LIST");
		if (!(STUN_LIST != "none")) return;
		if (!(GetTokenCount(STUN_LIST, ";") > 0)) return;
		for (int i = 0; i < GetTokenCount(STUN_LIST, ";"); i++)
		{
			stunburst_affect_targets();
		}
	}

	void stunburst_affect_targets()
	{
		string CHECK_ENT = GetToken(STUN_LIST, i, ";");
		if (!(IsOnGround(CHECK_ENT))) return;
		ApplyEffect(CHECK_ENT, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
		if (!(STUN_BURST_REPEL)) return;
		string TARGET_ORG = GetEntityOrigin(CHECK_ENT);
		string TARG_ANG = /* TODO: $angles */ $angles(STUN_BURST_POS, TARGET_ORG);
		string NEW_YAW = TARG_ANG;
		SetVelocity(CHECK_ENT, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 1000, 0)));
	}

	void do_fire()
	{
		SetRepeatDelay(FREQ_FIRE);
		if ((SUSPEND_AI)) return;
		if (!(m_hAttackTarget != "unset")) return;
		FIRE_PREPPING = 1;
		PlayAnim("critical", ANIM_FIRE_PREP);
		EmitSound(GetOwner(), 0, SOUND_FIRE_PREP, 10);
		npcatk_suspend_ai(FIRE_DURATION);
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 10.0;
		SetMoveAnim(ANIM_FIRE_HOLD);
		SetIdleAnim(ANIM_FIRE_HOLD);
		SetRoam(false);
		ScheduleDelayedEvent(1.0, "fire_start");
	}

	void fire_start()
	{
		if ((FIRE_ON)) return;
		// svplaysound: svplaysound 1 10 SOUND_FIRE_LOOP
		EmitSound(1, 10, SOUND_FIRE_LOOP);
		FIRE_ON = 1;
		FIRE_PREPPING = 0;
		FIRE_DURATION("fire_end");
		FIRE_TYPE = RandomInt(1, 2);
		FIRE_ROTATE = RandomInt(0, 1);
		if ((FIRE_ROTATE))
		{
			string START_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
			START_YAW -= 45;
			if (START_YAW < 0)
			{
				START_YAW += 359;
			}
			SetAngles("face");
			FIRE_ROT = START_YAW;
		}
		ClientEvent("new", "all", FIRE_CLSCRIPT, GetEntityIndex(GetOwner()), FIRE_TYPE, FIRE_DURATION);
		fire_loop();
	}

	void fire_loop()
	{
		if (!(FIRE_ON)) return;
		ScheduleDelayedEvent(0.1, "fire_loop");
		if ((FIRE_ROTATE))
		{
			string FACE_POS = GetEntityOrigin(GetOwner());
			FACE_POS += /* TODO: $relpos */ $relpos(Vector3(0, FIRE_ROT, 0), Vector3(0, 500, 0));
			SetMoveDest(FACE_POS);
			FIRE_ROT += 1;
			if (FIRE_ROT > 359)
			{
				FIRE_ROT -= 359;
			}
		}
		if (!(GetGameTime() > NEXT_SCAN)) return;
		NEXT_SCAN = GetGameTime();
		NEXT_SCAN += 0.5;
		FIRE_TARGS = /* TODO: $get_tbox */ $get_tbox("enemy", 512);
		if (!(FIRE_TARGS != "none")) return;
		GetTokenCount(FIRE_TARGS, ";")("fire_affect_targets");
	}

	void fire_affect_targets()
	{
		string CUR_TARG = GetToken(FIRE_TARGS, i, ";");
		if (!(IsEntityAlive(CUR_TARG))) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string IN_CONE = WithinCone2D(TARG_ORG, GetMonsterProperty("origin"), GetMonsterProperty("angles"));
		LogDebug("fire_affect_targets GetEntityName(CUR_TARG) incone IN_CONE rng GetEntityRange(CUR_TARG)");
		if (!(IN_CONE)) return;
		if (!(GetEntityRange(CUR_TARG) < 512)) return;
		if (FIRE_TYPE == 1)
		{
			ApplyEffect(CUR_TARG, "effects/dot_fire", 10.0, GetEntityIndex(GetOwner()), DOT_FIRE);
		}
		if (FIRE_TYPE == 2)
		{
			ApplyEffect(CUR_TARG, "effects/dot_poison", 10.0, GetEntityIndex(GetOwner()), DOT_POISON);
		}
	}

	void fire_end()
	{
		// svplaysound: svplaysound 1 0 SOUND_FIRE_LOOP
		EmitSound(1, 0, SOUND_FIRE_LOOP);
		EmitSound(GetOwner(), 2, SOUND_FIRE_END, 10);
		FIRE_ON = 0;
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_RUN);
		SetRoam(true);
	}

	void npcatk_lost_sight()
	{
		if (!(GetGameTime() > NEXT_SEARCH)) return;
		if ((FLAME_ON)) return;
		if ((FLAME_PREPPING)) return;
		EmitSound(GetOwner(), 0, SOUND_SEARCH, 10);
		PlayAnim("critical", ANIM_SEARCH);
		NEXT_SEARCH = GetGameTime();
		NEXT_SEARCH += FREQ_SEARCH;
	}

}

}
