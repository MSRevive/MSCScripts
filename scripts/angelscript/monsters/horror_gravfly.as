#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_flyer_grav.as"

namespace MS
{

class HorrorGravfly : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int BALL_DMG;
	int BALL_SIZE;
	float BASE_MOVESPEED;
	int BREATH_AMMO;
	string BREATH_ATTACK;
	string BURST_POS;
	string BURST_TARGS;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int IS_UNHOLY;
	string NEXT_HORROR_BOOST;
	int NPC_GIVE_EXP;
	string NPC_HALF_HEALTH;
	string PROJECTILE_ATTACK;
	int SPIT_AMMO;

	HorrorGravfly()
	{
		ANIM_WALK = "fly1";
		ANIM_IDLE = "idle1";
		ANIM_RUN = "fly1";
		const string ANIM_FLY = "fly1";
		const string ANIM_ROLL = "fly2";
		ANIM_ATTACK = "bite1";
		const string ANIM_BITE1 = "bite1";
		const string ANIM_BITE2 = "bite2";
		ANIM_DEATH = "die";
		const string ANIM_BREATH = "breath";
		const string ANIM_HOVER = "hover";
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 40;
		DROP_GOLD_MAX = 200;
		NPC_GIVE_EXP = 400;
		IS_UNHOLY = 1;
		SPIT_AMMO = 3;
		const int MAX_SPIT_AMMO = 3;
		BREATH_AMMO = 1;
		BALL_SIZE = 5;
		BALL_DMG = 100;
		const int DMG_PROJECTILE = 100;
		const string PROJ_SCRIPT = "proj_poison_spit2";
		const int PROJ_SPEED = 500;
		const float PROJ_FOV = 0.5;
		const string FREQ_HORROR_BOOST = Random(5.0, 10.0);
		const int DOT_SHOCK = 15;
		const int DMG_BLAST = 100;
		ATTACK_RANGE = 60;
		ATTACK_HITRANGE = 60;
		const float ATTACK_HITCHANCE = 0.8;
		const int DMG_BITE = 100;
		const string SOUND_IDLE1 = "controller/con_idle1.wav";
		const string SOUND_IDLE2 = "controller/con_idle2.wav";
		const string SOUND_IDLE3 = "controller/con_idle3.wav";
		const string SOUND_SPIT1 = "bullchicken/bc_attack3.wav";
		const string SOUND_SPIT2 = "bullchicken/bc_attack2.wav";
		const string SOUND_ATTACK1 = "controller/con_attack1.wav";
		const string SOUND_ATTACK2 = "controller/con_attack2.wav";
		const string SOUND_ATTACK3 = "controller/con_attack3.wav";
		const string SOUND_DEATH = "controller/con_die1.wav";
		const string SOUND_PAIN0 = "debris/bustflesh2.wav";
		const string SOUND_PAIN1 = "controller/con_pain1.wav";
		const string SOUND_PAIN2 = "controller/con_die2.wav";
		const string SOUND_SPRAY = "controller/con_attack3.wav";
		const string SOUND_FLAP1 = "monsters/bat/flap_big1.wav";
		const string SOUND_FLAP2 = "monsters/bat/flap_big2.wav";
		const string SOUND_SPRAY = "ambient/steamburst1.wav";
		const string SOUND_SHOCK1 = "bullchicken/bc_attack1.wav";
		const string SOUND_SHOCK2 = "bullchicken/bc_attack2.wav";
		const string SOUND_SHOCK3 = "bullchicken/bc_attack3.wav";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(30.0);
		if (SPIT_AMMO < MAX_SPIT_AMMO)
		{
		}
		if (SPIT_AMMO == 0)
		{
			if (m_hAttackTarget != "unset")
			{
			}
			if (GetEntityRange(m_hAttackTarget) < 200)
			{
			}
			npcatk_flee(m_hAttackTarget, 512, 1.0);
		}
		SPIT_AMMO += 1;
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(60.0);
		if (BREATH_AMMO <= 0)
		{
		}
		BREATH_AMMO = 1;
	}

	void OnSpawn() override
	{
		SetName("Enraged Horror");
		SetHealth(1000);
		SetWidth(32);
		SetHeight(32);
		SetRoam(true);
		SetRace("demon");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(11);
		SetModel("monsters/edwardgorey2.mdl");
		SetMoveSpeed(3.0);
		BASE_MOVESPEED = 3.0;
		PlayAnim("once", ANIM_WALK);
		if (!(true)) return;
		ScheduleDelayedEvent(1.0, "idle_sounds");
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 2.0);
		SPIT_AMMO = 3;
		BREATH_AMMO = 1;
	}

	void OnPostSpawn() override
	{
		NPC_HALF_HEALTH = GetEntityMaxHealth(GetOwner());
		NPC_HALF_HEALTH *= 0.5;
	}

	void idle_sounds()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		string NEXT_SOUND = Random(3, 10);
		NEXT_SOUND("idle_sounds");
		if (!(m_hAttackTarget == "none")) return;
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void npc_targetsighted()
	{
		if (SPIT_AMMO > 0)
		{
			ANIM_ATTACK = ANIM_BREATH;
			PROJECTILE_ATTACK = 1;
			BREATH_ATTACK = 0;
			ANIM_WALK = ANIM_FLY;
			ANIM_RUN = ANIM_FLY;
			PlayAnim("once", ANIM_ATTACK);
			int EXIT_SUB = 1;
		}
		else
		{
			if (BREATH_AMMO > 0)
			{
				ANIM_ATTACK = ANIM_BREATH;
				ANIM_WALK = ANIM_ROLL;
				ANIM_RUN = ANIM_ROLL;
				PROJECTILE_ATTACK = 0;
				BREATH_ATTACK = 1;
				int EXIT_SUB = 1;
			}
			else
			{
				if (ANIM_ATTACK != ANIM_BITE1)
				{
					if (ANIM_ATTACK != ANIM_BITE2)
					{
					}
					ANIM_ATTACK = ANIM_BITE1;
				}
				ANIM_WALK = ANIM_FLY;
				ANIM_RUN = ANIM_FLY;
				BREATH_ATTACK = 0;
				PROJECTILE_ATTACK = 0;
			}
		}
		if ((EXIT_SUB)) return;
		if (!(GetGameTime() > NEXT_HORROR_BOOST)) return;
		NEXT_HORROR_BOOST = GetGameTime();
		NEXT_HORROR_BOOST += FREQ_HORROR_BOOST;
		EmitSound(GetOwner(), 0, SOUND_FLAP, 10);
		PlayAnim("once", ANIM_ROLL);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 800, 0));
	}

	void breath_attack()
	{
		if ((PROJECTILE_ATTACK))
		{
			TossProjectile(PROJ_SCRIPT, "view", "none", PROJ_SPEED, DMG_PROJECTILE, PROJ_FOV, "none");
			// PlayRandomSound from: SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3
			array<string> sounds = {SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			SPIT_AMMO -= 1;
		}
		if ((BREATH_ATTACK))
		{
			Effect("glow", GetOwner(), Vector3(255, 255, 0), 768, 2, 2);
			EmitSound(GetOwner(), 0, SOUND_SPRAY, 10);
			BURST_POS = GetEntityOrigin(GetOwner());
			BURST_POS = "z";
			ClientEvent("new", "all", "effects/sfx_poison_burst", BURST_POS, 256, 1, Vector3(0, 255, 0));
			DoDamage(BURST_POS, 256, DMG_BLAST, 1.0, 0);
			BREATH_AMMO -= 1;
			BURST_TARGS = FindEntitiesInSphere("enemy", 256);
			if (BURST_TARGS != "none")
			{
			}
			for (int i = 0; i < GetTokenCount(BURST_TARGS, ";"); i++)
			{
				burst_affect_targets();
			}
		}
	}

	void burst_affect_targets()
	{
		string CUR_TARG = GetToken(BURST_TARGS, i, ";");
		ApplyEffect(CUR_TARG, "effects/dot_poison", 5.0, GetEntityIndex(GetOwner()), DOT_SHOCK);
	}

	void attack1()
	{
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_BITE, ATTACK_HITCHANCE, "slash");
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (RandomInt(1, 5) == 1)
		{
			ANIM_ATTACK = ANIM_BITE2;
		}
	}

	void attack2()
	{
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_BITE, ATTACK_HITCHANCE, "slash");
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		ANIM_ATTACK = ANIM_BITE1;
		if (!(GetEntityRange(m_hAttackTarget) <= ATTACK_HITRANGE)) return;
		ApplyEffect(m_hAttackTarget, "effects/dot_poison_blind", 5.0, GetEntityIndex(GetOwner()), DOT_SHOCK);
		AddVelocity(m_hAttackTarget, /* TODO: $relvel */ $relvel(-550, 50, 10));
	}

	void spiral_charge()
	{
		// PlayRandomSound from: SOUND_FLAP1, SOUND_FLAP2
		array<string> sounds = {SOUND_FLAP1, SOUND_FLAP2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void turret_horror()
	{
		// PlayRandomSound from: SOUND_FLAP1, SOUND_FLAP2
		array<string> sounds = {SOUND_FLAP1, SOUND_FLAP2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		string MY_HEALTH = GetEntityHealth(GetOwner());
		if (MY_HEALTH >= NPC_HALF_HEALTH)
		{
			// PlayRandomSound from: SOUND_PAIN0, SOUND_PAIN0, SOUND_PAIN1
			array<string> sounds = {SOUND_PAIN0, SOUND_PAIN0, SOUND_PAIN1};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (MY_HEALTH < NPC_HALF_HEALTH)
		{
			// PlayRandomSound from: SOUND_PAIN0, SOUND_PAIN0, SOUND_PAIN2
			array<string> sounds = {SOUND_PAIN0, SOUND_PAIN0, SOUND_PAIN2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

	void my_target_died()
	{
		SPIT_AMMO = 3;
		BREATH_AMMO = 1;
	}

}

}
