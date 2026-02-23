#pragma context server

#include "monsters/bear_base_giant.as"

namespace MS
{

class BearGodRandom : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_INTRO;
	string ANIM_RUN;
	string ANIM_WALK;
	int AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int BEAR_ISSTOMPATK;
	string BEAR_TYPE;
	int BG_LOOP_COUNT;
	string BG_LPLAYERS_INRANGE;
	int BG_PUSH_ATK;
	string BG_RANGE;
	int BG_STAND_DELAY;
	string FORWARDPUSH;
	int FOUND_TARGET;
	string INTRO_YAW;
	int IN_INTRO;
	int NPC_GIVE_EXP;
	int NPC_IS_BOSS;
	int NPC_MUST_SEE_TARGET;
	int NPC_OVERSIZED;
	string P_TARGET;
	string SIDEPUSH;
	int STOMP_DELAY;
	int SUSPEND_AI;
	string UPPUSH;

	BearGodRandom()
	{
		NPC_OVERSIZED = 1;
		const float NPC_BOSS_REGEN_RATE = 0.05;
		const float NPC_BOSS_RESTORATION = 0.25;
		const int NPC_BASE_EXP = 4000;
		NPC_IS_BOSS = 1;
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack";
		const int ATTACK_STOMPRANGE = 512;
		const float FREQ_STOMP = 20.0;
		const string FREQ_STAND = "$randf(15,25)";
		const string FREQ_BOLT = "$randf(10,20)";
		const string FREQ_TREE = "$randf(20,30)";
		const float DMG_STORM = 20.0;
		const float STORM_DUR = 60.0;
		const int STORM_RAD = 1024;
		const string SMASH_DAMAGE = "$rand(50,150)";
		const string ATTACK_NORMAL_DAMAGE = "$rand(40,80)";
		const string ATTACK_STANDING_DAMAGE = "$rand(40,58)";
		const int ATTACK_STOMPRANGE = 200;
		const int ATTACK_STOMPDMG = 50;
		const float ATTACK_HITCHANCE = 0.7;
		NPC_GIVE_EXP = 2000;
		const int GOLD_BAGS = 1;
		const int GOLD_BAGS_PPLAYER = 4;
		const int GOLD_PER_BAG = 50;
		const int GOLD_RADIUS = 200;
		const int GOLD_MAX_BAGS = 32;
		const string SOUND_ATTACK1 = "monsters/bear/giantbearattack.wav";
		const string SOUND_STRUCK4 = "monsters/bear/giantbearpain.wav";
		const string SOUND_STRUCK5 = "none";
		NPC_MUST_SEE_TARGET = 0;
		Precache("magic/boom.wav");
		Precache("weather/Storm_exclamation.wav");
		Precache("weather/lightning.wav");
		Precache("magic/eraticlightfail.wav");
		Precache("magic/lightning_strike_replica.wav");
		Precache("monsters/dewm_shrub.mdl");
		Precache("monsters/dewm_bush.mdl");
		Precache("monsters/dewm_tree.mdl");
		Precache("cactusgibs.mdl");
		Precache("debris/bustflesh1.wav");
		Precache("zombie/claw_miss1.wav");
		Precache("headcrab/hc_attack1.wav");
		Precache("weapons/bow/crossbow.wav");
		Precache("weapons/bow/stretch.wav");
		Precache("weapons/xbow_hitbod1.wav");
		Precache("weapons/xbow_hitbod2.wav");
	}

	void game_precache()
	{
		Precache("weather/sfx_weather_snow");
		Precache("weather/sfx_weather_fog_black");
		Precache("weather/sfx_weather_rain_storm");
		Precache("monsters/summon/uber_blizzard");
		Precache("monsters/summon/stun_burst");
		Precache("monsters/summon/shock_beam");
		Precache("monsters/summon/doom_plant");
	}

	void OnSpawn() override
	{
		SetHealth(6000);
		SetModel("monsters/bear_huge.mdl");
		SetWidth(200);
		SetHeight(96);
		SetDamageResistance("stun", 0.3);
		SetInvincible(true);
		SetIdleAnim("upattack");
		SetMoveAnim("upattack");
		ScheduleDelayedEvent(0.1, "select_bear_type");
		IN_INTRO = 1;
		ANIM_INTRO = "upattack";
		ScheduleDelayedEvent(0.1, "intro_loop");
		ScheduleDelayedEvent(3.0, "intro_down");
		ScheduleDelayedEvent(5.0, "end_intro");
		npcatk_suspend_ai();
		SetNoPush(true);
	}

	void select_bear_type()
	{
		npcatk_suspend_ai();
		INTRO_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		SetAngles("face");
		SetDamageResistance("dark", 0.5);
		if (!(OVERRIDE_BEAR))
		{
			BEAR_TYPE = RandomInt(1, 3);
		}
		if (BEAR_TYPE == 1)
		{
			SetName("Bear God of the Frozen Tundra");
			SetDamageResistance("cold", 0.0);
			SetDamageResistance("fire", 1.25);
			SetModelBody(0, 0);
			CallExternal("players", "ext_weather_change", "snow");
			ScheduleDelayedEvent(2.0, "make_uber_blizzard");
			UseTrigger("make_ice");
			SendInfoMsg("all", "The Bear God of the Frozen Tundra Has appeared...");
		}
		if (BEAR_TYPE == 2)
		{
			SetName("Bear God of the Thundering Plains");
			SetDamageResistance("lightning", 0.0);
			SetDamageResistance("poison", 1.25);
			SetModelBody(0, 1);
			CallExternal("players", "ext_weather_change", "rain_storm");
			ScheduleDelayedEvent(10.0, "make_storm_bolt");
			UseTrigger("make_plains");
			SendInfoMsg("all", "The Bear God of the Thundering Plains Has appeared...");
		}
		if (BEAR_TYPE == 3)
		{
			SetName("Bear God of the Black Forest");
			SetDamageResistance("poison", 0.0);
			SetDamageResistance("holy", 1.0);
			SetModelBody(0, 2);
			SetGlobalVar("G_WEATHER_LOCK", "fog_black");
			CallExternal("players", "ext_weather_change", G_WEATHER_LOCK);
			ScheduleDelayedEvent(10.0, "make_dewm_tree");
			UseTrigger("make_trees");
			SendInfoMsg("all", "The Bear God of the Black Forest Has appeared...");
		}
		SetInvincible(false);
	}

	void intro_loop()
	{
		if (!(IN_INTRO)) return;
		AS_ATTACKING = 20;
		SUSPEND_AI = 1;
		SetAngles("face");
		PlayAnim("once", ANIM_INTRO);
		SetIdleAnim(ANIM_INTRO);
		SetMoveAnim(ANIM_INTRO);
		ScheduleDelayedEvent(0.1, "intro_loop");
	}

	void intro_down()
	{
		AS_ATTACKING = 20;
		SetAngles("face");
		ANIM_INTRO = "attack";
	}

	void end_intro()
	{
		SetAngles("face");
		IN_INTRO = 0;
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		npcatk_resume_ai();
		string FIRST_DEST = GetMonsterProperty("origin");
		FIRST_TEST += /* TODO: $relpos */ $relpos(Vector3(0, INTRO_YAW, 0), Vector3(0, 1024, 0));
		SetMoveDest(FIRST_TEST);
	}

	void OnPostSpawn() override
	{
		SetAngles("face");
		ATTACK_RANGE = 250;
		ATTACK_HITRANGE = 275;
		ATTACK_MOVERANGE = 200;
	}

	void make_uber_blizzard()
	{
		if (!(GetMonsterProperty("isalive"))) return;
		SpawnNPC("monsters/summon/uber_blizzard", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), DMG_STORM, STORM_DUR, STORM_RAD, 0.3
		string REFRESH_BLIZ = STORM_DUR;
		REFRESH_BLIZ += 5;
		REFRESH_BLIZ("make_uber_blizzard");
	}

	void bear_stomp()
	{
		if ((STOMP_DELAY)) return;
		STOMP_DELAY = 1;
		FREQ_STOMP("bg_reset_stomp_delay");
		ScheduleDelayedEvent(0.5, "repulse_stomp");
	}

	void repulse_stomp()
	{
		SpawnNPC("monsters/summon/stun_burst", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 512, 0, SMASH_DAMAGE
	}

	void bg_reset_stomp_delay()
	{
		STOMP_DELAY = 0;
	}

	void bear_shake()
	{
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 380, 20, 1, 512);
		EmitSound(GetOwner(), SOUND_GETDOWN);
	}

	void bear_walkeffect()
	{
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 256, 10, 1, 256);
		// PlayRandomSound from: SOUND_UPSTEP1, SOUND_UPSTEP2
		array<string> sounds = {SOUND_UPSTEP1, SOUND_UPSTEP2};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void frame_attack1()
	{
		// PlayRandomSound from: BEAR_VOLUME, SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {BEAR_VOLUME, SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), "game.sound.weapon", sounds[RandomInt(0, sounds.length() - 1)], 10);
		BEAR_ISSTOMPATK = 0;
		if (!(GetEntityRange(HUNT_LASTTARGET) < ATTACK_HITRANGE)) return;
		DoDamage(m_hLastSeen, "direct", ATTACK_DAMAGE, ATTACK_HITCHANCE, "slash");
	}

	void npc_selectattack()
	{
		if ((BG_STAND_DELAY)) return;
		BG_STAND_DELAY = 1;
		FREQ_STAND("bg_reset_stand_delay");
		bear_standup();
	}

	void bg_reset_stand_delay()
	{
		BG_STAND_DELAY = 0;
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		int SHOULD_PUSH_ENTITY = 1;
		if ((BEAR_ISSTOMPATK))
		{
			if (!(IsOnGround(m_hLastStruckByMe)))
			{
				SHOULD_PUSH_ENTITY = 0;
				game.monster.canceldamage = 1;
			}
		}
		if (!(SHOULD_PUSH_ENTITY)) return;
		int FORWARDPUSH = 190;
		string SIDEPUSH = Random(-60, 0);
		int UPPUSH = 10;
		if ((BEAR_ISDEAD))
		{
			FORWARDPUSH = 100;
			SIDEPUSH = 0;
			UPPUSH = 200;
		}
		if (!(BG_PUSH_ATK)) return;
		AddVelocity(m_hLastStruckByMe, /* TODO: $relvel */ $relvel(SIDEPUSH, FORWARDPUSH, UPPUSH));
		BG_PUSH_ATK = 0;
	}

	void frame_attack1()
	{
		BG_PUSH_ATK = 1;
	}

	void bear_stomp()
	{
		BG_PUSH_ATK = 1;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetGlobalVar("G_WEATHER_LOCK", 0);
		if (StringToLower(GetMapName()) == "tundra")
		{
			if ("game.players.totalhp" < 2000)
			{
			}
			UseTrigger("mm_early_release");
		}
		if (StringToLower(GetMapName()) == "skycastle")
		{
			CallExternal("players", "ext_clear_valid_gauntlets");
			CallExternal("players", "ext_play_music", GetOwner(), "Nashalrath.mp3");
		}
		CallExternal("players", "ext_weather_change", "clear");
		CallExternal(GAME_MASTER, "gm_bear_god_death");
	}

	void make_storm_bolt()
	{
		FREQ_BOLT("make_storm_bolt");
		FOUND_TARGET = 0;
		pick_player_inrange(2048);
		if ((FOUND_TARGET))
		{
			make_storm_bolt2();
		}
	}

	void make_storm_bolt2()
	{
		string P_ORG = GetEntityOrigin(P_TARGET);
		P_ORG = "z";
		SpawnNPC("monsters/summon/shock_beam", P_ORG, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 128, 7.0, 40, Vector3(255, 255, 0), 2.0
	}

	void pick_player_inrange()
	{
		GetAllPlayers(BG_LPLAYERS);
		string N_TARGETS = GetTokenCount(BG_LPLAYERS, ";");
		BG_LOOP_COUNT = 0;
		BG_RANGE = param1;
		BG_LPLAYERS_INRANGE = "";
		for (int i = 0; i < N_TARGETS; i++)
		{
			filter_range_loop();
		}
		string N_TARGETS = GetTokenCount(BG_LPLAYERS_INRANGE, ";");
		string RND_TARGET = RandomInt(1, N_TARGETS);
		RND_TARGET -= 1;
		P_TARGET = GetToken(BG_LPLAYERS, RND_TARGET, ";");
		if ((IsEntityAlive(P_TARGET)))
		{
			FOUND_TARGET = 1;
		}
	}

	void filter_range_loop()
	{
		string CUR_PLAYER = GetToken(BG_LPLAYERS, BG_LOOP_COUNT, ";");
		BG_LOOP_COUNT += 1;
		if (GetEntityRange(CUR_PLAYER) <= BG_RANGE)
		{
			if (BG_LPLAYERS_INRANGE.length() > 0) BG_LPLAYERS_INRANGE += ";";
			BG_LPLAYERS_INRANGE += CUR_PLAYER;
		}
	}

	void make_dewm_tree()
	{
		FREQ_TREE("make_dewm_tree");
		if (!(N_TREES < 3)) return;
		FOUND_TARGET = 0;
		pick_player_inrange(2048);
		if (!(FOUND_TARGET)) return;
		string P_ORG = GetEntityOrigin(P_TARGET);
		SpawnNPC("monsters/summon/doom_plant", P_ORG, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 20
		N_TREES += 1;
	}

	void plant_died()
	{
		N_TREES -= 1;
	}

	void npc_monster_stuck()
	{
		if (!(STUCK_COUNT > 2)) return;
		CallExternal("all", "master_stuck");
	}

	void worldevent_time()
	{
		if (!(BEAR_TYPE == 3)) return;
		ScheduleDelayedEvent(0.1, "re_black");
	}

	void re_black()
	{
		CallExternal("all", "game_playercmd_setweather", "fog_black", 1, 1);
	}

}

}
