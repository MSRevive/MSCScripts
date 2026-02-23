#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class KChildreBossJelly : CGameScript
{
	int AM_CRAWLING;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string DID_WARCRY;
	int DOING_FADE;
	int DROP_GOLD;
	int FADE_DELAY;
	int FADE_STEP;
	string FADE_TARGET;
	string FLINCH_ANIM;
	int IS_UNHOLY;
	string I_HAS_ORIGIN;
	string MY_SUMMON;
	int NOT_FIRST_TIME;
	string NOVA_LIST;
	int NPC_GIVE_EXP;
	int NPC_IS_BOSS;
	int STARTED_CYCLES;
	string SUMMON_ORIGIN;
	int SWIPE_ATTACK;
	int WAS_STRUCK;

	KChildreBossJelly()
	{
		IS_UNHOLY = 1;
		NPC_IS_BOSS = 1;
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_IDLE = "idle1";
		ANIM_ATTACK = "ability1_alien";
		ANIM_DEATH = "death1_die";
		const string ANIM_IDLE_NORM = "idle1";
		const string ANIM_IDLE_CROUCH = "crouch_idle";
		const string ANIM_WALK_NORM = "walk";
		const string ANIM_RUN_NORM = "run";
		const string ANIM_CRAWL = "crawl";
		ANIM_FLINCH = "new_flinch";
		const string ANIM_JUMP = "jump";
		const string ANIM_DEATH_BACK1 = "death1_die";
		const string ANIM_DEATH_BACK2 = "back_die";
		const string ANIM_DEATH_FORWARD1 = "forward_die";
		const string ANIM_DEATH_CROUCH = "crouch_die";
		ATTACK_RANGE = 150;
		ATTACK_HITRANGE = 250;
		ATTACK_MOVERANGE = 130;
		ATTACK_HITCHANCE = 0.75;
		DROP_GOLD = 0;
		NPC_GIVE_EXP = 4000;
		const string DMG_SWIPE = Random(50, 70);
		const float DOT1_DMG = 10.0;
		const float DOT1_DURATION = 15.0;
		const float CLOUD_DMG = 20.0;
		const float CLOUD_DURATION = 10.0;
		const float NOVA_DMG = 100.0;
		const float NOVA_DOT_DMG = 10.0;
		const float NOVA_DOT_DURATION = 5.0;
		const Vector3 NOVA_COLOUR = Vector3(0, 254, 0);
		const int SUMMON_FREQ = 180;
		const int SUMMON_RATE_1 = 60;
		const int SUMMON_RATE_2 = 90;
		const int SUMMON_RATE_3 = 100;
		const string SUMMON_SCRIPT_1 = "monsters/k_larva_black";
		const string SUMMON_SCRIPT_2 = "monsters/horror";
		const string SUMMON_SCRIPT_3 = "monsters/k_childre_black";
		Precache(SUMMON_SCRIPT_1);
		Precache(SUMMON_SCRIPT_2);
		Precache(SUMMON_SCRIPT_3);
		const string SOUND_SPAWN = "magic/spawn.wav";
		const string SOUND_FLINCH = "monsters/gonome/gonome_pain3.wav";
		const string SOUND_WARCRY = "monsters/gonome/gonome_melee1.wav";
		const string SOUND_FADE = "monsters/gonome/gonome_melee2.wav";
		const string SOUND_UNFADE = "monsters/gonome/gonome_death3.wav";
		const string SOUND_STRUCK1 = "debris/flesh1.wav";
		const string SOUND_STRUCK2 = "debris/flesh2.wav";
		const string SOUND_PAIN1 = "monsters/gonome/gonome_jumpattack.wav";
		const string SOUND_PAIN2 = "monsters/gonome/gonome_melee1.wav";
		const string SOUND_SWING_MISS1 = "zombie/claw_miss1.wav";
		const string SOUND_SWING_MISS2 = "zombie/claw_miss2.wav";
		const string SOUND_SWING_HIT1 = "zombie/claw_strike1.wav";
		const string SOUND_SWING_HIT2 = "zombie/claw_strike2.wav";
		const string SOUND_STEP1 = "common/npc_step1.wav";
		const string SOUND_STEP2 = "common/npc_step2.wav";
		const string SOUND_IDLE1 = "monsters/gonome/gonome_idle1.wav";
		const string SOUND_IDLE2 = "monsters/gonome/gonome_idle2.wav";
		const string SOUND_IDLE3 = "monsters/gonome/gonome_idle3.wav";
		const string SOUND_PARRY = "weapons/axemetal1.wav";
		const string SOUND_DEATH = "bullchicken/bc_die2.wav";
		Precache(SOUND_DEATH);
		Precache("magic/spookie1.wav");
		const string MONSTER_MODEL = "monsters/k_childre_black.mdl";
		Precache(MONSTER_MODEL);
		NOT_FIRST_TIME = 0;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(FREQ_IDLE);
		if (m_hAttackTarget == "unset")
		{
		}
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnSpawn() override
	{
		SetName("Kruxus the Corrupting Shadow");
		SetHealth(5000);
		SetModel(MONSTER_MODEL);
		SetRace("demon");
		SetWidth(32);
		SetHeight(72);
		SetRoam(true);
		SetHearingSensitivity(4);
	}

	void OnPostSpawn() override
	{
		// TODO: UNCONVERTED: taledmg all 0.8
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("acid", 0.0);
		SetDamageResistance("holy", 0.5);
	}

	void npc_targetsighted()
	{
		if (!(false)) return;
		if (!(DID_WARCRY))
		{
			DID_WARCRY = 1;
			do_warcry();
		}
		if ((STARTED_CYCLES)) return;
		STARTED_CYCLES = 1;
		FREQ_FADE("fade_check");
		ScheduleDelayedEvent(1.0, "jump_check");
		SUMMON_FREQ("do_summon");
	}

	void my_target_died()
	{
		DID_WARCRY = 0;
		EmitSound(GetOwner(), 0, SOUND_IDLE1, 10);
		PlayAnim("critical", ANIM_FLINCH);
	}

	void do_summon()
	{
		if (I_HAS_ORIGIN != 1)
		{
			string ENT_ID = FindEntityByName("kruxus_summon_origin");
			SUMMON_ORIGIN = GetEntityOrigin(ENT_ID);
			I_HAS_ORIGIN = 1;
		}
		if (NOT_FIRST_TIME == 1)
		{
			if ((IsEntityAlive(MY_SUMMON)))
			{
				CallExternal(MY_SUMMON, "npc_fade_away");
			}
		}
		string THE_NUM = RandomInt(1, 100);
		if (THE_NUM >= SUMMON_RATE_1)
		{
			SpawnNPC(SUMMON_SCRIPT_1, /* TODO: $relpos */ $relpos(0, 48, 5), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
		}
		if (THE_NUM < SUMMON_RATE_1)
		{
			if (THE_NUM >= SUMMON_RATE_2)
			{
				SpawnNPC(SUMMON_SCRIPT_3, /* TODO: $relpos */ $relpos(0, 48, 5), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
			}
		}
		if (THE_NUM > SUMMON_RATE_2)
		{
			SpawnNPC(SUMMON_SCRIPT_3, /* TODO: $relpos */ $relpos(0, 48, 5), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
		}
		MY_SUMMON = m_hLastCreated;
		NOT_FIRST_TIME = 1;
	}

	void do_nova_part_1()
	{
		string MY_ORG = GetEntityOrigin(GetOwner());
		NOVA_LIST = FindEntitiesInSphere("enemy", 256);
		do_nova_FX();
		if (!(NOVA_LIST != "none")) return;
		for (int i = 0; i < GetTokenCount(NOVA_LIST, ";"); i++)
		{
			do_nova_part_2();
		}
	}

	void do_nova_part_2()
	{
		string CUR_TARG = GetToken(NOVA_LIST, i, ";");
		XDoDamage(CUR_TARG, "direct", NOVA_DMG, 1.0, GetOwner(), GetOwner(), "none", "poison");
		ApplyEffect(CUR_TARG, "effects/dot_poison", 5, GetOwner(), 10, 0, "none");
		string TARGET_ORG = GetEntityOrigin(CUR_TARG);
		string MY_ORG = GetEntityOrigin(GetOwner());
		string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARGET_ORG);
		EmitSound(GetOwner(), 0, "magic/spookie1.wav", 10);
		SetVelocity(param1, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 1000, 0)));
	}

	void do_nova_FX()
	{
		ClientEvent("new", "all", "monsters/k_childre_boss_cl", GetEntityIndex(GetOwner()));
	}

	void fade_check()
	{
		ScheduleDelayedEvent(1.0, "fade_check");
		if ((DOING_FADE)) return;
		if ((FADE_DELAY)) return;
		if (!(m_hAttackTarget != "unset")) return;
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)) return;
		FADE_DELAY = 1;
		FREQ_FADE("reset_fade_delay");
		do_fade();
		SpawnNPC("monsters/summon/npc_poison_cloud2", /* TODO: $relpos */ $relpos(0, 0, 5), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), CLOUD_DMG, CLOUD_DURATION, 2
	}

	void reset_fade_delay()
	{
		FADE_DELAY = 0;
	}

	void do_fade()
	{
		npcatk_flee(m_hAttackTarget, 2048, 3.0);
		FADE_TARGET = m_hAttackTarget;
		DOING_FADE = 1;
		npcatk_suspend_ai(2.0);
		SetMoveAnim(ANIM_RUN);
		WAS_STRUCK = 0;
		ScheduleDelayedEvent(0.1, "do_fade2");
		ScheduleDelayedEvent(1.0, "resume_attack");
	}

	void do_fade2()
	{
		EmitSound(GetOwner(), 0, SOUND_FADE, 10);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 800, 200));
		FADE_STEP = 255;
		fade_loop();
		SetDamageResistance("cold", 0.0);
	}

	void fade_loop()
	{
		FADE_STEP -= 20;
		if (FADE_STEP < 0)
		{
			SetProp(GetOwner(), "renderamt", 1);
		}
		if (!(FADE_STEP >= 0)) return;
		if (!(DOING_FADE)) return;
		ScheduleDelayedEvent(0.1, "fade_loop");
		SetProp(GetOwner(), "rendermode", 2);
		SetProp(GetOwner(), "renderamt", FADE_STEP);
	}

	void resume_attack()
	{
		npcatk_resume_ai();
		SetMoveAnim(ANIM_CRAWL);
		AM_CRAWLING = 1;
		if ((WAS_STRUCK)) return;
		chicken_run(2.0);
		ScheduleDelayedEvent(2.1, "invis_run2");
	}

	void invis_run2()
	{
		if ((WAS_STRUCK)) return;
		if (!(DOING_FADE)) return;
		chicken_run(2.0);
		ScheduleDelayedEvent(2.1, "flank_targ");
	}

	void flank_targ()
	{
		npcatk_flank(FADE_TARGET);
	}

	void do_warcry()
	{
		PlayAnim("critical", ANIM_IDLE_CROUCH);
		npcatk_faceattacker(m_hAttackTarget);
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
	}

	void game_dodamage()
	{
		if (!(SWIPE_ATTACK)) return;
		if ((param1))
		{
			// PlayRandomSound from: SOUND_SWING_HIT1, SOUND_SWING_HIT2
			array<string> sounds = {SOUND_SWING_HIT1, SOUND_SWING_HIT2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			if (RandomInt(1, 100) <= 60)
			{
			}
			ApplyEffect(param2, "effects/dot_poison", DOT1_DURATION, GetEntityIndex(GetOwner()), DOT1_DMG);
		}
		if (!(param1))
		{
			// PlayRandomSound from: SOUND_SWING_MISS1, SOUND_SWING_MISS2
			array<string> sounds = {SOUND_SWING_MISS1, SOUND_SWING_MISS2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		SWIPE_ATTACK = 0;
	}

	void OnParry(CBaseEntity@ attacker) override
	{
		EmitSound(GetOwner(), 0, SOUND_PARRY, 10);
	}

	void become_visible()
	{
		SetDamageResistance("cold", 1.25);
		EmitSound(GetOwner(), 0, SOUND_UNFADE, 10);
		DOING_FADE = 0;
		SetProp(GetOwner(), "rendermode", 0);
		SetProp(GetOwner(), "renderamt", 255);
	}

	void OnFlinch()
	{
		string RND_FLINCH = RandomInt(1, 2);
		if (RND_FLINCH == 1)
		{
			FLINCH_ANIM = ANIM_FLINCH1;
		}
		if (RND_FLINCH == 2)
		{
			FLINCH_ANIM = ANIM_FLINCH2;
		}
		EmitSound(GetOwner(), 0, SOUND_FLINCH, 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetProp(GetOwner(), "skin", 2);
		if ((DOING_FADE))
		{
			DOING_FADE = 0;
			CallExternal(GAME_MASTER, "gm_fade_in", GetEntityIndex(GetOwner()));
		}
		if (GetEntityRange(m_hLastStruck) > 256)
		{
			ANIM_DEATH = ANIM_DEATH_FORWARD1;
		}
		if (GetEntityRange(m_hLastStruck) <= 256)
		{
			string RND_DEATH = RandomInt(1, 2);
			if (RND_DEATH == 1)
			{
				ANIM_DEATH = ANIM_DEATH_BACK1;
			}
			if (RND_DEATH == 2)
			{
				ANIM_DEATH = ANIM_DEATH_BACK2;
			}
		}
		if ((AM_CRAWLING))
		{
			ANIM_DEATH = ANIM_DEATH_CROUCH;
		}
		if (!(RandomInt(1, 8) < "game.playersnb")) return;
		if (!(StringToLower(GetMapName()) == "kfortress")) return;
		string NK_START_POS = GetMonsterProperty("origin");
		string NK_START_GROUND_Z = /* TODO: $get_ground_height */ $get_ground_height(NK_START_POS);
		NK_START_POS = "z";
		KK_START_POS += "z";
		ClientEvent("new", "all", "kfortress/nh_appear_cl", NK_START_POS);
		CallExternal(GAME_MASTER, "gm_createitem", 15.0, "smallarms_nh", START_POS, 1);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		EmitSound(GetOwner(), 0, SOUND_STRUCK1, 8);
		if (RandomInt(1, 20) > 14)
		{
			do_nova_part_1();
		}
		if (!(AM_CRAWLING)) return;
		if (!(DOING_FADE)) return;
		SetMoveAnim(ANIM_RUN);
		AM_CRAWLING = 0;
		WAS_STRUCK = 1;
		chicken_run(1.5);
	}

	void jump_check()
	{
		FREQ_JUMP("jump_check");
		if (!(m_hAttackTarget != "unset")) return;
		string TARG_Z = GetEntityProperty(m_hAttackTarget, "origin.z");
		string MY_Z = (GetMonsterProperty("origin")).z;
		string Z_DIFF = TARG_Z;
		Z_DIFF -= MY_Z;
		LogDebug("temp z_targ TARG_Z z_me MY_Z z_diff Z_DIFF");
		if (!(Z_DIFF > ATTACK_RANGE)) return;
		npcatk_faceattacker(m_hAttackTarget);
		ScheduleDelayedEvent(0.1, "do_jump");
		EmitSound(GetOwner(), 0, SOUND_FADE, 10);
	}

	void do_jump()
	{
		SetMoveAnim(ANIM_JUMP);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, -200, 800));
		ScheduleDelayedEvent(0.5, "push_forward");
		ScheduleDelayedEvent(1.0, "jump_done");
	}

	void push_forward()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 400, 100));
	}

	void jump_done()
	{
		SetMoveAnim(ANIM_RUN);
	}

	void walk_step()
	{
		EmitSound(GetOwner(), 0, SOUND_STEP1, 4);
	}

	void run_step()
	{
		EmitSound(GetOwner(), 0, SOUND_STEP1, 10);
	}

	void attack_strike()
	{
		if ((DOING_FADE))
		{
			if (!(POISON_NOVA))
			{
			}
			become_visible("attack_strike");
		}
		SetMoveAnim(ANIM_RUN);
		AM_CRAWLING = 0;
		SWIPE_ATTACK = 1;
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SWIPE, ATTACK_HITCHANCE, "slash");
	}

}

}
