#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class FireReaverMini : CGameScript
{
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
	int CAN_FLINCH;
	int DID_WARCRY;
	int DMG_VOLCANO;
	int DMG_VOLCANO_DOT;
	int FIRST_ATTACK;
	int FLINCH_CHANCE;
	int FLINCH_HEALTH;
	string HP_STORAGE;
	int MOVE_RANGE;
	string NEXT_FIRE_BURST;
	float NPC_DELAYING_UNSTUCK;
	int NPC_GIVE_EXP;
	int PUSH_ATTACK;
	string PUSH_VEL;
	int SEARCH_ANIM_DELAY;
	int SMASH_DELAY;
	string SOUND_ATTACKHIT;
	string SOUND_ATTACKMISS;
	int SUSPEND_AI;
	int VOLCANO_ON;

	FireReaverMini()
	{
		const float DMG_BURST = 30.0;
		const float DOT_BURN = 10.0;
		const string FREQ_FIRE_BURST = Random(10.0, 20.0);
		NPC_GIVE_EXP = 250;
		const int ROCK_START_HEIGHT = 96;
		DMG_VOLCANO = 200;
		DMG_VOLCANO_DOT = 1;
		const int DMG_VOLCANO_DART = 25;
		const float FREQ_VOLC_SOUND = 7.0;
		const float FREQ_VOLCANO = 0.25;
		const float FREQ_SMASH = 10.0;
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
		ATTACK_RANGE = 125;
		ATTACK_HITRANGE = 150;
		ATTACK_MOVERANGE = 50;
		MOVE_RANGE = 50;
		const int STRONG_THRESHOLD = 2500;
		const int WEAK_THRESHOLD = 2000;
		const int NEAR_DEATH_THRESHOLD = 750;
		const string SLASH_DAMAGE = "$rand(100,200)";
		const int SMASH_DAMAGE = 500;
		const float SLASH_HITCHANCE = 0.9;
		const float FREQ_MISSILE = 20.0;
		const int DMG_MISSILE = 600;
		const float FREQ_VOLC = 1.0;
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_IDLE = "idle1";
		const string ANIM_SEARCH = "idle2";
		ANIM_FLINCH = "turnl";
		const string ANIM_SMASH = "mattack3";
		const string ANIM_SLASH = "mattack2";
		const string ANIM_PROJECTILE = "distanceattack";
		const string ANIM_ALERT = "distanceattack";
		ANIM_DEATH1 = "dieforward";
		ANIM_DEATH2 = "diesimple";
		ANIM_DEATH3 = "diesideways";
		const string ANIM_VICTORY1 = "victoryeat";
		const string ANIM_VICTORY2 = "victorysniff";
		ANIM_VICTORY = "victoryeat";
		ANIM_DEATH = "dieforward";
		ANIM_ATTACK = "mattack3";
		CAN_FLINCH = 1;
		FLINCH_HEALTH = 1000;
		FLINCH_CHANCE = 30;
		const int DOSMASH_CHANCE = 30;
		Precache(SOUND_DEATH);
	}

	void OnSpawn() override
	{
		SetName("Fire Reaver Hatchling");
		SetHealth(800);
		SetRoam(true);
		SetDamageResistance("cold", 1.0);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("holy", 0.5);
		SetWidth(32);
		SetHeight(48);
		SetRace("demon");
		SetHearingSensitivity(3);
		SetModel("monsters/firereaver_mini.mdl");
		SetMoveAnim(ANIM_WALK);
		LogDebug("game.monster.moveprox");
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

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(m_hAttackTarget != "unset")) return;
		if (!(IsValidPlayer(m_hAttackTarget))) return;
	}

	void npc_targetsighted()
	{
		if (GetEntityRange(m_hAttackTarget) < 256)
		{
			if (GetGameTime() > NEXT_FIRE_BURST)
			{
			}
			NEXT_FIRE_BURST = GetGameTime();
			NEXT_FIRE_BURST += FREQ_FIRE_BURST;
			do_fire_burst();
		}
	}

	void reset_smash_delay()
	{
		SMASH_DELAY = 0;
	}

	void attack_mele1()
	{
		string RANDOM_PUSH = RandomInt(90, 150);
		PUSH_VEL = /* TODO: $relvel */ $relvel(-100, RANDOM_PUSH, 110);
		SOUND_ATTACKHIT = SOUND_SLASHHIT;
		SOUND_ATTACKMISS = SOUND_SLASHMISS;
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, SLASH_DAMAGE, SLASH_HITCHANCE);
		PUSH_ATTACK = 1;
		if (!(RandomInt(1, 5) == 1)) return;
		ANIM_ATTACK = ANIM_SMASH;
	}

	void attack_mele2()
	{
		SOUND_ATTACKHIT = SOUND_SMASHHIT;
		SOUND_ATTACKMISS = SOUND_SMASHMISS;
		ANIM_ATTACK = ANIM_SLASH;
		string L_SLASH_DAMAGE = SLASH_DAMAGE;
		L_SLASH_DAMAGE *= 3.0;
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, L_SLASH_DAMAGE, SLASH_HITCHANCE);
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
		SEARCH_ANIM_DELAY = 0;
	}

	void game_dodamage()
	{
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
			}
			if ((PUSH_ATTACK))
			{
			}
			if (GetRelationship(param2) == "enemy")
			{
			}
			AddVelocity(param2, PUSH_VEL);
			ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_BURN);
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
		// PlayRandomSound from: SOUND_WALK1, SOUND_WALK2, SOUND_WALK3, SOUND_WALK4
		array<string> sounds = {SOUND_WALK1, SOUND_WALK2, SOUND_WALK3, SOUND_WALK4};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 5);
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
		SUSPEND_AI = 1;
		SetMoveDest("none");
		SetMoveAnim(ANIM_DEATH);
	}

	void game_reached_destination()
	{
		if (!(m_hAttackTarget == "unset")) return;
		if (!(NPC_LOST_TARGET == "unset")) return;
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
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
	}

	void npcatk_clear_targets()
	{
		VOLCANO_ON = 0;
	}

	void do_fire_burst()
	{
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 2.0;
		PlayAnim("critical", ANIM_PROJECTILE);
	}

	void attack_ranged()
	{
		EmitSound(GetOwner(), 0, "ambience/steamburst1.wav", 10);
		ClientEvent("new", "all", "monsters/summon/flame_burst_cl", GetEntityIndex(GetOwner()));
		DoDamage(GetEntityOrigin(GetOwner()), 384, DMG_BURST, 1.0, 0);
	}

}

}
