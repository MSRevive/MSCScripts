#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_patrol_radius.as"

namespace MS
{

class GiantFire : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_ATTACK_FAR;
	string ANIM_ATTACK_NEAR;
	string ANIM_ATTACK_NORM;
	string ANIM_ATTACK_STOMP;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_IDLE_AGRO;
	string ANIM_IDLE_NORM;
	string ANIM_RUN;
	string ANIM_WALK;
	string ANIM_WARCRY;
	int ATK_RAD;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int BPATROL_ACTIVE;
	int BPATROL_MOVEPROX;
	string BPATROL_RAD;
	string CUSTOM_ANIM_FLINCH;
	int DID_INTRO;
	int DMG_DOT;
	int DMG_DOT2;
	int DMG_STOMP;
	int DMG_SWING;
	string DOING_REACH_SWING;
	int DOING_STOMP;
	float FREQ_REACH_SWING;
	float FREQ_STOMP;
	string HALF_HP;
	int MOVE_RANGE;
	int NERF_PUSH;
	string NEXT_CL_LIGHT;
	string NEXT_CUSTOM_FLINCH;
	string NEXT_RAGE;
	string NEXT_REACH_SWING;
	string NEXT_STOMP;
	int NPC_GIVE_EXP;
	int NPC_MUST_SEE_TARGET;
	int NPC_NO_VADJ;
	int RANGE_FAR;
	int RANGE_MAX;
	int RANGE_NEAR;
	int RANGE_NORM;
	int RUN_STEP_COUNT;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_DEATH;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_STOMP;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SOUND_SWING;
	string SOUND_WARCRY1;
	string SOUND_WARCRY2;
	string STOMP_POINT;
	string WEAPON_TYPE;

	GiantFire()
	{
		ANIM_WALK = "cwalk";
		ANIM_IDLE = "creadyr_idle1";
		ANIM_RUN = "crun";
		ANIM_ATTACK = "ca1slashl";
		ANIM_DEATH = "ckdbck_death_p1";
		ANIM_IDLE_AGRO = "creadyl_idle2";
		ANIM_IDLE_NORM = "creadyr_idle1";
		ANIM_WARCRY = "ctaunt_alert";
		ANIM_ATTACK_NORM = "ca1slashl";
		ANIM_ATTACK_NEAR = "ccloseh_attack";
		ANIM_ATTACK_FAR = "creach";
		ANIM_ATTACK_STOMP = "cclosel_stomp";
		CUSTOM_ANIM_FLINCH = "cdamagel_flinch1";
		ATTACK_MOVERANGE = 80;
		MOVE_RANGE = 80;
		BPATROL_MOVEPROX = 90;
		NPC_GIVE_EXP = 4000;
		FREQ_STOMP = Random(10.0, 15.0);
		FREQ_REACH_SWING = Random(2.0, 5.0);
		RANGE_NEAR = 80;
		RANGE_NORM = 100;
		RANGE_FAR = 160;
		RANGE_MAX = 245;
		ATK_RAD = 196;
		ATTACK_RANGE = 80;
		ATTACK_HITRANGE = 320;
		NPC_MUST_SEE_TARGET = 0;
		NPC_NO_VADJ = 1;
		DMG_SWING = 200;
		DMG_STOMP = 300;
		DMG_DOT = 50;
		DMG_DOT2 = 150;
		SOUND_WARCRY1 = "monsters/earth/c_elemerth_bat1.wav";
		SOUND_WARCRY2 = "monsters/earth/c_elemerth_bat2.wav";
		SOUND_ATTACK1 = "monsters/earth/c_elemerth_atk1.wav";
		SOUND_ATTACK2 = "monsters/earth/c_elemerth_atk2.wav";
		SOUND_ATTACK3 = "monsters/earth/c_elemerth_atk3.wav";
		SOUND_SWING = "weapons/swinghuge.wav";
		SOUND_STOMP = "monsters/earth/c_elemerth_slct.wav";
		SOUND_STRUCK1 = "weapons/axemetal1.wav";
		SOUND_STRUCK2 = "weapons/axemetal2.wav";
		SOUND_STRUCK3 = "debris/concrete1.wav";
		SOUND_PAIN1 = "monsters/earth/c_elemerth_hit1.wav";
		SOUND_PAIN2 = "monsters/earth/c_elemerth_hit2.wav";
		SOUND_DEATH = "monsters/earth/c_elemerth_dead.wav";
		Precache(SOUND_DEATH);
	}

	void OnSpawn() override
	{
		SetName("Fire Giant Construct");
		SetModel("monsters/giant_fire.mdl");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetHeight(256);
		SetWidth(125);
		SetHearingSensitivity(4);
		PlayAnim("critical", ANIM_IDLE);
		if (!(true)) return;
		SetHealth(10000);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 1.5);
		SetDamageResistance("holy", 1.0);
		SetRace("demon");
		RUN_STEP_COUNT = 0;
		const int MY_HEIGHT = 256;
		SetRoam(true);
		ScheduleDelayedEvent(0.5, "pick_weapon");
		ScheduleDelayedEvent(2.0, "npc_finalize");
	}

	void pick_weapon()
	{
		if (WEAPON_TYPE == "WEAPON_TYPE")
		{
			WEAPON_TYPE = RandomInt(0, 2);
			SetModelBody(1, WEAPON_TYPE);
		}
	}

	void set_weapon_dblud()
	{
		WEAPON_TYPE = 0;
		SetModelBody(1, WEAPON_TYPE);
	}

	void set_weapon_earthbreak()
	{
		WEAPON_TYPE = 1;
		SetModelBody(1, WEAPON_TYPE);
	}

	void set_weapon_firebreak()
	{
		WEAPON_TYPE = 2;
		SetModelBody(1, WEAPON_TYPE);
	}

	void set_weapon_shockbreak()
	{
		WEAPON_TYPE = 3;
		SetModelBody(1, WEAPON_TYPE);
	}

	void npc_finalize()
	{
		HALF_HP = GetEntityMaxHealth(GetOwner());
		HALF_HP *= 0.5;
	}

	void npc_targetsighted()
	{
		if ((DID_INTRO))
		{
			if (GetGameTime() > NEXT_RAGE)
			{
			}
			SetMoveDest(m_hAttackTarget);
			npcatk_suspend_ai(1.0);
			PlayAnim("critical", ANIM_WARCRY);
			// PlayRandomSound from: SOUND_WARCRY1, SOUND_WARCRY2
			array<string> sounds = {SOUND_WARCRY1, SOUND_WARCRY2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			NEXT_RAGE = GetGameTime();
			NEXT_RAGE += Random(120.0, 240.0);
		}
		if ((DID_INTRO)) return;
		SetMoveDest(m_hAttackTarget);
		npcatk_suspend_ai(1.0);
		PlayAnim("critical", ANIM_WARCRY);
		// PlayRandomSound from: SOUND_WARCRY1, SOUND_WARCRY2
		array<string> sounds = {SOUND_WARCRY1, SOUND_WARCRY2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		NEXT_RAGE = GetGameTime();
		NEXT_RAGE += Random(120.0, 240.0);
		DID_INTRO = 1;
		NEXT_STOMP = GetGameTime();
		NEXT_STOMP += FREQ_STOMP;
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(255, 128, 0), 128, 30.0);
	}

	void npcatk_clear_targets()
	{
		NEXT_RAGE = GetGameTime();
		NEXT_RAGE += Random(20.0, 30.0);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (m_hAttackTarget == "unset")
		{
			SetIdleAnim(ANIM_IDLE_NORM);
		}
		if (!(m_hAttackTarget != "unset")) return;
		SetIdleAnim(ANIM_IDLE_AGRO);
		string TARG_RANGE = GetEntityRange(m_hAttackTarget);
		if (GetGameTime() > NEXT_CL_LIGHT)
		{
			ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(255, 128, 0), 128, 30.0);
			NEXT_CL_LIGHT = GetGameTime();
			NEXT_CL_LIGHT += 30.0;
		}
		if (GetGameTime() > NEXT_STOMP)
		{
			if (TARG_RANGE <= RANGE_NORM)
			{
				ANIM_ATTACK = ANIM_ATTACK_STOMP;
				ATTACK_RANGE = RANGE_NORM;
				ATTACK_HITRANGE = RANGE_NORM;
				DOING_STOMP = 1;
			}
		}
		if (TARG_RANGE > RANGE_FAR)
		{
			if (TARG_RANGE <= RANGE_MAX)
			{
			}
			if (GetGameTime() > NEXT_REACH_SWING)
			{
			}
			ANIM_ATTACK = ANIM_ATTACK_FAR;
			ATTACK_RANGE = RANGE_FAR;
			ATTACK_HITRANGE = RANGE_FAR;
			DOING_REACH_SWING = 1;
		}
		if (TARG_RANGE > RANGE_NEAR)
		{
			if (!(DOING_REACH_SWING))
			{
			}
			if (!(DOING_STOMP))
			{
			}
			ANIM_ATTACK = ANIM_ATTACK_NORM;
			ATTACK_RANGE = RANGE_NORM;
			ATTACK_HITRANGE = RANGE_NORM;
		}
		if (TARG_RANGE <= RANGE_NEAR)
		{
			if (!(DOING_REACH_SWING))
			{
			}
			if (!(DOING_STOMP))
			{
			}
			ANIM_ATTACK = ANIM_ATTACK_NEAR;
			ATTACK_RANGE = RANGE_NEAR;
			ATTACK_HITRANGE = RANGE_NEAR;
		}
		ATTACK_HITRANGE += MY_HEIGHT;
	}

	void frame_walk_step()
	{
		frame_run_step();
	}

	void frame_run_step()
	{
		RUN_STEP_COUNT += 1;
		if (RUN_STEP_COUNT == 1)
		{
			EmitSound(GetOwner(), 0, "monsters/troll/step1.wav", 10);
		}
		if (RUN_STEP_COUNT == 2)
		{
			EmitSound(GetOwner(), 0, "monsters/troll/step2.wav", 10);
			RUN_STEP_COUNT = 0;
		}
	}

	void set_patrol()
	{
		BPATROL_RAD = param1;
		BPATROL_ACTIVE = 1;
	}

	void frame_melee_strike()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		EmitSound(GetOwner(), 2, SOUND_SWING, 10);
		string IMPACT_POINT = /* TODO: $relpos */ $relpos(0, RANGE_NORM, 32);
		IMPACT_POINT = "z";
		IMPACT_POINT += "z";
		string L_DMG_SWING = DMG_SWING;
		if (WEAPON_TYPE == 1)
		{
			L_DMG_SWING *= 1.5;
		}
		XDoDamage(IMPACT_POINT, ATK_RAD, L_DMG_SWING, 0.1, GetOwner(), GetOwner(), "none", "dark", "dmgevent:normswing");
	}

	void normswing_dodamage()
	{
		if (!(param1)) return;
		float RND_LR = Random(-50.0, -10.0);
		float RND_FB = Random(0.0, 100.0);
		string PUSH_VEL = /* TODO: $relvel */ $relvel(RND_LR, RND_FB, 10);
		if (WEAPON_TYPE == 0)
		{
			ApplyEffect(param2, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), DMG_DOT);
		}
		if (WEAPON_TYPE == 2)
		{
			ApplyEffect(param2, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), DMG_DOT2);
		}
		if (WEAPON_TYPE == 3)
		{
			ApplyEffect(param2, "effects/dot_lightning", 5, GetEntityIndex(GetOwner()), DMG_DOT2);
		}
	}

	void frame_melee_strike2()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		EmitSound(GetOwner(), 2, SOUND_SWING, 10);
		string IMPACT_POINT = /* TODO: $relpos */ $relpos(0, RANGE_SHORT, 32);
		IMPACT_POINT = "z";
		IMPACT_POINT += "z";
		string L_DMG_SWING = DMG_SWING;
		if (WEAPON_TYPE == 1)
		{
			L_DMG_SWING *= 1.5;
		}
		XDoDamage(IMPACT_POINT, ATK_RAD, L_DMG_SWING, 0.1, GetOwner(), GetOwner(), "none", "blunt", "dmgevent:closeswing");
	}

	void closeswing_dodamage()
	{
		if (!(param1)) return;
		float RND_LR = Random(-50.0, 50.0);
		float RND_FB = Random(0.0, 50.0);
		string PUSH_VEL = /* TODO: $relvel */ $relvel(RND_LR, RND_FB, 10);
		AddVelocity(param2, PUSH_VEL);
		if (WEAPON_TYPE == 0)
		{
			ApplyEffect(param2, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), DMG_DOT);
		}
		if (WEAPON_TYPE == 2)
		{
			ApplyEffect(param2, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), DMG_DOT2);
		}
		if (WEAPON_TYPE == 3)
		{
			ApplyEffect(param2, "effects/dot_lightning", 5, GetEntityIndex(GetOwner()), DMG_DOT2);
		}
	}

	void frame_stomp()
	{
		EmitSound(GetOwner(), 0, SOUND_STOMP, 10);
		STOMP_POINT = /* TODO: $relpos */ $relpos(0, RANGE_NORM, 32);
		XDoDamage(STOMP_POINT, 256, DMG_STOMP, 0.2, GetOwner(), GetOwner(), "none", "blunt_effect", "dmgevent:stomp");
		STOMP_POINT = "z";
		if (WEAPON_TYPE == 0)
		{
			ClientEvent("new", "all", "effects/sfx_fire_burst", STOMP_POINT, 256, 0, Vector3(255, 0, 0));
		}
		if (WEAPON_TYPE == 1)
		{
			ClientEvent("new", "all", "effects/sfx_stun_burst", STOMP_POINT, 256, 0, 0);
		}
		if (WEAPON_TYPE == 2)
		{
			ClientEvent("new", "all", "effects/sfx_fire_burst", STOMP_POINT, 256, 1, Vector3(255, 128, 0));
		}
		if (WEAPON_TYPE == 3)
		{
			ClientEvent("new", "all", "effects/sfx_shock_burst", STOMP_POINT, 256, 1, Vector3(255, 255, 0));
		}
		NEXT_STOMP = GetGameTime();
		NEXT_STOMP += FREQ_STOMP;
		ANIM_ATTACK = ANIM_ATTACK_NORM;
		ATTACK_RANGE = RANGE_NORM;
		ATTACK_HITRANGE = RANGE_NORM;
		DOING_STOMP = 0;
	}

	void stomp_dodamage()
	{
		if (!(param1)) return;
		if ((IsValidPlayer(param2)))
		{
			if (!(IsOnGround(param2)))
			{
			}
			string EXIT_SUB = "";
		}
		if ((EXIT_SUB)) return;
		if (WEAPON_TYPE != 1)
		{
			ApplyEffect(param2, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
		}
		else
		{
			ApplyEffect(param2, "effects/debuff_stun", 10.0, GetEntityIndex(GetOwner()));
		}
		if (WEAPON_TYPE == 0)
		{
			ApplyEffect(param2, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), DMG_DOT);
		}
		if (WEAPON_TYPE == 2)
		{
			ApplyEffect(param2, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), DMG_DOT2);
		}
		if (WEAPON_TYPE == 3)
		{
			ApplyEffect(param2, "effects/dot_lightning", 5, GetEntityIndex(GetOwner()), DMG_DOT2);
		}
		string TARG_ORG = GetEntityOrigin(param2);
		string MY_ORG = STOMP_POINT;
		string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		string NEW_YAW = TARG_ANG;
		if ((NERF_PUSH))
		{
			int VEL_FB = 300;
		}
		else
		{
			int VEL_FB = 500;
		}
		SetVelocity(param2, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, VEL_FB, 110)));
	}

	void frame_reach_attack()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		EmitSound(GetOwner(), 2, SOUND_SWING, 10);
		string IMPACT_POINT = /* TODO: $relpos */ $relpos(0, RANGE_FAR, 32);
		IMPACT_POINT = "z";
		IMPACT_POINT += "z";
		XDoDamage(IMPACT_POINT, ATK_RAD, DMG_SWING, 0.1, GetOwner(), GetOwner(), "none", "dark", "dmgevent:reachswing");
		string L_IMPACT_POINT = IMPACT_POINT;
		L_IMPACT_POINT = "z";
		if (WEAPON_TYPE == 0)
		{
			ClientEvent("new", "all", "effects/sfx_fire_burst", L_IMPACT_POINT, ATK_RAD, 0, Vector3(255, 0, 0));
		}
		if (WEAPON_TYPE == 1)
		{
			ClientEvent("new", "all", "effects/sfx_stun_burst", L_IMPACT_POINT, ATK_RAD, 0, 0);
		}
		if (WEAPON_TYPE == 2)
		{
			ClientEvent("new", "all", "effects/sfx_fire_burst", L_IMPACT_POINT, ATK_RAD, 1, Vector3(255, 128, 0));
		}
		if (WEAPON_TYPE == 3)
		{
			ClientEvent("new", "all", "effects/sfx_shock_burst", L_IMPACT_POINT, ATK_RAD, 1, Vector3(255, 255, 0));
		}
		NEXT_REACH_SWING = GetGameTime();
		NEXT_REACH_SWING += FREQ_REACH_SWING;
		DOING_REACH_SWING = 0;
		ANIM_ATTACK = ANIM_ATTACK_NORM;
		ATTACK_RANGE = RANGE_NORM;
		ATTACK_HITRANGE = RANGE_NORM;
	}

	void reachswing_dodamage()
	{
		if (!(param1)) return;
		float RND_FB = Random(0.0, -150.0);
		string PUSH_VEL = /* TODO: $relvel */ $relvel(0, RND_FB, 110);
		AddVelocity(param2, PUSH_VEL);
		if (WEAPON_TYPE == 0)
		{
			ApplyEffect(param2, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), DMG_DOT);
		}
		if (WEAPON_TYPE == 1)
		{
			ApplyEffect(param2, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
		}
		if (WEAPON_TYPE == 2)
		{
			ApplyEffect(param2, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), DMG_DOT2);
		}
		if (WEAPON_TYPE == 3)
		{
			ApplyEffect(param2, "effects/dot_lightning", 5, GetEntityIndex(GetOwner()), DMG_DOT2);
		}
	}

	void OnDamage(int damage) override
	{
		if ((param3).findFirst("effect") >= 0)
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (!(GetEntityHealth(GetOwner()) < HALF_HEALTH)) return;
		if (!(GetGameTime() > NEXT_CUSTOM_FLINCH)) return;
		PlayAnim("critical", ANIM_CUSTOM_FLINCH);
		// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2
		array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		NEXT_CUSTOM_FLINCH = GetGameTime();
		NEXT_CUSTOM_FLINCH += Random(20.0, 30.0);
	}

	void set_nerf_push()
	{
		NERF_PUSH = 1;
	}

}

}
