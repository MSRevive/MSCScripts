#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_flyer_grav.as"

namespace MS
{

class HorrorLightning2 : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int AS_SUMMON_TELE_CHECK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int BALL_DMG;
	int BALL_SIZE;
	float BASE_MOVESPEED;
	string BFLY_AGRESSIVE;
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

	HorrorLightning2()
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
		AS_SUMMON_TELE_CHECK = 1;
		const int DMG_PROJECTILE = 100;
		const string PROJ_SCRIPT = "proj_lightning_ball";
		const int PROJ_SPEED = 200;
		const float PROJ_FOV = 0.5;
		const string FX_BURST_SCRIPT = "effects/sfx_shock_burst";
		const string EFFECT_DOT = "effects/dot_lightning";
		const float DUR_DOT = 5.0;
		const int DMG_DOT = 30;
		const int DMG_BITE = 100;
		const int DMG_BLAST = 200;
		const Vector3 ELEMENT_COLOR = Vector3(255, 255, 0);
		const string BURST_ELEMENT = "lightning_effect";
		const int DMG_PROJECTILE = 100;
		const string PROJ_SCRIPT = "proj_lightning_ball";
		const int PROJ_SPEED = 500;
		const float PROJ_FOV = 0.5;
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
		const string FREQ_HORROR_BOOST = Random(5.0, 10.0);
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
		const string SOUND_SPRAY = "debris/beamstart1.wav";
		const string SOUND_SHOCK1 = "debris/zap8.wav";
		const string SOUND_SHOCK2 = "debris/zap3.wav";
		const string SOUND_SHOCK3 = "debris/zap4.wav";
	}

	void OnSpawn() override
	{
		horror_spawn();
	}

	void horror_spawn()
	{
		SetName("Enraged Electrical Horror");
		SetHealth(1000);
		SetWidth(32);
		SetHeight(32);
		SetRoam(true);
		SetRace("demon");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(11);
		SetModel("monsters/edwardgorey2.mdl");
		SetModelBody(0, 2);
		SetMoveSpeed(3.0);
		BASE_MOVESPEED = 3.0;
		PlayAnim("once", ANIM_WALK);
		if (!(true)) return;
		ScheduleDelayedEvent(1.0, "idle_sounds");
		SetDamageResistance("poison", 2.0);
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("lightning", 0.0);
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
			BFLY_AGRESSIVE = 0;
			int EXIT_SUB = 1;
		}
		else
		{
			BFLY_AGRESSIVE = 1;
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
			if (SPIT_AMMO <= 0)
			{
				ScheduleDelayedEvent(30.0, "reload_spit");
			}
		}
		if ((BREATH_ATTACK))
		{
			ScheduleDelayedEvent(15.0, "reload_breath");
			Effect("glow", GetOwner(), ELEMENT_COLOR, 768, 2, 2);
			EmitSound(GetOwner(), 0, SOUND_SPRAY, 10);
			BURST_POS = GetEntityOrigin(GetOwner());
			BURST_POS = "z";
			ClientEvent("new", "all", FX_BURST_SCRIPT, BURST_POS, 256, 1, ELEMENT_COLOR);
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

	void reload_breath()
	{
		BREATH_AMMO = 1;
	}

	void burst_affect_targets()
	{
		string CUR_TARG = GetToken(BURST_TARGS, i, ";");
		ApplyEffect(CUR_TARG, EFFECT_DOT, DUR_DOT, GetEntityIndex(GetOwner()), DMG_DOT);
		if (!(BURST_PUSH)) return;
		repel_target(CUR_TARG, Vector3(0, 1000, 110), BURST_POS);
	}

	void repel_target()
	{
		string L_TARG_ORG = GetEntityOrigin(param1);
		string L_MY_ORG = param3;
		string L_TARG_ANG = /* TODO: $angles */ $angles(L_MY_ORG, L_TARG_ORG);
		string L_NEW_YAW = L_TARG_ANG;
		SetVelocity(param1, /* TODO: $relvel */ $relvel(Vector3(0, L_NEW_YAW, 0), param2));
	}

	void attack1()
	{
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_BITE, ATTACK_HITCHANCE, "slash");
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (RandomInt(1, 2) == 1)
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
		ApplyEffect(m_hAttackTarget, EFFECT_DOT, DUR_DOT, GetEntityIndex(GetOwner()), DMG_DOT);
		if (!(GetEntityRange(m_hAttackTarget) <= ATTACK_HITRANGE)) return;
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

	void reload_spit()
	{
		if (!(SPIT_AMMO < MAX_SPIT_AMMO)) return;
		SPIT_AMMO += 1;
		if (!(m_hAttackTarget != "unset")) return;
		if (!(GetEntityRange(m_hAttackTarget) < 200)) return;
		npcatk_flee(m_hAttackTarget, 512, 1.0);
	}

}

}
