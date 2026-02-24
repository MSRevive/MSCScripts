#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SkeletonArcherBase : CGameScript
{
	int AM_SKELETON;
	int AM_TURRET;
	string ANIM_ARROW;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_DEATH_IDLE;
	string ANIM_IDLE;
	string ANIM_REBIRTH;
	string ANIM_RUN;
	string ANIM_SIT_IDLE;
	string ANIM_SIT_STAND;
	string ANIM_SWIPE;
	string ANIM_WALK;
	string AS_ATTACKING;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	float BASE_MOVESPEED;
	int CUSTOM_TURN_UNDEAD;
	int C_SKELE_PUSH_STRENGTH;
	int DMG_ARROW;
	int DMG_SWIPE;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	int MIDX_HIDE_ARROW;
	int MIDX_SHOW_ARROW;
	int NO_STUCK_CHECKS;
	int NPC_IS_TURRET;
	string NPC_PREV_TARGET;
	int NPC_PROXACT_CONE;
	string NPC_PROXACT_EVENT;
	int NPC_PROXACT_FOV;
	int NPC_PROXACT_IFSEEN;
	int NPC_PROXACT_PLAYERID;
	int NPC_PROXACT_RANGE;
	int NPC_PROXACT_TRIPPED;
	int NPC_PROX_ACTIVATE;
	int NPC_RANGED;
	int PLAYING_DEAD;
	string SKELE_ARROW_KNOCKBACK;
	int SKELE_ARROW_NOPUSHIE;
	string SKELE_ARROW_OFS;
	int SKELE_ARROW_RANGE;
	string SKELE_ARROW_SCRIPT;
	int SKELE_ARROW_SPEED;
	int SKELE_BASE_ROAM;
	string SKELE_CANT_GET_UP;
	int SKELE_COF_A;
	int SKELE_COF_B;
	string SKELE_DEFAULT_ANIM_IDLE;
	string SKELE_DEFAULT_ANIM_RUN;
	string SKELE_DEFAULT_ANIM_WALK;
	string SKELE_FIRST_RAISE;
	int SKELE_HEARING;
	string SKELE_LIVES;
	int SKELE_MISS_COUNT;
	string SKELE_ORG_NAME;
	int SKELE_PUNCH_NOPUSHIE;
	string SKELE_PUSH_STRENGTH;
	string SKELE_REALLY_CANT_GET_UP;
	string SKELE_REBIRTH_SCAN;
	int SKELE_START_LIVES;
	int SKELE_STRUCK_BY_TURN_UNDEAD;
	string SKELE_TARGET_LIST;
	int SKELE_TURN_UNDEAD_SOUND;
	string SOUND_DEATH;
	string SOUND_HOLY_STRIKE;
	string SOUND_SHOOT;
	string SOUND_STRETCH;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SOUND_SWIPE;
	string SOUND_TURNED1;
	string SOUND_TURNED2;
	string SOUND_TURNED3;
	string SOUND_TURNED4;
	int SWIPE_HITRANGE;
	int SWIPE_RANGE;

	SkeletonArcherBase()
	{
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle1";
		ANIM_RUN = "run";
		ANIM_ATTACK = "shootarrow";
		ANIM_DEATH = "dieforward";
		ANIM_ARROW = "shootarrow";
		ANIM_SWIPE = "attack1";
		ANIM_DEATH_IDLE = "dead_on_stomach";
		ANIM_REBIRTH = "getup";
		ANIM_SIT_IDLE = "sitidle";
		ANIM_SIT_STAND = "sitstand";
		NPC_RANGED = 1;
		ATTACK_MOVERANGE = 512;
		ATTACK_RANGE = 1024;
		ATTACK_HITRANGE = 1024;
		DROP_GOLD = 1;
		AM_SKELETON = 1;
		CUSTOM_TURN_UNDEAD = 1;
		SKELE_ARROW_OFS = Vector3(10, 32, 68);
		DMG_ARROW = 5;
		DMG_SWIPE = 3;
		SWIPE_RANGE = 70;
		SWIPE_HITRANGE = 120;
		SKELE_ARROW_RANGE = 1024;
		SKELE_ARROW_SCRIPT = "proj_arrow_npc_dyn";
		SKELE_ARROW_SPEED = 800;
		ATTACK_HITCHANCE = 0.7;
		SKELE_START_LIVES = RandomInt(1, 4);
		C_SKELE_PUSH_STRENGTH = 200;
		SKELE_HEARING = 10;
		SKELE_COF_A = 0;
		SKELE_COF_B = 1;
		MIDX_SHOW_ARROW = 11;
		MIDX_HIDE_ARROW = 10;
		SOUND_STRETCH = "monsters/archer/stretch.wav";
		SOUND_SHOOT = "monsters/archer/bow.wav";
		SOUND_SWIPE = "zombie/claw_miss1.wav";
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		SOUND_DEATH = "zombie/zo_pain1.wav";
		SOUND_TURNED1 = "ambience/the_horror1.wav";
		SOUND_TURNED2 = "ambience/the_horror2.wav";
		SOUND_TURNED3 = "ambience/the_horror3.wav";
		SOUND_TURNED4 = "ambience/the_horror4.wav";
		SOUND_HOLY_STRIKE = "doors/aliendoor1.wav";
		SKELE_ARROW_KNOCKBACK = C_SKELE_ARROW_KNOCKBACK;
		SKELE_PUSH_STRENGTH = C_SKELE_PUSH_STRENGTH;
	}

	void OnSpawn() override
	{
		SetModel("monsters/skeleton_boss1.mdl");
		skeleton_attribs();
		skele_spawn();
		SetRoam(true);
		SetHearingSensitivity(SKELE_HEARING);
		SetBloodType("none");
		SetRace("undead");
		SKELE_MISS_COUNT = 0;
		SKELE_LIVES = SKELE_START_LIVES;
		SKELE_DEFAULT_ANIM_WALK = ANIM_WALK;
		SKELE_DEFAULT_ANIM_RUN = ANIM_RUN;
		SKELE_DEFAULT_ANIM_IDLE = ANIM_IDLE;
		DROP_GOLD_AMT = SKELE_GOLD;
		SKELE_BASE_ROAM = 1;
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		string SLEEPER_TYPE = FindEntityByName("skels_sleep");
		string SLEEPER_ID = GetEntityIndex(SLEEPER_TYPE);
		if ((IsEntityAlive(SLEEPER_ID)))
		{
			make_sleeper();
		}
		string SLEEPER_TYPE = FindEntityByName("skels_deep_sleep");
		string SLEEPER_ID = GetEntityIndex(SLEEPER_TYPE);
		if ((IsEntityAlive(SLEEPER_ID)))
		{
			make_deep_sleeper();
		}
	}

	void skeleton_attribs()
	{
		if (!(STONE_SKELETON))
		{
			SetDamageResistance("slash", 0.7);
			SetDamageResistance("pierce", 0.5);
			SetDamageResistance("blunt", 1.2);
			SetDamageResistance("fire", 1.25);
			SetDamageResistance("holy", 1.5);
			SetDamageResistance("cold", 0.1);
			SetDamageResistance("poison", 0.0);
		}
		else
		{
			SetDamageResistance("all", 0.5);
			SetDamageResistance("holy", 1.5);
			SetDamageResistance("poison", 0.0);
			SetDamageResistance("cold", 0.1);
		}
	}

	void npc_selectattack()
	{
		if (GetEntityRange(m_hAttackTarget) < SWIPE_RANGE)
		{
			ANIM_ATTACK = ANIM_SWIPE;
		}
		else
		{
			ANIM_ATTACK = ANIM_ARROW;
		}
	}

	void attack_1()
	{
		// PlayRandomSound from: SOUND_SWIPE
		array<string> sounds = {SOUND_SWIPE};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 5);
		DoDamage(m_hAttackTarget, SWIPE_HITRANGE, DMG_SWIPE, ATTACK_HITCHANCE, "slash");
		if (!(SKELE_PUSH_STRENGTH > 0)) return;
		if ((SKELE_PUNCH_NOPUSHIE)) return;
		AddVelocity(m_hAttackTarget, /* TODO: $relvel */ $relvel(0, SKELE_PUSH_STRENGTH, 110));
	}

	void frame_grab_arrow()
	{
		SetModelBody(1, MIDX_SHOW_ARROW);
	}

	void frame_draw_bow()
	{
		EmitSound(GetOwner(), 0, SOUND_STRETCH, 10);
	}

	void frame_shoot_bow()
	{
		EmitSound(GetOwner(), 2, SOUND_SHOOT, 10);
		SetModelBody(1, MIDX_HIDE_ARROW);
		SKELE_MISS_COUNT += 1;
		if (!(SKELE_ARROW_ARC))
		{
			string L_POS = GetEntityOrigin(GetOwner());
			L_POS += /* TODO: $relpos */ $relpos(GetEntityAngles(GetOwner()), SKELE_ARROW_OFS);
			TossProjectile(SKELE_ARROW_SCRIPT, L_POS, m_hAttackTarget, SKELE_ARROW_SPEED, DMG_ARROW, SKELE_COF_A, "none");
			CallExternal("ent_lastprojectile", "ext_lighten", 0, SKELE_ARROW_GLOW, SKELE_ARROW_GLOW_COLOR);
		}
		else
		{
			string TARG_ORG = GetEntityOrigin(m_hAttackTarget);
			if (SKELE_ARROW_AOE > 0)
			{
				string HALF_AOE = SKELE_ARROW_AOE;
				HALF_AOE /= 2;
				TARG_ORG += /* TODO: $relpos */ $relpos(Vector3(0, Random(0, 359.99), 0), Vector3(0, HALF_AOE, 0));
			}
			if (!(IsValidPlayer(TARG_ORG)))
			{
				TARG_ORG += "z";
			}
			float TARG_DIST = Distance(TARG_ORG, GetMonsterProperty("origin"));
			TARG_DIST /= 25;
			SetAngles("add_view.pitch");
			string L_POS = GetEntityOrigin(GetOwner());
			L_POS += /* TODO: $relpos */ $relpos(GetEntityAngles(GetOwner()), SKELE_ARROW_OFS);
			TossProjectile(SKELE_ARROW_SCRIPT, L_POS, "none", SKELE_ARROW_SPEED, DMG_ARROW, SKELE_COF_B, "none");
			float GRAV_ADJ = 0.4;
			CallExternal("ent_lastprojectile", "ext_lighten", GRAV_ADJ, SKELE_ARROW_GLOW, SKELE_ARROW_GLOW_COLOR);
		}
		if (SKELE_MISS_COUNT > 4)
		{
			if (!(AM_TURRET))
			{
				SKELE_MISS_COUNT = 2;
				PlayAnim("once", "break");
				chicken_run(1.5);
			}
			else
			{
				SKELE_COF_A += 1;
				SKELE_COF_B += 2;
			}
		}
	}

	void game_dodamage()
	{
		if ((IsEntityAlive(param2)))
		{
			if (GetRelationship(param2) == "enemy")
			{
			}
			SKELE_MISS_COUNT = 0;
			if ((AM_TURRET))
			{
			}
			SKELE_COF_A = 0;
			SKELE_COF_B = 1;
		}
	}

	void ext_arrow_hit()
	{
		string TARG_ALIVE = IsEntityAlive(param2);
		if (GetRelationship(param2) == "enemy")
		{
			if ((TARG_ALIVE))
			{
			}
			int HIT_ENEMY = 1;
		}
		if (SKELE_ARROW_KNOCKBACK > 0)
		{
			if (!(SKELE_ARROW_NOPUSHIE))
			{
			}
			if ((HIT_ENEMY))
			{
			}
			AddVelocity(param2, /* TODO: $relvel */ $relvel(0, SKELE_ARROW_KNOCKBACK, 110));
		}
		if (SKELE_ARROW_EFFECT != "SKELE_ARROW_EFFECT")
		{
			if ((HIT_ENEMY))
			{
			}
			if ((param1))
			{
			}
			if (!(SKELE_ARROW_EFFECT_HANDLED))
			{
				ApplyEffect(param2, SKELE_ARROW_EFFECT, SKELE_DOT_DUR, GetEntityIndex(GetOwner()), SKELE_DOT_DMG);
			}
			else
			{
				string OUT_TARG = param2;
				skele_handle_effect(OUT_TARG);
			}
		}
		if (SKELE_ARROW_AOE > 0)
		{
			string ARROW_POS = param3;
			if ((HIT_ENEMY))
			{
				string ARROW_POS = GetEntityOrigin(param2);
			}
			ARROW_POS = "z";
			skele_arrow_fx(ARROW_POS);
			SKELE_TARGET_LIST = FindEntitiesInSphere("enemy", SKELE_ARROW_AOE);
			if (SKELE_TARGET_LIST != "none")
			{
			}
			for (int i = 0; i < GetTokenCount(SKELE_TARGET_LIST, ";"); i++)
			{
				skele_affect_targets();
			}
		}
	}

	void skele_affect_targets()
	{
		string CUR_TARG = GetToken(SKELE_TARGET_LIST, i, ";");
		ApplyEffect(CUR_TARG, SKELE_ARROW_EFFECT, SKELE_DOT_DUR, GetEntityIndex(GetOwner()), SKELE_DOT_DMG);
		SKELE_MISS_COUNT = 0;
	}

	void set_turret()
	{
		SetMoveSpeed(0.0);
		BASE_MOVESPEED = 0.0;
		SetMoveAnim(ANIM_IDLE);
		SetRoam(false);
		SKELE_BASE_ROAM = 0;
		NO_STUCK_CHECKS = 1;
		ANIM_RUN = ANIM_IDLE;
		ANIM_WALK = ANIM_IDLE;
		SKELE_DEFAULT_ANIM_WALK = ANIM_IDLE;
		SKELE_DEFAULT_ANIM_RUN = ANIM_IDLE;
		AM_TURRET = 1;
		NPC_IS_TURRET = 1;
		ScheduleDelayedEvent(0.1, "set_turret2");
	}

	void set_turret2()
	{
		ANIM_RUN = ANIM_IDLE;
		ANIM_WALK = ANIM_IDLE;
		SetMoveAnim(ANIM_IDLE);
	}

	void set_no_fake_death()
	{
		SKELE_LIVES = 1;
	}

	void set_rebirths()
	{
		SKELE_LIVES = param1;
		SKELE_LIVES += 1;
	}

	void skeleton_wakeup_call()
	{
		skeleton_wake_up();
	}

	void make_sleeper()
	{
		SetHearingSensitivity(0);
		SetRoam(false);
		SetInvincible(true);
		SetMoveDest("none");
		npcatk_suspend_ai();
		NPC_PROXACT_TRIPPED = 0;
		NPC_PROXACT_IFSEEN = 0;
		NPC_PROX_ACTIVATE = 1;
		NPC_PROXACT_RANGE = 128;
		NPC_PROXACT_EVENT = "skeleton_wake_up";
		NPC_PROXACT_FOV = 0;
		PLAYING_DEAD = 1;
		if (!(STONE_SKELETON))
		{
			SetSolid("none");
			SetBBox(Vector3(0, 0, 0), Vector3(0, 0, 0));
			SetIdleAnim(ANIM_DEATH_IDLE);
			SetMoveAnim(ANIM_DEATH_IDLE);
			PlayAnim("critical", ANIM_DEATH_IDLE);
		}
		else
		{
			skele_stone_sleep();
		}
	}

	void make_sitter()
	{
		SetHearingSensitivity(0);
		SetRoam(false);
		SetMoveDest("none");
		NPC_PROXACT_TRIPPED = 0;
		NPC_PROXACT_IFSEEN = 0;
		NPC_PROX_ACTIVATE = 1;
		NPC_PROXACT_RANGE = 128;
		NPC_PROXACT_EVENT = "skeleton_sit_up";
		NPC_PROXACT_FOV = 1;
		NPC_PROXACT_CONE = 90;
		SetIdleAnim(ANIM_SIT_IDLE);
		SetMoveAnim(ANIM_SIT_IDLE);
		PlayAnim("critical", ANIM_SIT_IDLE);
		npcatk_suspend_ai();
	}

	void skeleton_sit_up()
	{
		NPC_PROXACT_TRIPPED = 1;
		PlayAnim("critical", ANIM_SIT_STAND);
		SetHearingSensitivity(SKELE_HEARING);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		ScheduleDelayedEvent(1.0, "npcatk_resume_ai");
		SetRoam(SKELE_BASE_ROAM);
		AS_ATTACKING = GetGameTime();
		if (!(IsEntityAlive(NPC_PROXACT_PLAYERID))) return;
		ScheduleDelayedEvent(1.1, "skele_target_disturber");
	}

	void skele_target_disturber()
	{
		if (!(IsEntityAlive(NPC_PROXACT_PLAYERID))) return;
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_RUN);
		npcatk_settarget(NPC_PROXACT_PLAYERID);
		NPC_PROXACT_PLAYERID = 0;
	}

	void skeleton_wake_up()
	{
		if (!(STONE_SKELETON))
		{
			SKELE_FIRST_RAISE = 1;
			skele_rebirth();
		}
		else
		{
			SetHearingSensitivity(SKELE_HEARING);
			ANIM_RUN = SKELE_DEFAULT_ANIM_RUN;
			ANIM_WALK = SKELE_DEFAULT_ANIM_WALK;
			ANIM_IDLE = SKELE_DEFAULT_ANIM_IDLE;
			SetMoveAnim(ANIM_IDLE);
			SetIdleAnim(ANIM_WALK);
			SetInvincible(false);
			PLAYING_DEAD = 0;
			if (BASE_FRAMERATE == "BASE_FRAMERATE")
			{
				SetAnimFrameRate(1.0);
			}
			else
			{
				SetAnimFrameRate(BASE_FRAMERATE);
			}
			SetRoam(SKELE_BASE_ROAM);
			npcatk_resume_ai();
			skele_refresh_name();
			LogDebug("Stone Skeleton Awaken GetEntityName(NPC_PROXACT_PLAYERID)");
			if ((IsEntityAlive(NPC_PROXACT_PLAYERID)))
			{
			}
			ScheduleDelayedEvent(1.1, "skele_target_disturber");
		}
	}

	void skele_hide_name()
	{
		SKELE_ORG_NAME = GetMonsterProperty("name.full");
		SetRace("none");
		SetName("");
	}

	void skele_refresh_name()
	{
		if (SKELE_ORG_NAME != "SKELE_ORG_NAME")
		{
			SetName(SKELE_ORG_NAME);
			SetRace("undead");
		}
	}

	void make_deep_sleeper()
	{
		if (!(STONE_SKELETON))
		{
			SetHearingSensitivity(0);
			SetRoam(false);
			PLAYING_DEAD = 1;
			SetSolid("none");
			SetBBox(Vector3(0, 0, 0), Vector3(0, 0, 0));
			SetMoveDest("none");
			SKELE_FIRST_RAISE = 1;
			SetIdleAnim(ANIM_DEATH_IDLE);
			SetMoveAnim(ANIM_DEATH_IDLE);
			PlayAnim("critical", ANIM_DEATH_IDLE);
			npcatk_suspend_ai();
		}
		else
		{
			skele_stone_sleep();
		}
		SetInvincible(true);
	}

	void skele_stone_sleep()
	{
		SetHearingSensitivity(0);
		PLAYING_DEAD = 1;
		skele_hide_name();
		ANIM_RUN = ANIM_IDLE;
		ANIM_WALK = ANIM_IDLE;
		SetMoveAnim(ANIM_IDLE);
		SetIdleAnim(ANIM_IDLE);
		SetAnimFrameRate(0);
		SetInvincible(true);
		SetRoam(false);
		npcatk_suspend_ai();
		PlayAnim("hold", ANIM_IDLE);
		SetMoveDest("none");
	}

	void turn_undead()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if ((PLAYING_DEAD)) return;
		SKELE_LIVES = 0;
		SKELE_STRUCK_BY_TURN_UNDEAD = 1;
		SKELE_TURN_UNDEAD_SOUND = 1;
		string DMG_HOLY = param1;
		string CASTER_ID = param2;
		string CASTER_FAITH = GetSkillLevel(CASTER_ID, "spellcasting.divination");
		XDoDamage(GetEntityIndex(GetOwner()), "direct", DMG_HOLY, 100, CASTER_ID, CASTER_ID, "spellcasting.divination", "holy");
		Effect("glow", GetOwner(), Vector3(255, 255, 0), 512, 1, 1);
		string PERCENT_HEALTH_LEFT = GetEntityHealth(GetOwner());
		PERCENT_HEALTH_LEFT /= GetEntityMaxHealth(GetOwner());
		PERCENT_HEALTH_LEFT *= 100;
		if (!(CASTER_FAITH > PERCENT_HEALTH_LEFT)) return;
		if ((IS_FLEEING)) return;
		string TURN_DURATION = GetSkillLevel(THE_EXCORCIST, "spellcasting.divination");
		if (TURN_DURATION < 5)
		{
			int TURN_DURATION = 5;
		}
		if (TURN_DURATION > 15)
		{
			int TURN_DURATION = 15;
		}
		// PlayRandomSound from: SOUND_TURNED1, SOUND_TURNED2, SOUND_TURNED3, SOUND_TURNED4
		array<string> sounds = {SOUND_TURNED1, SOUND_TURNED2, SOUND_TURNED3, SOUND_TURNED4};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		npcatk_flee(CASTER_ID, 1024, TURN_DURATION);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if ((SKELE_TURN_UNDEAD_SOUND))
		{
			SKELE_TURN_UNDEAD_SOUND = 0;
			// PlayRandomSound from: SOUND_HOLY_STRIKE
			array<string> sounds = {SOUND_HOLY_STRIKE};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		else
		{
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (SKELE_LIVES <= 1)
		{
			if ((SKELE_DROPS_CONTAINER))
			{
			}
			if (RandomInt(1, 100) <= SKELE_DROPS_CONTAINER_CHANCE)
			{
			}
			SpawnNPC(SKELE_CONTAINER_SCRIPT, /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: CONTAINER_PARAM1, CONTAINER_PARAM2, CONTAINER_PARAM3, CONTAINER_PARAM4
		}
		if ((SKELE_STRUCK_BY_TURN_UNDEAD)) return;
		if (!(SKELE_LIVES > 1)) return;
		SetRace("undead");
		SKELE_LIVES -= 1;
		PLAYING_DEAD = 1;
		SetHearingSensitivity(0);
		SetSolid("none");
		SetBBox(Vector3(0, 0, 0), Vector3(0, 0, 0));
		SetInvincible(true);
		SetMoveDest("none");
		ANIM_RUN = ANIM_DEATH_IDLE;
		ANIM_WALK = ANIM_DEATH_IDLE;
		ANIM_IDLE = ANIM_DEATH_IDLE;
		SetIdleAnim(ANIM_DEATH_IDLE);
		SetMoveAnim(ANIM_DEATH_IDLE);
		SetAlive(1);
		npcatk_suspend_ai();
		SetRoam(false);
		RandomInt(5, 15)("skele_rebirth_check");
	}

	void skele_rebirth_check()
	{
		SKELE_REBIRTH_SCAN = FindEntitiesInSphere("any", 96);
		if (SKELE_REBIRTH_SCAN != "none")
		{
			SKELE_CANT_GET_UP = 1;
			SKELE_REALLY_CANT_GET_UP = 0;
			for (int i = 0; i < GetTokenCount(MUMMY_REBIRTH_SCAN, ";"); i++)
			{
				skele_rebirth_scan_loop();
			}
			if ((MUMMY_REALLY_CANT_GET_UP))
			{
				SKELE_CANT_GET_UP = 1;
			}
		}
		if (SKELE_REBIRTH_SCAN == "none")
		{
			SKELE_CANT_GET_UP = 0;
		}
		if ((SKELE_CANT_GET_UP))
		{
			ScheduleDelayedEvent(1.0, "skele_rebirth_check");
		}
		else
		{
			skele_rebirth();
		}
	}

	void skele_rebirth_scan_loop()
	{
		string CUR_TARG = GetToken(SKELE_REBIRTH_SCAN, i, ";");
		if ((GetEntityProperty(CUR_TARG, "itemname")).findFirst("skeleton_archer") >= 0)
		{
			if ((GetEntityProperty(CUR_TARG, "scriptvar")))
			{
				if (GetGameTime() > G_SKELE_NEXT_REBIRTH)
				{
				}
				SetGlobalVar("G_SKELE_NEXT_REBIRTH", GetGameTime());
				G_SKELE_NEXT_REBIRTH += 5.0;
				SKELE_CANT_GET_UP = 0;
				LogDebug("can get up game.time vs. G_SKELE_NEXT_REBIRTH");
			}
			else
			{
				SKELE_CANT_GET_UP = 1;
				SKELE_REALLY_CANT_GET_UP = 1;
				LogDebug("can t get up - friend not playing dead");
			}
		}
		else
		{
			SKELE_CANT_GET_UP = 1;
			SKELE_REALLY_CANT_GET_UP = 1;
			LogDebug("can t get up - non-skelearcher nearby");
		}
	}

	void skele_rebirth()
	{
		SetSolid("box");
		SetHealth(GetEntityMaxHealth(GetOwner()));
		if (!(SKELE_FIRST_RAISE))
		{
			NPC_GIVE_EXP /= 2;
			SetSkillLevel(NPC_GIVE_EXP);
		}
		SKELE_FIRST_RAISE = 0;
		SetHearingSensitivity(SKELE_HEARING);
		PLAYING_DEAD = 0;
		ScheduleDelayedEvent(1.0, "skele_rebirth2");
	}

	void skele_rebirth2()
	{
		SetInvincible(false);
		ANIM_RUN = SKELE_DEFAULT_ANIM_RUN;
		ANIM_WALK = SKELE_DEFAULT_ANIM_WALK;
		ANIM_IDLE = SKELE_DEFAULT_ANIM_IDLE;
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		PlayAnim("critical", ANIM_REBIRTH);
		ScheduleDelayedEvent(1.0, "npcatk_resume_ai");
		ScheduleDelayedEvent(1.1, "skele_rebirth3");
	}

	void skele_rebirth3()
	{
		SetRoam(SKELE_BASE_ROAM);
		NPC_PREV_TARGET = "unset";
		skele_target_disturber();
	}

	void ext_setmodelbody()
	{
		SetModelBody(param1, param2);
	}

	void set_pushamt()
	{
		SKELE_ARROW_KNOCKBACK = param1;
		SKELE_PUSH_STRENGTH = param1;
		LogDebug("set_pushamt PARAM1 [ SKELE_ARROW_KNOCKBACK SKELE_PUSH_STRENGTH ]");
	}

	void set_np()
	{
		SKELE_ARROW_KNOCKBACK = -1;
		SKELE_PUSH_STRENGTH = -1;
		LogDebug("set_np SKELE_ARROW_KNOCKBACK SKELE_PUSH_STRENGTH");
		SKELE_ARROW_NOPUSHIE = 1;
		SKELE_PUNCH_NOPUSHIE = 1;
	}

	void dbg_kb()
	{
		LogDebug("set_np SKELE_ARROW_KNOCKBACK SKELE_PUSH_STRENGTH");
	}

}

}
