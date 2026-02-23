#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class IceReaverMini : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_DEATH1;
	string ANIM_DEATH2;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int CAN_FLINCH;
	int DID_ALERT;
	int FLINCH_CHANCE;
	string FLINCH_HEALTH;
	string HALF_HEALTH;
	int MELEE_ATTACK;
	string NEXT_EAT;
	string NEXT_SEARCH;
	int NPC_GIVE_EXP;
	string PUSH_VEL;
	string QUARTER_HEALTH;

	IceReaverMini()
	{
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_IDLE = "idle1";
		ANIM_FLINCH = "turnl";
		ANIM_DEATH = "dieforward";
		ANIM_ATTACK = "mattack3";
		const string ANIM_SEARCH = "idle2";
		const string ANIM_SMASH = "mattack3";
		const string ANIM_SLASH = "mattack2";
		const string ANIM_ALERT = "distanceattack";
		const string ANIM_ALERT = "distanceattack";
		ANIM_DEATH1 = "diesimple";
		ANIM_DEATH2 = "diesideways";
		const string ANIM_VICTORY1 = "victoryeat";
		const string ANIM_VICTORY2 = "victorysniff";
		CAN_FLINCH = 1;
		ATTACK_RANGE = 64;
		ATTACK_HITRANGE = 75;
		ATTACK_MOVERANGE = 40;
		const string DMG_SLASH = Random(25, 50);
		const string DMG_SMASH = Random(50, 100);
		const int DOT_FROST = 25;
		NPC_GIVE_EXP = 200;
		const float SLASH_HITCHANCE = 0.8;
		const float SMASH_HITCHANCE = 0.9;
		const int SMASH_HITRANGE = 75;
		const int SLASH_HITRANGE = 75;
		const string SOUND_STRUCK1 = "body/flesh1.wav";
		const string SOUND_STRUCK2 = "body/flesh2.wav";
		const string SOUND_STRUCK3 = "body/flesh3.wav";
		const string SOUND_PAIN1 = "monsters/ice_reaver_mini/gon_pain2.wav";
		const string SOUND_PAIN2 = "monsters/ice_reaver_mini/gon_pain4.wav";
		const string SOUND_PAIN3 = "monsters/ice_reaver_mini/gon_pain5.wav";
		const string SOUND_DEATH = "monsters/ice_reaver_mini/gon_die1.wav";
		const string SOUND_ALERT = "monsters/ice_reaver_mini/gon_alert1.wav";
		const string SOUND_SEARCH1 = "monsters/ice_reaver_mini/gon_childdie3.wav";
		const string SOUND_SEARCH2 = "monsters/ice_reaver_mini/gon_childdie2.wav";
		const string SOUND_SEARCH3 = "monsters/ice_reaver_mini/gon_childdie1.wav";
		const string SOUND_RUN1 = "common/npc_step1.wav";
		const string SOUND_RUN2 = "common/npc_step2.wav";
		const string SOUND_RUN3 = "common/npc_step3.wav";
		const string SOUND_RUN4 = "common/npc_step4.wav";
		const string SOUND_SLASHHIT = "zombie/claw_strike1.wav";
		const string SOUND_SMASHHIT = "zombie/claw_strike2.wav";
		const string SOUND_SLASHMISS = "zombie/claw_miss1.wav";
		const string SOUND_SMASHMISS = "zombie/claw_miss2.wav";
	}

	void game_precache()
	{
		Precache(SOUND_PAIN1);
		Precache(SOUND_PAIN2);
		Precache(SOUND_PAIN3);
	}

	void OnSpawn() override
	{
		SetName("Ice Reaver Hatchling");
		SetHealth(500);
		SetRoam(true);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("fire", 1.2);
		SetWidth(32);
		SetHeight(32);
		NPC_GIVE_EXP = 200;
		SetRace("demon");
		SetHearingSensitivity(3);
		SetModel("monsters/abominable_mini.mdl");
		SetMoveAnim(ANIM_WALK);
		PUSH_VEL = "none";
		ScheduleDelayedEvent(1.5, "post_setup");
	}

	void post_setup()
	{
		FLINCH_HEALTH = GetEntityMaxHealth(GetOwner());
		FLINCH_HEALTH *= 0.25;
		FLINCH_CHANCE = 30;
		HALF_HEALTH = GetEntityMaxHealth(GetOwner());
		HALF_HEALTH *= 0.5;
		QUARTER_HEALTH = FLINCH_HEALTH;
	}

	void npc_targetsighted()
	{
		if ((DID_ALERT)) return;
		DID_ALERT = 1;
		PlayAnim("critical", ANIM_ALERT);
		EmitSound(GetOwner(), 0, SOUND_ALERT, 10);
	}

	void my_target_died()
	{
		DID_ALERT = 0;
		if (!(GetGameTime() > NEXT_EAT)) return;
		NEXT_EAT = GetGameTime();
		NEXT_EAT += 20.0;
		string RND_VICT = RandomInt(1, 2);
		if (RND_VICT == 1)
		{
			PlayAnim("critical", ANIM_VICTORY1);
		}
		if (RND_VICT == 2)
		{
			PlayAnim("critical", ANIM_VICTORY2);
		}
		// PlayRandomSound from: SOUND_SEARCH1, SOUND_SEARCH2, SOUND_SEARCH3
		array<string> sounds = {SOUND_SEARCH1, SOUND_SEARCH2, SOUND_SEARCH3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void npcatk_lost_sight()
	{
		if (!(GetGameTime() > NEXT_SEARCH)) return;
		NEXT_SEARCH = GetGameTime();
		NEXT_SEARCH += 10.0;
		PlayAnim("once", ANIM_SEARCH);
		// PlayRandomSound from: SOUND_SEARCH1, SOUND_SEARCH2, SOUND_SEARCH3
		array<string> sounds = {SOUND_SEARCH1, SOUND_SEARCH2, SOUND_SEARCH3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void game_dodamage()
	{
		if ((MELEE_ATTACK))
		{
			if (!(param1))
			{
				EmitSound(GetOwner(), 0, SOUND_ATTACKMISS, 10);
			}
			if ((param1))
			{
				EmitSound(GetOwner(), 0, SOUND_ATTACKHIT, 10);
				if (PUSH_VEL != "none")
				{
					AddVelocity(param2, PUSH_VEL);
					PUSH_VEL = "none";
					ApplyEffect(param2, "effects/dot_cold", 5.0, GetEntityIndex(GetOwner()), DOT_FROST);
				}
			}
		}
		MELEE_ATTACK = 0;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		string MY_HP = GetEntityHealth(GetOwner());
		if (MY_HP > HALF_HEALTH)
		{
			string PAIN_SOUND = SOUND_PAIN1;
		}
		if (MY_HP < HALF_HEALTH)
		{
			string PAIN_SOUND = SOUND_PAIN2;
		}
		if (MY_HP < QUARTER_HEALTH)
		{
			string PAIN_SOUND = SOUND_PAIN3;
		}
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK2, PAIN_SOUND
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK2, PAIN_SOUND};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void monster_run_step()
	{
		// PlayRandomSound from: SOUND_RUN1, SOUND_RUN2, SOUND_RUN3, SOUND_RUN4
		array<string> sounds = {SOUND_RUN1, SOUND_RUN2, SOUND_RUN3, SOUND_RUN4};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 5);
	}

	void attack_mele1()
	{
		PUSH_VEL = "none";
		MELEE_ATTACK = 1;
		DoDamage(m_hAttackTarget, SLASH_HITRANGE, DMG_SLASH, SLASH_HITCHANCE, "slash");
		if (!(RandomInt(1, 5) == 1)) return;
		ANIM_ATTACK = ANIM_SMASH;
	}

	void attack_mele2()
	{
		MELEE_ATTACK = 1;
		PUSH_VEL = /* TODO: $relvel */ $relvel(-100, 300, 110);
		DoDamage(m_hAttackTarget, SMASH_HITRANGE, DMG_SMASH, SMASH_HITCHANCE, "slash");
		ANIM_ATTACK = ANIM_SLASH;
	}

}

}
