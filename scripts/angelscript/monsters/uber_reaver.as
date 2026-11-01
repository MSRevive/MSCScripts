#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class UberReaver : CGameScript
{
	string ANIM_ALERT;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_DEATH1;
	string ANIM_DEATH2;
	string ANIM_DEATH3;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_PROJECTILE;
	string ANIM_RUN;
	string ANIM_SEARCH;
	string ANIM_SLASH;
	string ANIM_SMASH;
	string ANIM_VICTORY;
	string ANIM_VICTORY1;
	string ANIM_VICTORY2;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int BEAM_DAMAGE;
	float BEAM_FREQ;
	int CAN_FLINCH;
	int CHANCE_FREEZE;
	int DID_WARCRY;
	float DMG_FROST;
	float DMG_SHOCK_BURST;
	float DMG_STORM;
	int DOSMASH_CHANCE;
	int DO_ICEBLAST;
	int DO_SMASH_DELAY;
	int FIRST_ATTACK;
	int FLINCH_CHANCE;
	int FLINCH_HEALTH;
	float FREEZE_DURATION;
	float FREQ_ICE_BLAST;
	float FREQ_SHOCK_BURST;
	float FREQ_SMASH;
	int HP_STORAGE;
	int IS_UNHOLY;
	string LIGHTNING_SPRITE;
	string LODAGOND_LOC;
	int MAX_PROJECTILE_AMMO;
	string MONSTER_MODEL;
	int MOVE_RANGE;
	int NEAR_DEATH_THRESHOLD;
	float NPC_BOSS_REGEN_RATE;
	float NPC_BOSS_RESTORATION;
	float NPC_DELAYING_UNSTUCK;
	int NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	int NPC_OVERSIZED;
	int ON_LODAGOND;
	int PROJECTILE_RANGE;
	string PUSH_VEL;
	int SEARCH_ANIM_DELAY;
	int SHOCK_CONE_RANGE;
	int SHOCK_DAMAGE;
	int SHOCK_DURATION;
	int SKELS_ON;
	int SLASH_DAMAGE;
	float SLASH_HITCHANCE;
	int SMASH_DAMAGE;
	float SMASH_HITCHANCE;
	int SMASH_HITRANGE;
	float SMASH_STUN_CHANCE;
	string SOUND_ATTACKHIT;
	string SOUND_ATTACKMISS;
	string SOUND_BEAMCHARGE;
	string SOUND_BEAMFIRE;
	string SOUND_DEATH;
	string SOUND_PAIN_NEAR_DEATH;
	string SOUND_PAIN_STRONG;
	string SOUND_PAIN_WEAK;
	string SOUND_RUN1;
	string SOUND_RUN2;
	string SOUND_RUN3;
	string SOUND_SEARCH1;
	string SOUND_SEARCH2;
	string SOUND_SEARCH3;
	string SOUND_SLASHHIT;
	string SOUND_SLASHMISS;
	string SOUND_SMASHHIT;
	string SOUND_SMASHMISS;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_WALK1;
	string SOUND_WALK2;
	string SOUND_WALK3;
	string SOUND_WALK4;
	string SOUND_WARCRY;
	int STARTED_SPELLS;
	float STORM_DUR;
	int STORM_RAD;
	int STRONG_THRESHOLD;
	int STUN_ATTACK;
	int SWING_ATTACK;
	int WEAK_THRESHOLD;

	UberReaver()
	{
		IS_UNHOLY = 1;
		if (StringToLower(GetMapName()) == "lodagond-1")
		{
			NPC_IS_BOSS = 1;
		}
		NPC_BOSS_REGEN_RATE = 0.1;
		NPC_BOSS_RESTORATION = 0.5;
		FREQ_ICE_BLAST = 30.0;
		FREQ_SHOCK_BURST = 45.0;
		FREQ_SMASH = 10.0;
		DMG_FROST = 60.0;
		DMG_SHOCK_BURST = 20.0;
		CHANCE_FREEZE = 2;
		DMG_STORM = 20.0;
		STORM_DUR = 60.0;
		STORM_RAD = 800;
		LODAGOND_LOC = Vector3(-1728, 2176, -576);
		FREEZE_DURATION = 15.0;
		SHOCK_CONE_RANGE = 1024;
		SOUND_WALK1 = "common/npc_step1.wav";
		SOUND_WALK2 = "common/npc_step2.wav";
		SOUND_WALK3 = "common/npc_step3.wav";
		SOUND_WALK4 = "common/npc_step4.wav";
		SOUND_RUN1 = "gonarch/gon_step1.wav";
		SOUND_RUN2 = "gonarch/gon_step2.wav";
		SOUND_RUN3 = "gonarch/gon_step3.wav";
		SOUND_DEATH = "gonarch/gon_die1.wav";
		SOUND_WARCRY = "gonarch/gon_alert1.wav";
		SOUND_STRUCK1 = "gonarch/gon_sack1.wav";
		SOUND_STRUCK2 = "gonarch/gon_sack2.wav";
		SOUND_PAIN_STRONG = "gonarch/gon_pain2.wav";
		SOUND_PAIN_WEAK = "gonarch/gon_pain4.wav";
		SOUND_PAIN_NEAR_DEATH = "gonarch/gon_pain5.wav";
		SOUND_SLASHHIT = "zombie/claw_strike1.wav";
		SOUND_SMASHHIT = "zombie/claw_strike2.wav";
		SOUND_SLASHMISS = "zombie/claw_miss1.wav";
		SOUND_SMASHMISS = "zombie/claw_miss2.wav";
		SOUND_BEAMCHARGE = "debris/beamstart2.wav";
		SOUND_BEAMFIRE = "debris/beamstart9.wav";
		SOUND_SEARCH1 = "gonarch/gon_childdie3.wav";
		SOUND_SEARCH2 = "gonarch/gon_childdie2.wav";
		SOUND_SEARCH3 = "gonarch/gon_childdie1.wav";
		SOUND_ATTACKHIT = "unset";
		SOUND_ATTACKMISS = "unset";
		Precache(SOUND_SLASHMISS);
		Precache(SOUND_SLASHHIT);
		Precache(SOUND_SMASHMISS);
		Precache(SOUND_SMASHHIT);
		Precache(SOUND_PAIN_STRONG);
		Precache(SOUND_PAIN_WEAK);
		Precache(SOUND_PAIN_NEAR_DEATH);
		Precache("magic/boom.wav");
		ATTACK_RANGE = 200;
		ATTACK_HITRANGE = 250;
		ATTACK_MOVERANGE = 150;
		MOVE_RANGE = 150;
		STRONG_THRESHOLD = 5000;
		WEAK_THRESHOLD = 2000;
		NEAR_DEATH_THRESHOLD = 1000;
		PROJECTILE_RANGE = 256;
		MAX_PROJECTILE_AMMO = 1;
		SLASH_DAMAGE = "$rand(50,100)";
		SMASH_DAMAGE = "$rand(100,250)";
		SLASH_HITCHANCE = 0.9;
		SMASH_HITCHANCE = 1.0;
		SMASH_HITRANGE = 200;
		SMASH_STUN_CHANCE = 0.5;
		BEAM_FREQ = 45.0;
		BEAM_DAMAGE = 200;
		SHOCK_DAMAGE = 100;
		SHOCK_DURATION = RandomInt(5, 10);
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_IDLE = "idle1";
		ANIM_SEARCH = "idle2";
		ANIM_FLINCH = "turnl";
		ANIM_SMASH = "mattack3";
		ANIM_SLASH = "mattack2";
		ANIM_PROJECTILE = "distanceattack";
		ANIM_ALERT = "distanceattack";
		ANIM_DEATH1 = "dieforward";
		ANIM_DEATH2 = "diesimple";
		ANIM_DEATH3 = "diesideways";
		ANIM_VICTORY1 = "victoryeat";
		ANIM_VICTORY2 = "victorysniff";
		ANIM_VICTORY = "victoryeat";
		ANIM_DEATH = "dieforward";
		ANIM_ATTACK = "mattack3";
		CAN_FLINCH = 1;
		FLINCH_HEALTH = 500;
		FLINCH_CHANCE = 30;
		DOSMASH_CHANCE = 20;
		LIGHTNING_SPRITE = "lgtning.spr";
		MONSTER_MODEL = "monsters/abominable_huge.mdl";
		Precache(LIGHTNING_SPRITE);
		Precache(SOUND_DEATH);
	}

	void OnSpawn() override
	{
		SetName("Maldora's Pet");
		SetHealth(9000);
		HP_STORAGE = 9000;
		SetRoam(true);
		SetDamageResistance("all", 0.7);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("fire", 0.2);
		SetDamageResistance("holy", 1.0);
		SetDamageResistance("stun", 0.25);
		SetWidth(200);
		SetHeight(96);
		NPC_GIVE_EXP = 2000;
		SetRace("demon");
		SetHearingSensitivity(3);
		SetModel(MONSTER_MODEL);
		SetMoveAnim(ANIM_WALK);
		NPC_OVERSIZED = 1;
		SetNoPush(true);
	}

	void OnPostSpawn() override
	{
		string L_MAP_NAME = StringToLower(GetMapName());
		if (!(L_MAP_NAME == "lodagond-1")) return;
		ON_LODAGOND = 1;
	}

	void npcatk_validatetarget()
	{
		if (!(IsValidPlayer(param1))) return;
		if ((DID_WARCRY)) return;
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
		DID_WARCRY = 1;
		FIRST_ATTACK = 1;
	}

	void my_target_died()
	{
		ice_reaver_beam_reload();
		SetHealth(HP_STORAGE);
		if ((false)) return;
		int RAND_VICT = RandomInt(1, 2);
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
		SWING_ATTACK = 1;
		int RANDOM_PUSH = RandomInt(100, 175);
		PUSH_VEL = /* TODO: $relvel */ $relvel(-100, RANDOM_PUSH, 120);
		SOUND_ATTACKHIT = SOUND_SLASHHIT;
		SOUND_ATTACKMISS = SOUND_SLASHMISS;
		STUN_ATTACK = 0;
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)) return;
		npcatk_dodamage(m_hAttackTarget, "direct", SLASH_DAMAGE, SLASH_HITCHANCE, GetEntityIndex(GetOwner()), "slash");
		if ((DO_SMASH_DELAY)) return;
		DO_SMASH_DELAY = 1;
		FREQ_SMASH("reset_do_smash_delay");
		ANIM_ATTACK = ANIM_SMASH;
	}

	void reset_do_smash_delay()
	{
		DO_SMASH_DELAY = 0;
	}

	void attack_mele2()
	{
		SWING_ATTACK = 1;
		SOUND_ATTACKHIT = SOUND_SMASHHIT;
		SOUND_ATTACKMISS = SOUND_SMASHMISS;
		int RANDOM_PUSH = RandomInt(200, 400);
		PUSH_VEL = /* TODO: $relvel */ $relvel(-100, RANDOM_PUSH, 120);
		if (GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)
		{
			npcatk_dodamage(m_hAttackTarget, "direct", SMASH_DAMAGE, SMASH_HITCHANCE, GetEntityIndex(GetOwner()), "slash");
		}
		STUN_ATTACK = 1;
		SpawnNPC("monsters/summon/stun_burst", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 512, 0, SMASH_DAMAGE
		ANIM_ATTACK = ANIM_SLASH;
	}

	void npcatk_search_init_advanced()
	{
		if ((SEARCH_ANIM_DELAY)) return;
		NPC_DELAYING_UNSTUCK = 10.0;
		PlayAnim("critical", ANIM_SEARCH);
		// PlayRandomSound from: SOUND_SEARCH1, SOUND_SEARCH2, SOUND_SEARCH3
		array<string> sounds = {SOUND_SEARCH1, SOUND_SEARCH2, SOUND_SEARCH3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		SEARCH_ANIM_DELAY = 1;
		ScheduleDelayedEvent(5.0, "reset_search_anim");
	}

	void reset_search_anim()
	{
		// TODO: setrvard SEARCH_ANIM_DELAY 0
	}

	void game_dodamage()
	{
		if (!(param1))
		{
			if ((SWING_ATTACK))
			{
			}
			if (SOUND_ATTACKMISS != "unset")
			{
				EmitSound(GetOwner(), 0, SOUND_ATTACKMISS, 10);
			}
		}
		if ((param1))
		{
			if ((SWING_ATTACK))
			{
			}
			if (SOUND_ATTACKHIT != "unset")
			{
				EmitSound(GetOwner(), 0, SOUND_ATTACKHIT, 10);
			}
			AddVelocity(m_hLastStruckByMe, PUSH_VEL);
			if (RandomInt(1, CHANCE_FREEZE) == 1)
			{
				ApplyEffect(param2, "effects/dot_cold", 5, GetEntityIndex(GetOwner()), DMG_FROST);
			}
		}
		if ((STUN_ATTACK))
		{
			STUN_ATTACK = 0;
			if (RandomInt(1, 100) > SMASH_STUN_CHANCE)
			{
				ApplyEffect(param2, "effects/debuff_stun", 10, GetEntityIndex(GetOwner()));
			}
		}
		SWING_ATTACK = 0;
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
		int RAND_DEATH = RandomInt(1, 3);
		if (RAND_DEATH == 1)
		{
			ANIM_DEATH = ANIM_DEATH1;
		}
		if (RAND_DEATH == 2)
		{
			ANIM_DEATH = ANIM_DEATH2;
		}
		if (RAND_DEATH == 3)
		{
			ANIM_DEATH = ANIM_DEATH3;
		}
		if ((SKELS_ON))
		{
			CallExternal("all", "ext_crystal_remove");
		}
		bm_gold_spew(50, 3, 100, 4, 30);
	}

	void game_reached_destination()
	{
		if (!(m_hAttackTarget == "unset")) return;
		if (!(NPC_LOST_TARGET == "unset")) return;
		if ((false)) return;
		int RAND_VICT = RandomInt(1, 2);
		if (RAND_VICT == 1)
		{
			ANIM_VICTORY = ANIM_VICTORY1;
		}
		if (RAND_VICT == 2)
		{
			ANIM_VICTORY = ANIM_VICTORY2;
		}
		PlayAnim("critical", ANIM_VICTORY);
	}

	void cycle_up()
	{
		if ((STARTED_SPELLS)) return;
		STARTED_SPELLS = 1;
		ScheduleDelayedEvent(0.5, "ice_storm");
		FREQ_ICE_BLAST("ice_blast");
		FREQ_SHOCK_BURST("do_shock_burst");
		toggle_skeles();
	}

	void ice_storm()
	{
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
		PlayAnim("critical", ANIM_PROJECTILE);
		string BLIZ_LOC = /* TODO: $relpos */ $relpos(0, 0, 0);
		if ((ON_LODAGOND))
		{
			string BLIZ_LOC = LODAGOND_LOC;
		}
		SpawnNPC("monsters/summon/uber_blizzard", BLIZ_LOC, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), DMG_STORM, STORM_DUR, STORM_RAD, 0.6
		string NEXT_STORM = STORM_DUR;
		NEXT_STORM += 5;
		NEXT_STORM("ice_storm");
	}

	void ice_blast()
	{
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
		PlayAnim("critical", ANIM_PROJECTILE);
		DO_ICEBLAST = 1;
		toggle_skeles();
		FREQ_ICE_BLAST("ice_blast");
	}

	void do_shock_burst()
	{
		FREQ_SHOCK_BURST("do_shock_burst");
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
		PlayAnim("critical", ANIM_PROJECTILE);
		SetIdleAnim(ANIM_PROJECTILE);
		SetMoveAnim(ANIM_PROJECTILE);
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 10;
		npcatk_faceattacker(m_hAttackTarget);
		npcatk_suspend_ai(1.0);
		ScheduleDelayedEvent(1.0, "do_shock_burst2");
	}

	void do_shock_burst2()
	{
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_RUN);
		EmitSound(GetOwner(), 0, SOUND_BEAMFIRE, 10);
		string BEAM_START = GetMonsterProperty("origin");
		string BEAM_END = BEAM_START;
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(GetMonsterProperty("angles"));
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(0, 2000, 0));
		BEAM_START += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(-64, 30, 64));
		Effect("beam", "point", LIGHTNING_SPRITE, 250, BEAM_START, BEAM_END, Vector3(254, 254, 254), 150, 50, 0.2);
		string BEAM_START = GetMonsterProperty("origin");
		BEAM_START += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(0, 30, 64));
		Effect("beam", "point", LIGHTNING_SPRITE, 250, BEAM_START, BEAM_END, Vector3(254, 254, 254), 150, 50, 0.2);
		string BEAM_START = GetMonsterProperty("origin");
		BEAM_START += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(64, 30, 64));
		Effect("beam", "point", LIGHTNING_SPRITE, 250, BEAM_START, BEAM_END, Vector3(254, 254, 254), 150, 50, 0.2);
		GetAllPlayers(PLAYER_LIST);
		for (int i = 0; i < GetTokenCount(PLAYER_LIST, ";"); i++)
		{
			shock_can_see();
		}
	}

	void shock_can_see()
	{
		string CUR_PLAYER = GetToken(PLAYER_LIST, i, ";");
		string CUR_ORG = GetEntityOrigin(CUR_PLAYER);
		if (!(GetEntityRange(CUR_PLAYER) < SHOCK_CONE_RANGE)) return;
		if (!(/* TODO: $within_cone */ $within_cone(CUR_ORG, GetMonsterProperty("origin"), GetMonsterProperty("angles"), 60))) return;
		string MON_CENT = GetMonsterProperty("origin");
		MON_CENT += "z";
		Effect("beam", "point", LIGHTNING_SPRITE, 250, MON_CENT, CUR_ORG, Vector3(254, 254, 254), 150, 50, 0.2);
		ApplyEffect(CUR_PLAYER, "effects/dot_lightning", SHOCK_DURATION, GetEntityIndex(GetOwner()), SHOCK_DAMAGE);
		Effect("screenfade", CUR_PLAYER, 3, 1, Vector3(255, 255, 255), 255, "fadein");
	}

	void toggle_skeles()
	{
		if (!(SKELS_ON))
		{
			summon_skeles();
		}
		if ((SKELS_ON))
		{
			unsummon_skeles();
		}
	}

	void unsummon_skeles()
	{
		SKELS_ON = 0;
		CallExternal("all", "ext_crystal_remove");
		ScheduleDelayedEvent(10.0, "summon_skeles");
	}

	void summon_skeles()
	{
		SKELS_ON = 1;
		EmitSound(GetOwner(), 0, SOUND_PAIN_STRONG, 10);
		UseTrigger("summon_skels");
	}

	void attack_ranged()
	{
		if (!(DO_ICEBLAST)) return;
		DO_ICEBLAST = 0;
		do_iceblast();
	}

	void do_iceblast()
	{
		string BALL_DEST = GetMonsterProperty("origin");
		Vector3 ANG_ADJ = Vector3(0, 0, 0);
		BALL_DEST += /* TODO: $relpos */ $relpos(ANG_ADJ, Vector3(0, 2000, 64));
		string START_OFS = GetMonsterProperty("origin");
		START_OFS += /* TODO: $relpos */ $relpos(ANG_ADJ, Vector3(0, 64, 32));
		SpawnNPC("monsters/summon/ice_blast", START_OFS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 10.0, BALL_DEST
		string BALL_DEST = GetMonsterProperty("origin");
		Vector3 ANG_ADJ = Vector3(0, 90, 0);
		BALL_DEST += /* TODO: $relpos */ $relpos(ANG_ADJ, Vector3(0, 2000, 64));
		string START_OFS = GetMonsterProperty("origin");
		START_OFS += /* TODO: $relpos */ $relpos(ANG_ADJ, Vector3(0, 64, 32));
		SpawnNPC("monsters/summon/ice_blast", START_OFS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 10.0, BALL_DEST
		string BALL_DEST = GetMonsterProperty("origin");
		Vector3 ANG_ADJ = Vector3(0, 180, 0);
		BALL_DEST += /* TODO: $relpos */ $relpos(ANG_ADJ, Vector3(0, 2000, 64));
		string START_OFS = GetMonsterProperty("origin");
		START_OFS += /* TODO: $relpos */ $relpos(ANG_ADJ, Vector3(0, 64, 32));
		SpawnNPC("monsters/summon/ice_blast", START_OFS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 10.0, BALL_DEST
		string BALL_DEST = GetMonsterProperty("origin");
		Vector3 ANG_ADJ = Vector3(0, 270, 0);
		BALL_DEST += /* TODO: $relpos */ $relpos(ANG_ADJ, Vector3(0, 2000, 64));
		string START_OFS = GetMonsterProperty("origin");
		START_OFS += /* TODO: $relpos */ $relpos(ANG_ADJ, Vector3(0, 64, 32));
		SpawnNPC("monsters/summon/ice_blast", START_OFS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 10.0, BALL_DEST
	}

	void OnDamage(int damage) override
	{
	}

}

}
