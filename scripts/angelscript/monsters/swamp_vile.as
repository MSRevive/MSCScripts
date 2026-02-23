#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SwampVile : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int DID_ALERT;
	float FREQ_THROW;
	int GLOB_EFFECT_DOT;
	float GLOB_EFFECT_DUR;
	string GLOB_EFFECT_TYPE;
	string HALF_HP;
	int MOVE_RANGE;
	string NEXT_FLINCH;
	string NEXT_HEARD_ALERT;
	string NEXT_THROW;
	int NPC_BASE_EXP;

	SwampVile()
	{
		const string ANIM_POINT = "point";
		const string ANIM_RALLY = "rally";
		const string ANIM_RAWR = "idle_scream";
		ANIM_WALK = "walk_lx";
		ANIM_IDLE = "idle_base";
		ANIM_RUN = "run_kx";
		ANIM_ATTACK = "melee1";
		const string ANIM_ATTACK1 = "melee1";
		const string ANIM_ATTACK2 = "melee1b";
		const string ANIM_ATTACK3 = "melee2";
		const string ANIM_THROW = "throw_rock";
		const string ANIM_CUST_FLINCH = "duck";
		ANIM_DEATH = "death";
		NPC_BASE_EXP = 2000;
		const int DMG_SLASH = 400;
		FREQ_THROW = 5.0;
		ATTACK_MOVERANGE = 40;
		MOVE_RANGE = 40;
		ATTACK_RANGE = 50;
		ATTACK_HITRANGE = 70;
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const string SOUND_PAIN1 = "monsters/keeper/c_troll_hit1.wav";
		const string SOUND_PAIN2 = "monsters/keeper/c_troll_hit2.wav";
		const string SOUND_ALERT1 = "monsters/keeper/c_troll_bat1.wav";
		const string SOUND_ALERT2 = "monsters/keeper/c_troll_bat2.wav";
		const string SOUND_ALERT3 = "monsters/keeper/c_troll_bat2_rev.wav";
		const string SOUND_ATTACK1 = "monsters/keeper/c_lizardm_atk1.wav";
		const string SOUND_ATTACK2 = "monsters/keeper/c_lizardm_atk2.wav";
		const string SOUND_ATTACK3 = "monsters/keeper/c_lizardm_atk3.wav";
		const string SOUND_SWING1 = "zombie/claw_miss1.wav";
		const string SOUND_SWING2 = "zombie/claw_miss2.wav";
		const string SOUND_DEATH = "monsters/keeper/c_troll_dead.wav";
		GLOB_EFFECT_TYPE = "effects/dot_poison_blind";
		GLOB_EFFECT_DOT = 150;
		GLOB_EFFECT_DUR = 3.0;
	}

	void OnSpawn() override
	{
		SetName("Swamp Keeper");
		SetModel("monsters/keeper.mdl");
		SetHeight(64);
		SetWidth(32);
		SetRoam(true);
		SetHealth(5000);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("poison", 0.5);
		SetRace("demon");
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		ScheduleDelayedEvent(2.0, "finalize_me");
	}

	void finalize_me()
	{
		HALF_HP = GetEntityMaxHealth(GetOwner());
		HALF_HP *= 0.5;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN1, SOUND_PAIN2
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN1, SOUND_PAIN2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 5);
	}

	void npc_targetsighted()
	{
		if ((DID_ALERT)) return;
		npcatk_suspend_roam(2.0);
		SetMoveDest(m_hAttackTarget);
		DID_ALERT = 1;
		G_ALERT_CYCLE += 1;
		if (!(NPC_IS_TURRET))
		{
			NEXT_THROW = GetGameTime();
			NEXT_THROW += FREQ_THROW;
		}
		if (G_ALERT_CYCLE == 1)
		{
			PlayAnim("critical", ANIM_POINT);
			EmitSound(GetOwner(), 0, SOUND_ALERT2, 10);
		}
		if (G_ALERT_CYCLE == 2)
		{
			PlayAnim("critical", ANIM_RALLY);
			EmitSound(GetOwner(), 0, SOUND_ALERT1, 10);
		}
		if (G_ALERT_CYCLE == 3)
		{
			PlayAnim("critical", ANIM_RAWR);
			EmitSound(GetOwner(), 0, SOUND_ALERT3, 10);
		}
		if (G_ALERT_CYCLE == 3)
		{
			SetGlobalVar("G_ALERT_CYCLE", 0);
		}
	}

	void cycle_down()
	{
		DID_ALERT = 0;
	}

	void npc_heard_player()
	{
		if (!(m_hAttackTarget == "unset")) return;
		if (!(GetGameTime() > NEXT_HEARD_ALERT)) return;
		NEXT_HEARD_ALERT = GetGameTime();
		NEXT_HEARD_ALERT += 15.0;
		EmitSound(GetOwner(), 0, "monsters/keeper/c_troll_slct.wav", 10);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(m_hAttackTarget != "unset")) return;
		string TARG_RANGE = GetEntityRange(m_hAttackTarget);
		if (TARG_RANGE > ATTACK_HITRANGE)
		{
			if (GetGameTime() > NEXT_THROW)
			{
			}
			NEXT_THROW = GetGameTime();
			NEXT_THROW += FREQ_THROW;
			npcatk_suspend_roam(2.0);
			PlayAnim("once", ANIM_THROW);
		}
		if (TARG_RANGE < ATTACK_RANGE)
		{
			if (TARG_RANGE < ATTACK_MOVERANGE)
			{
				ANIM_ATTACK = ANIM_ATTACK3;
			}
			else
			{
				string RND_ATK = RandomInt(1, 2);
				if (RND_ATK == 1)
				{
					ANIM_ATTACK = ANIM_ATTACK1;
				}
				if (RND_ATK == 2)
				{
					ANIM_ATTACK = ANIM_ATTACK2;
				}
			}
		}
	}

	void frame_melee_start()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void frame_melee1_strike()
	{
		// PlayRandomSound from: SOUND_SWING1, SOUND_SWING2
		array<string> sounds = {SOUND_SWING1, SOUND_SWING2};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SLASH, 0.8, "slash");
	}

	void frame_melee2_strike()
	{
		// PlayRandomSound from: SOUND_SWING1, SOUND_SWING2
		array<string> sounds = {SOUND_SWING1, SOUND_SWING2};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SLASH, 0.8, "slash");
	}

	void OnDamage(int damage) override
	{
		if (!(GetEntityHealth(GetOwner()) < HALF_HP)) return;
		if (!(GetGameTime() > NEXT_FLINCH)) return;
		NEXT_FLINCH = GetGameTime();
		NEXT_FLINCH += 20.0;
		npcatk_suspend_ai(1.0);
		EmitSound(GetOwner(), 0, SOUND_PAIN1, 10);
		PlayAnim("critical", ANIM_CUST_FLINCH);
	}

	void set_npc_turret()
	{
		FREQ_THROW = 2.0;
		Random(10_0, 15_0)("taunt_loop");
	}

	void taunt_loop()
	{
		DID_ALERT = 0;
		Random(10_0, 15_0)("taunt_loop");
	}

}

}
