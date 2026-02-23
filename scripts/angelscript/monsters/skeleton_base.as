#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class SkeletonBase : CGameScript
{
	int AM_SKELETON;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RESPAWN_DEADIDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string ATTACK_HITRANGE;
	string ATTACK_RANGE;
	string DEEP_SLEEPER;
	int I_AM_TURNABLE;
	string MOVE_RANGE;
	string MY_NAME;
	int NO_STUCK_CHECKS;
	string NPC_PREV_TARGET;
	int PLAYING_DEAD;
	int SET_GREEK;
	int SKELE_TEMP_DEATH;
	int SKELE_TURNED;
	int SKEL_RESPAWN_TIMES;
	string SKEL_SLAYER;
	string SK_BASE_ANIM_IDLE;
	string SK_BASE_ANIM_RUN;
	string SK_BASE_ANIM_WALK;
	string SLEEPER;
	int STRUCK_HOLY;

	SkeletonBase()
	{
		ANIM_RESPAWN_DEADIDLE = "dead_on_stomach";
		ANIM_IDLE = "idle1";
		ANIM_ATTACK = "attack1";
		ANIM_DEATH = "dieheadshot";
		const string ANIM_DEATH_FAKE = "diesimple";
		const string ANIM_GETUP = "getup";
		const string SKEL_MODEL = "monsters/skeleton.mdl";
		const int SKEL_WIDTH = 32;
		const int SKEL_HEIGHT = 80;
		const int SKEL_MOVE_RANGE = 32;
		const int SKEL_ATTACK_RANGE = 64;
		const int SKEL_ATTACK_HITRANGE = 127;
		AM_SKELETON = 1;
		const int NPC_HANDLES_SUMMON_CIRCLES = 1;
		I_AM_TURNABLE = 1;
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const string SOUND_STRUCK4 = "zombie/zo_pain2.wav";
		const string SOUND_STRUCK5 = "zombie/zo_pain2.wav";
		const string SOUND_ATTACK1 = "zombie/claw_miss1.wav";
		const string SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		const string SOUND_DEATH = "zombie/zo_pain1.wav";
		const string SOUND_TURNED1 = "ambience/the_horror1.wav";
		const string SOUND_TURNED2 = "ambience/the_horror2.wav";
		const string SOUND_TURNED3 = "ambience/the_horror3.wav";
		const string SOUND_TURNED4 = "ambience/the_horror4.wav";
		const string SOUND_HOLY_STRIKE = "doors/aliendoor1.wav";
		Precache(SOUND_DEATH);
		Precache(SOUND_TURNED1);
		Precache(SOUND_TURNED2);
		Precache(SOUND_TURNED3);
		Precache(SOUND_TURNED4);
		Precache(SOUND_HOLY_STRIKE);
	}

	void OnSpawn() override
	{
		if (ANIM_WALK == "ANIM_WALK")
		{
			ANIM_WALK = "walk";
		}
		if (ANIM_RUN == "ANIM_RUN")
		{
			ANIM_RUN = "walk";
		}
		SetModel(SKEL_MODEL);
		SetBloodType("none");
		skel_get_sleeper_props();
		if (!(DEEP_SLEEPER))
		{
			SetHearingSensitivity(4);
		}
		skeleton_spawn();
		SetHealth(SKEL_HP);
		SetWidth(SKEL_WIDTH);
		SetHeight(SKEL_HEIGHT);
		MOVE_RANGE = SKEL_MOVE_RANGE;
		ATTACK_RANGE = SKEL_ATTACK_RANGE;
		ATTACK_HITRANGE = SKEL_ATTACK_HITRANGE;
		SetRoam(true);
		STRUCK_HOLY = 0;
		if ((SLEEPER))
		{
			make_sleeper();
			if (!(DEEP_SLEEPER))
			{
				SetHearingSensitivity(10);
			}
		}
		else
		{
			SetRace("undead");
			SetMoveAnim(ANIM_WALK);
			skeleton_attribs();
		}
		skel_setup_body();
	}

	void OnPostSpawn() override
	{
		SK_BASE_ANIM_RUN = ANIM_RUN;
		SK_BASE_ANIM_WALK = ANIM_WALK;
		SK_BASE_ANIM_IDLE = ANIM_IDLE;
	}

	void go_greek()
	{
		SetModelBody(0, 10);
		SET_GREEK = 1;
	}

	void skel_get_sleeper_props()
	{
		string SLEEPER_ID = FindEntityByName("skels_sleep");
		if ((IsEntityAlive(SLEEPER_ID)))
		{
			SLEEPER = 1;
		}
		string SLEEPER_TYPE_ID = FindEntityByName("skels_deep_sleep");
		if ((IsEntityAlive(SLEEPER_TYPE_ID)))
		{
			SLEEPER = 1;
			DEEP_SLEEPER = 1;
		}
	}

	void skeleton_attribs()
	{
		if ((SET_GREEK))
		{
			SetModelBody(0, 10);
		}
		SetDamageResistance("poison", 0.0);
		if (!(STONE_SKELETON))
		{
			SetDamageResistance("slash", ".7");
			SetDamageResistance("pierce", ".5");
			SetDamageResistance("blunt", 1.2);
			SetDamageResistance("fire", 1.5);
			SetDamageResistance("holy", 3.0);
			SetDamageResistance("cold", 0.25);
		}
		if ((STONE_SKELETON))
		{
			SetDamageResistance("holy", 2.0);
			SetDamageResistance("cold", 0.25);
		}
	}

	void make_deep_sleeper()
	{
		SLEEPER = 1;
		DEEP_SLEEPER = 1;
		SetAnimFrameRate(0.0);
		ScheduleDelayedEvent(0.2, "hide_name");
		SetRoam(false);
		PLAYING_DEAD = 1;
		if (!(STONE_SKELETON))
		{
			SetMoveAnim(ANIM_RESPAWN_DEADIDLE);
			SetIdleAnim(ANIM_RESPAWN_DEADIDLE);
		}
		if ((STONE_SKELETON))
		{
			SetMoveAnim(ANIM_IDLE);
			SetIdleAnim(ANIM_IDLE);
		}
		SetInvincible(true);
		SetHearingSensitivity(0);
		npcatk_suspend_ai();
		NO_STUCK_CHECKS = 1;
		if (!(DEEP_SLEEPER))
		{
			SetHearingSensitivity(10);
		}
		SLEEPER = 1;
		DEEP_SLEEPER = 1;
		SetAnimFrameRate(0.0);
		ScheduleDelayedEvent(0.2, "hide_name");
		SetRoam(false);
		PLAYING_DEAD = 1;
		if (!(STONE_SKELETON))
		{
			SetMoveAnim(ANIM_RESPAWN_DEADIDLE);
			SetIdleAnim(ANIM_RESPAWN_DEADIDLE);
		}
		if ((STONE_SKELETON))
		{
			SetMoveAnim(ANIM_IDLE);
			SetIdleAnim(ANIM_IDLE);
		}
		SetInvincible(true);
		SetHearingSensitivity(0);
		npcatk_suspend_ai();
		NO_STUCK_CHECKS = 1;
		if (!(DEEP_SLEEPER))
		{
			SetHearingSensitivity(10);
		}
	}

	void set_summon_circle2()
	{
		if (ANIM_RUN == "run")
		{
			PlayAnim("critical", "sitstand");
		}
		else
		{
			PlayAnim("critical", "getup");
		}
	}

	void skel_setup_body()
	{
		MY_NAME = GetEntityName(GetOwner());
		string SKEL_NAME = "Skeleton Warrior";
		if (MY_NAME == SKEL_NAME)
		{
			SetModelBody(0, 0);
			SetModelBody(1, 0);
		}
		string SKEL_NAME = "Walking Ashes";
		if (MY_NAME == SKEL_NAME)
		{
			SetModelBody(0, 6);
			SetModelBody(1, 0);
		}
		string SKEL_NAME = "Fragile Knight";
		if (MY_NAME == SKEL_NAME)
		{
			SetModelBody(0, 5);
			SetModelBody(1, 4);
		}
		string SKEL_NAME = "Ghastly Knight";
		if (MY_NAME == SKEL_NAME)
		{
			SetModelBody(0, 3);
			SetModelBody(1, 4);
		}
		string SKEL_NAME = "Hungry Skeleton";
		if (MY_NAME == SKEL_NAME)
		{
			SetModelBody(0, 0);
			SetModelBody(1, 1);
		}
		string SKEL_NAME = "Enraged Skeleton";
		if (MY_NAME == SKEL_NAME)
		{
			SetModelBody(0, 6);
			SetModelBody(1, 2);
		}
		string SKEL_NAME = "Awakened Guardian";
		if (MY_NAME == SKEL_NAME)
		{
			SetModelBody(0, 3);
			SetModelBody(1, 3);
		}
		string SKEL_NAME = "Living Dead";
		if (MY_NAME == SKEL_NAME)
		{
			SetModelBody(0, 1);
			SetModelBody(1, 0);
		}
		string SKEL_NAME = "Fallen Knight";
		if (MY_NAME == SKEL_NAME)
		{
			SetModelBody(0, 4);
			SetModelBody(1, 4);
		}
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if (!(SLEEPER)) return;
		if ((DEEP_SLEEPER)) return;
		if (!(IsValidPlayer("ent_lastheard"))) return;
		if (!(GetEntityRange("ent_lastheard") < 128)) return;
		skeleton_wakeup_call();
		if (!(SLEEPER)) return;
		if ((DEEP_SLEEPER)) return;
		if (!(IsValidPlayer("ent_lastheard"))) return;
		if (!(GetEntityRange("ent_lastheard") < 128)) return;
		skeleton_wakeup_call();
	}

	void skeleton_wakeup_call()
	{
		if (!(SLEEPER)) return;
		SetName(MY_NAME);
		SetRace("undead");
		float AWAKE_DELAY = 1.5;
		if ((STONE_SKELETON))
		{
			SetMoveAnim(ANIM_WALK);
			SetIdleAnim(ANIM_IDLE);
			animate_stone();
			float AWAKE_DELAY = 0.1;
		}
		if (BASE_FRAMERATE == "BASE_FRAMERATE")
		{
			SetAnimFrameRate(1.0);
		}
		if (BASE_FRAMERATE != "BASE_FRAMERATE")
		{
			SetAnimFrameRate(BASE_FRAMERATE);
		}
		if (!(STONE_SKELETON))
		{
			SetMoveAnim(ANIM_WALK);
			SetIdleAnim(ANIM_IDLE);
			PlayAnim("once", "getup");
		}
		AWAKE_DELAY("skeleton_awake");
	}

	void skeleton_awake()
	{
		SetInvincible(false);
		SetRoam(true);
		ScheduleDelayedEvent(0.1, "skeleton_attribs");
		SLEEPER = 0;
		DEEP_SLEEPER = 0;
		PLAYING_DEAD = 0;
		SetHearingSensitivity(10);
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		NO_STUCK_CHECKS = 0;
		npcatk_resume_ai();
	}

	void make_sleeper()
	{
		SLEEPER = 1;
		SetAnimFrameRate(0.0);
		ScheduleDelayedEvent(0.2, "hide_name");
		SetRoam(false);
		PLAYING_DEAD = 1;
		if (!(STONE_SKELETON))
		{
			SetMoveAnim(ANIM_RESPAWN_DEADIDLE);
			SetIdleAnim(ANIM_RESPAWN_DEADIDLE);
		}
		if ((STONE_SKELETON))
		{
			SetMoveAnim(ANIM_IDLE);
			SetIdleAnim(ANIM_IDLE);
		}
		SetInvincible(true);
		SetHearingSensitivity(0);
		npcatk_suspend_ai();
		NO_STUCK_CHECKS = 1;
		if (!(DEEP_SLEEPER))
		{
			SetHearingSensitivity(10);
		}
	}

	void turn_undead()
	{
		if (!(true)) return;
		SKELE_TURNED = 1;
		STRUCK_HOLY = 1;
		SKEL_RESPAWN_TIMES = 99;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!(true)) return;
		if ((PLAYING_DEAD)) return;
		if ((SKELE_TURNED))
		{
			int NO_REBIRTH = 1;
			CallExternal(GAME_MASTER, "gm_fade", GetEntityIndex(GetOwner()));
		}
		string RND_DEATH = RandomInt(1, 4);
		if (RND_DEATH == 1)
		{
			ANIM_DEATH = "dieheadshot2";
		}
		if (RND_DEATH == 2)
		{
			ANIM_DEATH = "diesimple";
		}
		if (RND_DEATH == 3)
		{
			ANIM_DEATH = "diebackward";
		}
		if (RND_DEATH == 4)
		{
			ANIM_DEATH = "dieforward";
		}
		if ((NO_REBIRTH)) return;
		if (!(RandomInt(1, 100) <= SKEL_RESPAWN_CHANCE)) return;
		if (!(SKEL_RESPAWN_TIMES < SKEL_RESPAWN_LIVES)) return;
		SKEL_RESPAWN_TIMES += 1;
		SKEL_SLAYER = GetEntityIndex(m_hLastStruck);
		ANIM_DEATH = ANIM_DEATH_FAKE;
		skel_fake_death();
	}

	void skel_fake_death()
	{
		SetAlive(1);
		SetSolid("box");
		SetMoveDest("none");
		SetInvincible(true);
		if (ANIM_RUN == ANIM_RESPAWN_DEADIDLE)
		{
			ANIM_RUN = SK_BASE_ANIM_RUN;
		}
		if (ANIM_WALK == ANIM_RESPAWN_DEADIDLE)
		{
			ANIM_WALK = SK_BASE_ANIM_WALK;
		}
		if (ANIM_IDLE == ANIM_RESPAWN_DEADIDLE)
		{
			ANIM_IDLE = SK_BASE_ANIM_IDLE;
		}
		npcatk_suspend_ai();
		npcatk_suspend_movement(ANIM_RESPAWN_DEADIDLE);
		NO_STUCK_CHECKS = 1;
		PLAYING_DEAD = 1;
		string L_REBIRTH_TIME = RandomInt(3.0, 5.0);
		string L_GLOW_TIME = /* TODO: $math(add) */ L_REBIRTH_TIME;
		Effect("glow", GetOwner(), Vector3(0, 0, 0), 72, L_GLOW_TIME, L_GLOW_TIME);
		L_REBIRTH_TIME("skel_rebirth");
	}

	void skel_rebirth()
	{
		ScheduleDelayedEvent(1.0, "skel_rebirth2");
		SetHealth();
		SetMaxHealth(* TODO: $math(divide) *);
		NPC_GIVE_EXP /= 2;
		SetSkillLevel(NPC_GIVE_EXP);
		SKELE_TEMP_DEATH = 0;
	}

	void skel_rebirth2()
	{
		SetInvincible(false);
		PlayAnim("critical", ANIM_GETUP);
		PLAYING_DEAD = 0;
		ScheduleDelayedEvent(1.0, "npcatk_resume_movement");
		ScheduleDelayedEvent(1.0, "npcatk_resume_ai");
		ScheduleDelayedEvent(1.1, "skel_rebirth3");
	}

	void skel_rebirth3()
	{
		PlayAnim("once", "break");
		SetMoveAnim(ANIM_RUN);
		NPC_PREV_TARGET = "unset";
		npcatk_settarget(SKEL_SLAYER);
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		if (!(STRUCK_HOLY))
		{
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK4, SOUND_STRUCK5
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK4, SOUND_STRUCK5};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if ((STRUCK_HOLY))
		{
			// PlayRandomSound from: SOUND_HOLY_STRIKE
			array<string> sounds = {SOUND_HOLY_STRIKE};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		STRUCK_HOLY = 0;
	}

	void attack_1()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 5);
		XDoDamage(HUNT_LASTTARGET, ATTACK_HITRANGE, Random(ATTACK_DAMAGE_LOW, ATTACK_DAMAGE_HIGH), ATTACK_HITCHANCE, GetOwner(), GetOwner(), "none", "slash", "dmgevent:skele_swing");
	}

}

}
