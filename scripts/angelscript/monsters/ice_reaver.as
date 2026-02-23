#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class IceReaver : CGameScript
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
	float BEAM_FREQ;
	string BEAM_TARGET;
	int CAN_FLINCH;
	int DID_WARCRY;
	int FIRST_ATTACK;
	int FLINCH_CHANCE;
	int FLINCH_HEALTH;
	string HP_STORAGE;
	string NEXT_PROJECTILE;
	string NPC_DAMAGE_TYPE;
	float NPC_DELAYING_UNSTUCK;
	int NPC_GIVE_EXP;
	string PROJECTILE_AMMO;
	string PUSH_VEL;
	int SEARCH_ANIM_DELAY;
	string SOUND_ATTACK;
	string SOUND_ATTACKHIT;
	string SOUND_ATTACKMISS;
	int STUN_ATTACK;
	int SUSPEND_AI;

	IceReaver()
	{
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
		const string SOUND_BEAMCHARGE = "debris/beamstart2.wav";
		const string SOUND_BEAMFIRE = "debris/beamstart9.wav";
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
		ATTACK_RANGE = 60;
		ATTACK_HITRANGE = 160;
		ATTACK_MOVERANGE = 38;
		const int STRONG_THRESHOLD = 1500;
		const int WEAK_THRESHOLD = 1000;
		const int NEAR_DEATH_THRESHOLD = 500;
		const int PROJECTILE_RANGE = 256;
		const int MAX_PROJECTILE_AMMO = 1;
		const string SLASH_DAMAGE = "$rand(50,100)";
		const string SMASH_DAMAGE = "$rand(100,250)";
		const float SLASH_HITCHANCE = 0.9;
		const float SMASH_HITCHANCE = 1.0;
		const int SMASH_HITRANGE = 200;
		const float SMASH_STUN_CHANCE = 0.3;
		BEAM_FREQ = 45.0;
		const int BEAM_DAMAGE = 150;
		const int SHOCK_DAMAGE = 20;
		const int SHOCK_DURATION = 5;
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
		FLINCH_HEALTH = 500;
		FLINCH_CHANCE = 30;
		const int DOSMASH_CHANCE = 30;
		const string LIGHTNING_SPRITE = "lgtning.spr";
		const string MONSTER_MODEL = "monsters/abominable.mdl";
		Precache(LIGHTNING_SPRITE);
		Precache(MONSTER_MODEL);
		Precache(SOUND_DEATH);
	}

	void OnSpawn() override
	{
		SetName("Ice Reaver");
		SetHealth(2000);
		SetRoam(true);
		SetDamageResistance("cold", 0.0);
		if (StringToLower(GetMapName()) == "the_wall")
		{
			SetWidth(48);
			SetHeight(64);
		}
		else
		{
			SetWidth(72);
			SetHeight(64);
		}
		NPC_GIVE_EXP = 400;
		SetRace("demon");
		SetHearingSensitivity(3);
		Precache(MONSTER_MODEL);
		SetModel(MONSTER_MODEL);
		SetMoveAnim(ANIM_WALK);
		if ((StringToLower(GetMapName())).findFirst("the_wall") == 0)
		{
			BEAM_FREQ = 15.0;
		}
		PROJECTILE_AMMO = MAX_PROJECTILE_AMMO;
		HP_STORAGE = GetMonsterHP();
		NEXT_PROJECTILE = GetGameTime();
		NEXT_PROJECTILE += BEAM_FREQ;
		ScheduleDelayedEvent(1.0, "post_spawn");
	}

	void post_spawn()
	{
		SetDamageResistance("holy", 0.0);
	}

	void npc_targetsighted()
	{
		if ((DID_WARCRY)) return;
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
		DID_WARCRY = 1;
		FIRST_ATTACK = 1;
		NEXT_PROJECTILE = GetGameTime();
		NEXT_PROJECTILE += 1.0;
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 5.0;
	}

	void my_target_died()
	{
		ice_reaver_beam_reload();
		SetHealth(HP_STORAGE);
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
		PlayAnim("once", ANIM_VICTORY);
		// PlayRandomSound from: SOUND_SEARCH1, SOUND_SEARCH2, SOUND_SEARCH3
		array<string> sounds = {SOUND_SEARCH1, SOUND_SEARCH2, SOUND_SEARCH3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if ((SUSPEND_AI)) return;
		if ((I_R_FROZEN)) return;
		if (!(m_hAttackTarget != "unset")) return;
		if (!(GetGameTime() > NEXT_PROJECTILE)) return;
		NEXT_PROJECTILE = GetGameTime();
		NEXT_PROJECTILE += BEAM_FREQ;
		if (!(false)) return;
		if (GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)
		{
			BEAM_TARGET = m_hAttackTarget;
			npcatk_faceattacker();
			EmitSound(GetOwner(), 0, SOUND_BEAMCHARGE, 10);
			AS_ATTACKING = GetGameTime();
			AS_ATTACKING += 5.0;
			npcatk_suspend_movement(ANIM_PROJECTILE, 2.0);
			PlayAnim("critical", ANIM_PROJECTILE);
		}
		else
		{
			reaver_beam_reposition();
			NEXT_PROJECTILE = GetGameTime();
			NEXT_PROJECTILE += 3.0;
		}
	}

	void attack_ranged()
	{
		STUN_ATTACK = 0;
		ScheduleDelayedEvent(0.5, "npcatk_resume_ai");
		EmitSound(GetOwner(), 0, SOUND_BEAMFIRE, 10);
		SetMoveDest(BEAM_TARGET);
		string BEAM_START = GetMonsterProperty("origin");
		string BEAM_END = GetEntityOrigin(BEAM_TARGET);
		Effect("beam", "point", LIGHTNING_SPRITE, 80, /* TODO: $relpos */ $relpos(0, 0, -22), BEAM_END, Vector3(255, 255, 255), 150, 50, 0.2);
		Effect("beam", "point", LIGHTNING_SPRITE, 80, /* TODO: $relpos */ $relpos(-22, 0, 22), BEAM_END, Vector3(255, 255, 255), 150, 50, 0.2);
		Effect("beam", "point", LIGHTNING_SPRITE, 80, /* TODO: $relpos */ $relpos(22, 0, 22), BEAM_END, Vector3(255, 255, 255), 150, 50, 0.2);
		SOUND_ATTACK = "unset";
		NPC_DAMAGE_TYPE = "lightning";
		XDoDamage(BEAM_TARGET, "direct", BEAM_DAMAGE, 1.0, GetOwner(), GetOwner(), "none", "lightning", "dmgevent:beam");
	}

	void beam_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		ApplyEffect(param2, "effects/dot_lightning", SHOCK_DURATION, GetEntityIndex(GetOwner()), SHOCK_DAMAGE);
	}

	void reaver_beam_reposition()
	{
		npcatk_flee(m_hAttackTarget, 640, 2.0);
	}

	void npc_selectattack()
	{
		string RAND_ATK = RandomInt(1, 100);
		if (RAND_ATK <= DOSMASH_CHANCE)
		{
			ANIM_ATTACK = ANIM_SMASH;
		}
		if (RAND_ATK > DOSMASH_CHANCE)
		{
			ANIM_ATTACK = ANIM_SLASH;
		}
		if ((FIRST_ATTACK))
		{
			ANIM_ATTACK = ANIM_SMASH;
		}
		FIRST_ATTACK = 0;
	}

	void attack_mele1()
	{
		XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, SLASH_DAMAGE, SLASH_HITCHANCE, GetOwner(), GetOwner(), "none", "slash", "dmgevent:slash");
	}

	void slash_dodamage()
	{
		STUN_ATTACK = 0;
		string RANDOM_PUSH = RandomInt(100, 175);
		PUSH_VEL = /* TODO: $relvel */ $relvel(-100, RANDOM_PUSH, 120);
		SOUND_ATTACKHIT = SOUND_SLASHHIT;
		SOUND_ATTACKMISS = SOUND_SLASHMISS;
		string OUT_PAR1 = param1;
		string OUT_PAR2 = param2;
		string OUT_PAR3 = param3;
		string OUT_PAR4 = param4;
		string OUT_PAR5 = param5;
		mele_attack(OUT_PAR1, OUT_PAR2, OUT_PAR3, OUT_PAR4, OUT_PAR5);
		STUN_ATTACK = 1;
		SOUND_ATTACKHIT = SOUND_SMASHHIT;
		SOUND_ATTACKMISS = SOUND_SMASHMISS;
		string RANDOM_PUSH = RandomInt(200, 400);
		PUSH_VEL = /* TODO: $relvel */ $relvel(-100, RANDOM_PUSH, 120);
		string OUT_PAR1 = param1;
		string OUT_PAR2 = param2;
		string OUT_PAR3 = param3;
		string OUT_PAR4 = param4;
		string OUT_PAR5 = param5;
		mele_attack(OUT_PAR1, OUT_PAR2, OUT_PAR3, OUT_PAR4, OUT_PAR5);
	}

	void attack_mele2()
	{
		XDoDamage(m_hAttackTarget, SMASH_HITRANGE, SMASH_DAMAGE, SMASH_HITCHANCE, GetOwner(), GetOwner(), "none", "slash", "dmgevent:smash");
	}

	void npcatk_search_init_advanced()
	{
		if ((SEARCH_ANIM_DELAY)) return;
		NPC_DELAYING_UNSTUCK = 10.0;
		PlayAnim("once", ANIM_SEARCH);
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

	void mele_attack()
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
			AddVelocity(m_hLastStruckByMe, PUSH_VEL);
		}
		if ((STUN_ATTACK))
		{
			STUN_ATTACK = 0;
			if (RandomInt(1, 100) > SMASH_STUN_CHANCE)
			{
				ApplyEffect(m_hAttackTarget, "effects/debuff_stun", 7, GetEntityIndex(GetOwner()));
			}
		}
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
		string RAND_DEATH = RandomInt(1, 3);
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
		PlayAnim("once", ANIM_VICTORY);
	}

}

}
