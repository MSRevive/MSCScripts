#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SwampReaver : CGameScript
{
	int ACID_BOMB_ATTACK;
	string ACID_BOMB_POS;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_DEATH1;
	string ANIM_DEATH2;
	string ANIM_DEATH3;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_VICTORY;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string BREATH_ANG;
	int BREATH_COUNT;
	string BREATH_TYPE;
	string CLOUD_TARGS;
	string CL_EFFECT_ID;
	int CYCLES_ON;
	int DID_WARCRY;
	int DOING_ACID_BOMB;
	int DOING_BREATH;
	int DOING_ERRUPT;
	int DOING_FIREBALL;
	int DOT_ACID_BOMB;
	float DOT_DMG;
	float DOT_DURATION;
	string DOT_EFFECT;
	string EFFECT_ACID_BOMB;
	string ERRUPT_TARGS;
	string ERRUPT_TYPE;
	int FIRST_ATTACK;
	string HP_STORAGE;
	int IS_FIRE_BOMB;
	int MIX_COUNT;
	int MOVE_RANGE;
	string NEXT_ACID_BOMB;
	string NEXT_BREATH;
	string NEXT_ERRUPT;
	string NEXT_FX_REFRESH;
	string NEXT_SCAN;
	string NEXT_SEARCH;
	string NPC_GIVE_EXP;
	string PROJECTILE_SCRIPT;
	int PUSH_ATTACK;
	string PUSH_VEL;
	string REAVER_LAST_FIRE_BALL;
	int SLASH_ATTACK;
	int SLASH_COUNT;
	int SMASH_ATTACK;
	string SOUND_ATTACKHIT;
	string SOUND_ATTACKMISS;
	int STUN_BURST;
	string STUN_POS;
	int VOLCANO_ON;

	SwampReaver()
	{
		const string REAVER_NAME = "Vitriolic Reaver";
		const int REAVER_MAXHP = 4000;
		const int REAVER_XP = 2750;
		const int REAVER_SKIN = 1;
		const string REAVER_MODEL = "monsters/firereaver.mdl";
		const int REAVER_WIDTH = 72;
		const int REAVER_HEIGHT = 64;
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_IDLE = "idle1";
		const string ANIM_SEARCH = "idle2";
		ANIM_FLINCH = "turnl";
		const string ANIM_SMASH = "mattack3";
		const string ANIM_SLASH = "mattack2";
		const string ANIM_PROJECTILE = "distanceattack";
		const string ANIM_BOMB = "bomb_attack";
		const string ANIM_ALERT = "distanceattack";
		const string ANIM_BREATH = "breath";
		ANIM_DEATH1 = "dieforward";
		ANIM_DEATH2 = "diesimple";
		ANIM_DEATH3 = "diesideways";
		const string ANIM_VICTORY1 = "victoryeat";
		const string ANIM_VICTORY2 = "victorysniff";
		ANIM_VICTORY = "victoryeat";
		ANIM_DEATH = "dieforward";
		ANIM_ATTACK = "mattack3";
		const float FREQ_FIRE_BALL = 10.0;
		const int DMG_FIRE_BALL = 100;
		const string SOUND_WALK1 = "common/npc_step1.wav";
		const string SOUND_WALK2 = "common/npc_step2.wav";
		const string SOUND_WALK3 = "common/npc_step3.wav";
		const string SOUND_WALK4 = "common/npc_step4.wav";
		const string SOUND_RUN1 = "gonarch/gon_step1.wav";
		const string SOUND_RUN2 = "gonarch/gon_step2.wav";
		const string SOUND_RUN3 = "gonarch/gon_step3.wav";
		const string SOUND_DEATH = "gonarch/gon_die1.wav";
		const string SOUND_WARCRY = "gonarch/gon_alert1.wav";
		const string SOUND_STRUCK1 = "gonarch/gon_sack1.wav";
		const string SOUND_STRUCK2 = "gonarch/gon_sack2.wav";
		const string SOUND_PAIN_STRONG = "gonarch/gon_pain2.wav";
		const string SOUND_PAIN_WEAK = "gonarch/gon_pain4.wav";
		const string SOUND_PAIN_NEAR_DEATH = "gonarch/gon_pain5.wav";
		const string SOUND_SLASHHIT = "zombie/claw_strike1.wav";
		const string SOUND_SMASHHIT = "zombie/claw_strike2.wav";
		const string SOUND_SLASHMISS = "zombie/claw_miss1.wav";
		const string SOUND_SMASHMISS = "zombie/claw_miss2.wav";
		const string SOUND_SEARCH1 = "gonarch/gon_childdie3.wav";
		const string SOUND_SEARCH2 = "gonarch/gon_childdie2.wav";
		const string SOUND_SEARCH3 = "gonarch/gon_childdie1.wav";
		SOUND_ATTACKHIT = "unset";
		SOUND_ATTACKMISS = "unset";
		Precache(SOUND_SLASHMISS);
		Precache(SOUND_SLASHHIT);
		Precache(SOUND_SMASHMISS);
		Precache(SOUND_SMASHHIT);
		Precache(SOUND_PAIN_STRONG);
		Precache(SOUND_PAIN_WEAK);
		Precache(SOUND_PAIN_NEAR_DEATH);
		ATTACK_RANGE = 140;
		ATTACK_HITRANGE = 200;
		ATTACK_MOVERANGE = 100;
		MOVE_RANGE = 100;
		const string SLASH_DAMAGE = "$rand(100,200)";
		const int SMASH_DAMAGE = 500;
		const float SLASH_HITCHANCE = 0.9;
		Precache(SOUND_DEATH);
		DOT_EFFECT = "effects/dot_poison";
		DOT_DURATION = 10.0;
		DOT_DMG = 30.0;
		const float FREQ_ERRUPT = 30.0;
		ERRUPT_TYPE = "poison";
		const string FREQ_BREATH = Random(20.0, 30.0);
		BREATH_TYPE = "poison";
		const string FREQ_ACID_BOMB = Random(5.0, 15.0);
		const int DOES_ACID_BOMB = 1;
		const string FIREBALL1_SCRIPT = "monsters/summon/acid_ball_guided";
		const string FIREBALL2_SCRIPT = "monsters/summon/acid_ball_guided";
		const float FIREBALL1_DURATION = 5.0;
		const float FIREBALL2_DURATION = 5.0;
		PROJECTILE_SCRIPT = "proj_acid_bomb";
		const int DMG_ACID_BOMB = 400;
		DOT_ACID_BOMB = 150;
		EFFECT_ACID_BOMB = "effects/dot_acid";
		const string SOUND_ACID_BOMB_PREP = "gonarch/gon_birth3.wav";
		const string SOUND_ACID_BOMB_FIRE = "gonarch/gon_birth1.wav";
		const string SOUND_POISON_ERRUPT_START = "monsters/mummy/c_mummycom_bat1.wav";
		const string SOUND_POISON_ERRUPT_LOOP = "amb/amb_spa2.wav";
		const string SOUND_POISON_BREATH_START = "monsters/mummy/c_mummycom_bat2.wav";
		const string SOUND_POISON_BREATH_LOOP = "magic/volcano_loop.wav";
		const string SOUND_FIRE_ERRUPT_START = "magic/volcano_start.wav";
		const string SOUND_FIRE_ERRUPT_LOOP = "magic/volcano_loop.wav";
		const string SOUND_FIRE_BREATH_START = "ambience/steamburst1.wav";
		const string SOUND_FIRE_BREATH_LOOP = "monsters/goblin/sps_fogfire.wav";
		const string BOMB_DMG_TYPE = "acid";
	}

	void game_precache()
	{
		Precache("monsters/summon/acid_ball_guided");
		Precache("effects/sfx_acid_splash");
	}

	void OnSpawn() override
	{
		SetName(REAVER_NAME);
		SetHealth(REAVER_MAXHP);
		SetRoam(true);
		reaver_immunes();
		SetWidth(72);
		SetHeight(64);
		NPC_GIVE_EXP = REAVER_XP;
		SetRace("demon");
		SetHearingSensitivity(3);
		SetModel(REAVER_MODEL);
		SetMoveAnim(ANIM_WALK);
		SetProp(GetOwner(), "skin", REAVER_SKIN);
		SetBloodType("green");
		SLASH_COUNT = 0;
		MIX_COUNT = 0;
	}

	void reaver_immunes()
	{
		SetDamageResistance("lightning", 2.0);
		SetDamageResistance("acid", 0.0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 0.5);
	}

	void npc_targetsighted()
	{
		if ((DID_WARCRY)) return;
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
		DID_WARCRY = 1;
		FIRST_ATTACK = 1;
		PlayAnim("once", ANIM_ALERT);
		if ((CYCLES_ON)) return;
		CYCLES_ON = 1;
		string GAME_TIME = GetGameTime();
		NEXT_ERRUPT = GAME_TIME;
		NEXT_ERRUPT += FREQ_ERRUPT;
		NEXT_BREATH = GAME_TIME;
		NEXT_BREATH += FREQ_BREATH;
		NEXT_ACID_BOMB = GAME_TIME;
		NEXT_ACID_BOMB += FREQ_ACID_BOMB;
		if (CL_EFFECT_ID == "CL_EFFECT_ID")
		{
			refresh_client_fx();
		}
		if (GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)
		{
			string LAST_FIRE = REAVER_LAST_FIRE_BALL;
			LAST_FIRE += FREQ_FIRE_BALL;
			if (!(DOING_BREATH))
			{
			}
			if (!(DOING_ACID_BOMB))
			{
			}
			if (GetGameTime() > LAST_FIRE)
			{
				do_fireballs();
			}
		}
	}

	void my_target_died()
	{
		if ((false)) return;
		string RAND_VICT = RandomInt(1, 2);
		if (RAND_VICT == 1)
		{
			ANIM_VICTORY = ANIM_VICTORY1;
		}
		if (RAND_VICT == 2)
		{
			ANIM_VICTORY = ANIM_VICTORY2;
		}
		PlayAnim("critical", ANIM_VICTORY);
		// PlayRandomSound from: SOUND_SEARCH1, SOUND_SEARCH2, SOUND_SEARCH3
		array<string> sounds = {SOUND_SEARCH1, SOUND_SEARCH2, SOUND_SEARCH3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void attack_mele1()
	{
		SLASH_ATTACK = 1;
		string RANDOM_PUSH = RandomInt(100, 175);
		PUSH_VEL = /* TODO: $relvel */ $relvel(-200, RANDOM_PUSH, 120);
		SOUND_ATTACKHIT = SOUND_SLASHHIT;
		SOUND_ATTACKMISS = SOUND_SLASHMISS;
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, SLASH_DAMAGE, SLASH_HITCHANCE);
		PUSH_ATTACK = 1;
		SLASH_COUNT += 1;
		if (SLASH_COUNT > RandomInt(9, 15))
		{
			ANIM_ATTACK = ANIM_SMASH;
		}
	}

	void attack_mele2()
	{
		SMASH_ATTACK = 1;
		SOUND_ATTACKHIT = SOUND_SMASHHIT;
		SOUND_ATTACKMISS = SOUND_SMASHMISS;
		ANIM_ATTACK = ANIM_SLASH;
		ClientEvent("new", "all", "effects/sfx_stun_burst", GetEntityOrigin(GetOwner()), 256, 0);
		STUN_BURST = 1;
		STUN_POS = GetEntityOrigin(GetOwner());
		DoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), 256, SMASH_DAMAGE, 1.0, 0);
		ScheduleDelayedEvent(0.1, "reset_stun_burst");
		SLASH_COUNT = 0;
		ANIM_ATTACK = ANIM_SLASH;
	}

	void reset_stun_burst()
	{
		STUN_BURST = 0;
	}

	void npcatk_lost_sight()
	{
		if (!(GetGameTime() > NEXT_SEARCH)) return;
		NEXT_SEARCH = GetGameTime();
		NEXT_SEARCH += 20.0;
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 10.0;
		PlayAnim("critical", ANIM_SEARCH);
		// PlayRandomSound from: SOUND_SEARCH1, SOUND_SEARCH2, SOUND_SEARCH3
		array<string> sounds = {SOUND_SEARCH1, SOUND_SEARCH2, SOUND_SEARCH3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void game_dodamage()
	{
		if ((STUN_BURST))
		{
			if ((param1))
			{
			}
			string TARG_ORG = GetEntityOrigin(param2);
			string MY_ORG = STUN_POS;
			string NEW_YAW = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
			AddVelocity(param2, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 1000, 200)));
			ApplyEffect(param2, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
		}
		if ((EXIT_SUB)) return;
		if ((ACID_BOMB_ATTACK))
		{
			int EXIT_SUB = 1;
			if ((param1))
			{
			}
			if (GetRelationship(param2) == "enemy")
			{
			}
			ApplyEffect(param2, EFFECT_ACID_BOMB, 5, GetEntityIndex(GetOwner()), DOT_ACID_BOMB, "none");
			if ((IS_FIRE_BOMB))
			{
			}
			string TARG_ORG = GetEntityOrigin(param2);
			string MY_ORG = ACID_BOMB_POS;
			string NEW_YAW = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
			AddVelocity(param2, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 1000, 200)));
		}
		if ((EXIT_SUB)) return;
		if (!(param1))
		{
			if (SOUND_ATTACKMISS != "unset")
			{
				EmitSound(GetOwner(), 0, SOUND_ATTACKMISS, 10);
			}
		}
		if ((param1))
		{
			if (SOUND_ATTACKHIT != "unset")
			{
				EmitSound(GetOwner(), 0, SOUND_ATTACKHIT, 10);
				if ((PUSH_ATTACK))
				{
				}
				AddVelocity(m_hLastStruckByMe, PUSH_VEL);
				ApplyEffect(DOT_EFFECT, DOT_DURATION, GetEntityIndex(GetOwner()), DOT_DMG);
			}
		}
		PUSH_ATTACK = 0;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		HP_STORAGE = GetMonsterHP();
		if (GetMonsterHP() >= 1500)
		{
			string PAIN_SOUND = SOUND_PAIN_STRONG;
		}
		if (GetMonsterHP() < 1500)
		{
			string PAIN_SOUND = SOUND_PAIN_WEAK;
		}
		if (GetMonsterHP() < 500)
		{
			string PAIN_SOUND = SOUND_PAIN_NEAR_DEATH;
		}
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK2, PAIN_SOUND
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK2, PAIN_SOUND};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void monster_walk_step()
	{
		// PlayRandomSound from: SOUND_WALK1, SOUND_WALK2, SOUND_WALK3, SOUND_WALK4
		array<string> sounds = {SOUND_WALK1, SOUND_WALK2, SOUND_WALK3, SOUND_WALK4};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 5);
	}

	void monster_run_step()
	{
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 64, 10, 0.5, 128);
		// PlayRandomSound from: SOUND_RUN1, SOUND_RUN2, SOUND_RUN3
		array<string> sounds = {SOUND_RUN1, SOUND_RUN2, SOUND_RUN3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 8);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		string RAND_DEATH = RandomInt(2, 3);
		if (RAND_DEATH == 2)
		{
			ANIM_DEATH = ANIM_DEATH2;
		}
		if (RAND_DEATH == 3)
		{
			ANIM_DEATH = ANIM_DEATH3;
		}
		SetMoveDest("none");
		SetMoveAnim(ANIM_DEATH);
	}

	void npcatk_clear_targets()
	{
		VOLCANO_ON = 0;
		// svplaysound: svplaysound 2 0 magic/volcano_loop.wav
		EmitSound(2, 0, "magic/volcano_loop.wav");
	}

	void do_fireballs()
	{
		if ((I_R_FROZEN)) return;
		DOING_FIREBALL = 1;
		ScheduleDelayedEvent(2.0, "fireball_release");
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 10.0;
		REAVER_LAST_FIRE_BALL = GetGameTime();
		PlayAnim("critical", ANIM_PROJECTILE);
		SpawnNPC(FIREBALL1_SCRIPT, /* TODO: $relpos */ $relpos(-64, 96, 64), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), DMG_FIRE_BALL, FIREBALL1_DURATION, 200
		ScheduleDelayedEvent(0.2, "do_fireballs2");
	}

	void do_fireballs2()
	{
		SpawnNPC(FIREBALL2_SCRIPT, /* TODO: $relpos */ $relpos(64, 96, 64), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), DMG_FIRE_BALL, FIREBALL2_DURATION, 200
	}

	void fireball_release()
	{
		DOING_FIREBALL = 0;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		string GAME_TIME = GetGameTime();
		if ((CYCLES_ON))
		{
			if (GAME_TIME > NEXT_FX_REFRESH)
			{
			}
			refresh_client_fx();
		}
		if (!(m_hAttackTarget != "unset")) return;
		if (GAME_TIME > NEXT_ERRUPT)
		{
			NEXT_ERRUPT = GAME_TIME;
			NEXT_ERRUPT += FREQ_ERRUPT;
			if ((MIXED_REAVER))
			{
				mixed_reaver_switch();
			}
			do_errupt();
		}
		if (!(false)) return;
		if ((DOING_FIREBALL)) return;
		if (GAME_TIME > NEXT_BREATH)
		{
			if (!(DOING_ACID_BOMB))
			{
			}
			if (GetEntityRange(m_hAttackTarget) < 300)
			{
			}
			NEXT_BREATH = GAME_TIME;
			NEXT_BREATH += FREQ_BREATH;
			if ((MIXED_REAVER))
			{
				mixed_reaver_switch();
			}
			if (!(I_R_FROZEN))
			{
			}
			do_breath();
		}
		if (GAME_TIME > NEXT_ACID_BOMB)
		{
			if (!(DOING_ERRUPT))
			{
			}
			if (!(DOING_BREATH))
			{
			}
			if (GetEntityRange(m_hAttackTarget) > 275)
			{
			}
			NEXT_ACID_BOMB = GAME_TIME;
			NEXT_ACID_BOMB += FREQ_ACID_BOMB;
			if ((MIXED_REAVER))
			{
				mixed_reaver_switch();
			}
			if (!(I_R_FROZEN))
			{
			}
			do_acid_bomb();
		}
	}

	void refresh_client_fx()
	{
		NEXT_FX_REFRESH = GetGameTime();
		NEXT_FX_REFRESH += 30.0;
		ClientEvent("new", "all", "monsters/reavers_cl", GetEntityIndex(GetOwner()), BREATH_TYPE, ERRUPT_TYPE, DOING_ERRUPT, DOING_BREATH);
		CL_EFFECT_ID = "game.script.last_sent_id";
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!(CL_EFFECT_ID != "CL_EFFECT_ID")) return;
		if ((DOING_BREATH))
		{
			frame_breath_end();
		}
		if ((DOING_ERRUPT))
		{
			end_errupt();
		}
		ClientEvent("update", "all", CL_EFFECT_ID, "end_fx");
		if (StringToLower(GetMapName()) == "mscave")
		{
			string CHEST_ID = FindEntityByName("fire_cave_chest2");
			if (((CHEST_ID !is null)))
			{
			}
			SpawnNPC("mscave/firecave2", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: "fire_reaver"
		}
	}

	void do_errupt()
	{
		DOING_ERRUPT = 1;
		ClientEvent("update", "all", CL_EFFECT_ID, "errupt_on", ERRUPT_TYPE);
		errupt_loop();
		ScheduleDelayedEvent(10.0, "end_errupt");
		if (ERRUPT_TYPE == "poison")
		{
			// svplaysound: svplaysound 1 10 SOUND_POISON_ERRUPT_LOOP
			EmitSound(1, 10, SOUND_POISON_ERRUPT_LOOP);
			EmitSound(GetOwner(), 2, SOUND_POISON_ERRUPT_START, 10);
		}
		else
		{
			// svplaysound: svplaysound 1 10 SOUND_FIRE_ERRUPT_LOOP
			EmitSound(1, 10, SOUND_FIRE_ERRUPT_LOOP);
			EmitSound(GetOwner(), 2, SOUND_FIRE_ERRUPT_START, 10);
		}
	}

	void errupt_loop()
	{
		if (!(DOING_ERRUPT)) return;
		ScheduleDelayedEvent(0.75, "errupt_loop");
		if (ERRUPT_TYPE == "poison")
		{
			ERRUPT_TARGS = FindEntitiesInSphere("enemy", 160);
			if (ERRUPT_TARGS != "none")
			{
			}
			for (int i = 0; i < GetTokenCount(ERRUPT_TARGS, ";"); i++)
			{
				errupt_affect_targets_poison();
			}
		}
		else
		{
			ERRUPT_TARGS = FindEntitiesInSphere("enemy", 225);
			if (ERRUPT_TARGS != "none")
			{
			}
			for (int i = 0; i < GetTokenCount(ERRUPT_TARGS, ";"); i++)
			{
				errupt_affect_targets_fire();
			}
		}
	}

	void errupt_affect_targets_poison()
	{
		string CUR_TARG = GetToken(ERRUPT_TARGS, i, ";");
		ApplyEffect(CUR_TARG, "effects/dot_poison_blind", 5.0, GetEntityIndex(GetOwner()), DOT_DMG);
	}

	void errupt_affect_targets_fire()
	{
		string CUR_TARG = GetToken(ERRUPT_TARGS, i, ";");
		ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_DMG);
	}

	void end_errupt()
	{
		DOING_ERRUPT = 0;
		ClientEvent("update", "all", CL_EFFECT_ID, "errupt_off");
		if (ERRUPT_TYPE == "poison")
		{
			// svplaysound: svplaysound 1 0 SOUND_POISON_ERRUPT_LOOP
			EmitSound(1, 0, SOUND_POISON_ERRUPT_LOOP);
		}
		else
		{
			// svplaysound: svplaysound 1 0 SOUND_FIRE_ERRUPT_LOOP
			EmitSound(1, 0, SOUND_FIRE_ERRUPT_LOOP);
		}
	}

	void do_breath()
	{
		SetRoam(false);
		PlayAnim("once", "break");
		PlayAnim("critical", ANIM_BREATH);
		npcatk_suspend_movement(ANIM_BREATH);
		if (BREATH_TYPE == "poison")
		{
			EmitSound(GetOwner(), 1, SOUND_POISON_BREATH_START, 10);
		}
		else
		{
			EmitSound(GetOwner(), 1, SOUND_FIRE_BREATH_START, 10);
		}
		SetMoveDest(m_hAttackTarget);
		npcatk_suspend_ai();
		BREATH_ANG = GetEntityProperty(GetOwner(), "angles.yaw");
		ScheduleDelayedEvent(1.5, "frame_breath_start");
		ScheduleDelayedEvent(15.0, "frame_breath_end");
	}

	void frame_breath_start()
	{
		LogDebug("frame_breath_start");
		if ((DOING_BREATH)) return;
		DOING_BREATH = 1;
		if (BREATH_TYPE == "poison")
		{
			EmitSound(GetOwner(), 2, SOUND_POISON_BREATH_LOOP, 10);
		}
		else
		{
			EmitSound(GetOwner(), 2, SOUND_FIRE_BREATH_LOOP, 10);
		}
		BREATH_COUNT = 0;
		BREATH_ANG = GetEntityProperty(GetOwner(), "angles.yaw");
		ScheduleDelayedEvent(0.1, "breath_loop");
		ClientEvent("update", "all", CL_EFFECT_ID, "breath_on", BREATH_TYPE);
	}

	void breath_loop()
	{
		if (!(DOING_BREATH)) return;
		ScheduleDelayedEvent(0.05, "breath_loop");
		BREATH_ANG += 10;
		if (BREATH_ANG > 359.99)
		{
			BREATH_ANG -= 359.99;
		}
		string FACE_POS = GetEntityOrigin(GetOwner());
		FACE_POS += /* TODO: $relpos */ $relpos(Vector3(0, BREATH_ANG, 0), Vector3(0, 1000, 0));
		SetMoveDest(FACE_POS);
		LogDebug("breath_loop BREATH_ANG");
		if (!(GetGameTime() > NEXT_SCAN)) return;
		NEXT_SCAN = GetGameTime();
		NEXT_SCAN += 0.25;
		string SCAN_POINT = /* TODO: $relpos */ $relpos(0, 128, 0);
		CLOUD_TARGS = FindEntitiesInSphere("enemy", 256);
		if (CLOUD_TARGS != "none")
		{
			for (int i = 0; i < GetTokenCount(CLOUD_TARGS, ";"); i++)
			{
				breath_affect_targets();
			}
		}
	}

	void breath_affect_targets()
	{
		string CUR_TARG = GetToken(CLOUD_TARGS, i, ";");
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		if (!(WithinCone2D(TARG_ORG, GetMonsterProperty("origin"), GetMonsterProperty("angles")))) return;
		string TARG_RANGE = GetEntityRange(CUR_TARG);
		if (!(TARG_RANGE < 450)) return;
		if (BREATH_TYPE == "poison")
		{
			ApplyEffect(CUR_TARG, "effects/dot_poison_blind", 5.0, GetEntityIndex(GetOwner()), DOT_DMG, 0, 0, "none");
		}
		else
		{
			ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_DMG);
		}
		int PUSH_STR = 1000;
		if (TARG_RANGE > 200)
		{
			PUSH_STR -= TARG_RANGE;
		}
		AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(0, PUSH_STR, 120));
	}

	void frame_breath_end()
	{
		LogDebug("frame_breath_end");
		if (!(DOING_BREATH)) return;
		DOING_BREATH = 0;
		npcatk_resume_ai();
		npcatk_resume_movement();
		ClientEvent("update", "all", CL_EFFECT_ID, "breath_off");
		SetRoam(true);
		NEXT_ACID_BOMB += 5.0;
	}

	void do_acid_bomb()
	{
		LogDebug("do_acid_bomb");
		SetRoam(false);
		DOING_ACID_BOMB = 1;
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 10.0;
		EmitSound(GetOwner(), 0, SOUND_ACID_BOMB_PREP, 10);
		ScheduleDelayedEvent(3.0, "doing_acid_bomb_reset");
		PlayAnim("critical", ANIM_BOMB);
	}

	void doing_acid_bomb_reset()
	{
		DOING_ACID_BOMB = 0;
	}

	void attack_ranged()
	{
		LogDebug("attack_ranged");
		EmitSound(GetOwner(), 0, SOUND_ACID_BOMB_FIRE, 10);
		NEXT_BREATH += 5.0;
	}

	void attack_bomb()
	{
		EmitSound(GetOwner(), 0, SOUND_ACID_BOMB_FIRE, 10);
		string TARG_ORG = GetEntityOrigin(m_hAttackTarget);
		if (!(IsValidPlayer(TARG_ORG)))
		{
			TARG_ORG += "z";
		}
		string TARG_DIST = Distance(TARG_ORG, GetMonsterProperty("origin"));
		TARG_DIST /= 35;
		SetAngles("add_view.pitch");
		LogDebug("attack_bomb GetEntityRange(m_hAttackTarget)");
		int BOMB_SPEED = 500;
		if (GetEntityRange(m_hAttackTarget) > 800)
		{
			int BOMB_SPEED = 600;
		}
		TossProjectile(PROJECTILE_SCRIPT, /* TODO: $relpos */ $relpos(0, 20, 28), "none", BOMB_SPEED, DMG_BOMB, 0, "none");
		SetRoam(true);
		DOING_ACID_BOMB = 0;
	}

	void ext_acid_bomb()
	{
		ACID_BOMB_ATTACK = 1;
		XDoDamage(param1, 200, DMG_ACID_BOMB, 1.0, GetOwner(), GetOwner(), "none", "acid");
		IS_FIRE_BOMB = 1;
		ScheduleDelayedEvent(0.1, "acid_bomb_reset");
	}

	void acid_bomb_reset()
	{
		ACID_BOMB_ATTACK = 0;
	}

	void ext_fire_bomb()
	{
		ACID_BOMB_ATTACK = 1;
		ACID_BOMB_POS = param1;
		IS_FIRE_BOMB = 1;
		XDoDamage(ACID_BOMB_POS, 200, DMG_ACID_BOMB, 0.01, GetOwner(), GetOwner(), "none", BOMB_DMG_TYPE);
		ScheduleDelayedEvent(0.1, "acid_bomb_reset");
	}

}

}
