#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_propelled.as"
#include "monsters/base_struck.as"
#include "monsters/base_flyer_grav.as"

namespace MS
{

class ElementalPureFire : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string ARCH_COUNT_GUIDED;
	int AS_SUMMON_TELE_CHECK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	string CL_IDX;
	string DID_INTRO;
	int DOT_STACK;
	int EFFECT_NO_GLOW_SHELLS;
	string ELEMENT_SEAL_IDX;
	float FREQ_SPECIAL;
	int GAME_NO_CORPSE;
	int IMMUNE_VAMPIRE;
	int IS_BLOODLESS;
	int IS_UNHOLY;
	int MOVE_RANGE;
	string NEXT_CL_REFRESH;
	string NEXT_LOOP_SOUND;
	string NEXT_SEAL;
	string NPC_GIVE_EXP;
	int NPC_HACKED_MOVE_SPEED;
	int NPC_NO_ATTACK;
	int PROJ_GUIDED;
	int PROJ_NO_SPRITES;
	string SEAL_POS;

	ElementalPureFire()
	{
		AS_SUMMON_TELE_CHECK = 1;
		EFFECT_NO_GLOW_SHELLS = 1;
		ANIM_IDLE = "idle1";
		ANIM_WALK = "idle1";
		ANIM_RUN = "idle1";
		ANIM_ATTACK = "attack1";
		ANIM_FLINCH = "flinch";
		ANIM_DEATH = "die1";
		ANIM_ATTACK = "attack1";
		const string ANIM_PROJECTILE = "fireball";
		IS_UNHOLY = 1;
		IS_BLOODLESS = 1;
		IMMUNE_VAMPIRE = 1;
		ATTACK_RANGE = 1024;
		ATTACK_HITRANGE = 1024;
		MOVE_RANGE = 512;
		NPC_HACKED_MOVE_SPEED = 100;
		const int MOVESPEED_SLOW = 100;
		const int MOVESPEED_FAST = 200;
		const string DMG_STRIKE = RandomInt(175, 250);
		const string DOT_STRIKE = RandomInt(60, 80);
		const float ACCURACY_STRIKE = 0.8;
		const string DMG_AMB_BURN = RandomInt(30, 60);
		FREQ_SPECIAL = 5.0;
		const int DMG_FIRE_BALL = 100;
		const int DMG_FIRE_BOLT = 20;
		const string SOUND_FIRECHARGE = "magic/fireball_powerup.wav";
		const string SOUND_FIRESHOOT = "magic/fireball_strike.wav";
		const string SOUND_FIRESHOOT2 = "weapons/rocketfire1.wav";
		const string SOUND_IDLE1 = "agrunt/ag_alert1.wav";
		const string SOUND_IDLE2 = "agrunt/ag_die1.wav";
		const string SOUND_IDLE3 = "agrunt/ag_idle1.wav";
		const string SOUND_SWIPE = "weapons/debris1.wav";
		const string SOUND_SWIPEHIT = "ambience/steamburst1.wav";
		const string SOUND_DEATH = "garg/gar_die1.wav";
		const string SOUND_PAIN1 = "debris/bustflesh2.wav";
		const string SOUND_PAIN2 = "agrunt/ag_pain1.wav";
		const string SOUND_PAIN3 = "agrunt/ag_pain4.wav";
		const string SOUND_GLOAT = "x/x_laugh1.wav";
		const int NPC_PITCH_PAIN = 1;
		const string SOUND_STRUCK1 = "bullchicken/bc_acid1.wav";
		const string SOUND_STRUCK2 = "bullchicken/bc_acid1.wav";
		const string SOUND_STRUCK3 = "ambience/flameburst1.wav";
		const int NPC_USE_FLINCH = 1;
		const float NPC_FLINCH_HEALTH_RATIO = 0.5;
		ANIM_FLINCH = "flinch";
		const float FREQ_CL_REFRESH = 5.0;
		const Vector3 ELM_COLOR = Vector3(255, 128, 0);
		const string ELM_TYPE = "fire";
		const int MELEE_RANGE = 96;
		const string CL_FX_SCRIPT = "monsters/elemental_pure_cl";
		const int ELEMENTAL_EXP = 500;
		NPC_GIVE_EXP = ELEMENTAL_EXP;
		const int DMG_BASE = 100;
		const string DOT1_SCRIPT = "effects/dot_fire";
		const string DOT1_ID = "DOT_fire";
		const float DOT1_DURATION = 5.0;
		const string DOT1_DMG = /* TODO: $math(multiply) */ DMG_BASE;
		const string DOT2_SCRIPT = "effects/dot_fire";
		const string DOT2_ID = "DOT_fire";
		const float DOT2_DURATION = 5.0;
		const string DOT2_DMG = /* TODO: $math(multiply) */ DMG_BASE;
		DOT_STACK = 0;
		const string PROJECTILE1_SCRIPT = "proj_fire_ball";
		const string PROJECTILE2_SCRIPT = "proj_fire_xolt";
		const string DMG_PROJ = DMG_BASE;
		PROJ_GUIDED = 1;
		PROJ_NO_SPRITES = 1;
		GAME_NO_CORPSE = 1;
	}

	void OnSpawn() override
	{
		p_elemental_spawn();
	}

	void p_elemental_spawn()
	{
		SetName("Pyron Archon");
		SetHealth(2500);
		SetWidth(48);
		SetHeight(80);
		SetRace("demon");
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("cold", 1.5);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("poison", 0.0);
		SetRoam(true);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(5);
		SetModel("monsters/elementals_greater.mdl");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 1);
		SetModelBody(0, 0);
		NPC_GIVE_EXP = 500;
		SetBloodType("none");
		if (ELM_TYPE == "fire")
		{
			ELEMENT_SEAL_IDX = 32;
		}
		else
		{
			if (ELM_TYPE == "cold")
			{
				ELEMENT_SEAL_IDX = 33;
			}
			else
			{
				if (ELM_TYPE == "lightning")
				{
					ELEMENT_SEAL_IDX = 34;
				}
			}
		}
		cl_refresh();
	}

	void npc_targetsighted()
	{
		if (!(DID_INTRO))
		{
			NEXT_SEAL = L_GAME_TIME;
			NEXT_SEAL += Random(20.0, 30.0);
			DID_INTRO = 1;
			cl_refresh();
		}
	}

	void bs_global_command()
	{
		LogDebug("bs_global_command GetEntityName(param1) PARAM2 PARAM3");
		if (!(param1 == m_hAttackTarget)) return;
		if (!(param3 == "death")) return;
		EmitSound(GetOwner(), 0, SOUND_GLOAT, 10);
		PlayAnim("critical", "yes");
		DID_INTRO = 0;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		string L_GAME_TIME = GetGameTime();
		if ((IsEntityAlive(GetOwner())))
		{
			SetProp(GetOwner(), "rendermode", 5);
			SetProp(GetOwner(), "renderamt", 1);
		}
		if (L_GAME_TIME > NEXT_CL_REFRESH)
		{
			cl_refresh();
		}
		if (L_GAME_TIME > NEXT_LOOP_SOUND)
		{
			NEXT_LOOP_SOUND = L_GAME_TIME;
			NEXT_LOOP_SOUND += 6.0;
			// svplaysound: svplaysound 2 0 ambience/alien_powernode.wav
			EmitSound(2, 0, "ambience/alien_powernode.wav");
			// svplaysound: svplaysound 2 10 ambience/alien_powernode.wav
			EmitSound(2, 10, "ambience/alien_powernode.wav");
		}
		if (!(m_hAttackTarget != "unset")) return;
		if (!(NPC_CANSEE_TARGET)) return;
		if ((I_R_FROZEN)) return;
		if (L_GAME_TIME > NEXT_SEAL)
		{
			if ((DID_INTRO))
			{
			}
			NEXT_SEAL = L_GAME_TIME;
			NEXT_SEAL += Random(20.0, 30.0);
			do_seal();
		}
		if (GetEntityRange(m_hAttackTarget) < MELEE_RANGE)
		{
			ANIM_ATTACK = "attack1";
		}
		else
		{
			ANIM_ATTACK = "fireball";
		}
		if (!(GetEntityRange(m_hAttackTarget) < 24)) return;
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, -110, 110));
	}

	void throw_fireball()
	{
		ARCH_COUNT_GUIDED += 1;
		if (ARCH_COUNT_GUIDED > 4)
		{
			EmitSound(GetOwner(), 0, SOUND_FIRESHOOT2, 10);
			ARCH_COUNT_GUIDED = 0;
			TossProjectile("view", 300, DMG_PROJ, 30, PROJECTILE2_SCRIPT, Vector3(0, 0, 64));
			CallExternal("ent_lastprojectile", "ext_render", 5, 255);
		}
		else
		{
			EmitSound(GetOwner(), 0, SOUND_FIRESHOOT, 10);
			string AIM_ANGLE = GetEntityDist(m_hAttackTarget);
			LogDebug("throw_fireball AIM_ANGLE");
			AIM_ANGLE /= 50;
			SetAngles("add_view.x");
			TossProjectile("view", 500, DMG_PROJ, 2, PROJECTILE1_SCRIPT, Vector3(0, 48, 48));
			CallExternal("ent_lastprojectile", "lighten", DOT1_DMG);
			CallExternal("ent_lastprojectile", "ext_render", 5, 255);
		}
	}

	void attack1_strike()
	{
		XDoDamage(m_hAttackTarget, 128, DMG_SWIPE, 90, GetOwner(), GetOwner(), "none", "fire_effect", "dmgevent:fist");
	}

	void fist_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 400, 110));
		if (DOT_STACK >= 4)
		{
			DOT_STACK = 0;
			apply_dot2(GetEntityIndex(param2));
		}
		else
		{
			apply_dot1(GetEntityIndex(param2));
		}
	}

	void apply_dot1()
	{
		if ((GetEntityProperty(param1, "haseffect")))
		{
			DOT_STACK += 1;
		}
		else
		{
			ApplyEffect(param1, DOT1_SCRIPT, DOT1_DURATION, GetEntityIndex(GetOwner()), DOT1_DMG);
		}
	}

	void apply_dot2()
	{
		if ((GetEntityProperty(param1, "haseffect"))) return;
		ApplyEffect(param1, DOT2_SCRIPT, DOT2_DURATION, GetEntityIndex(GetOwner()), DOT2_DMG);
	}

	void cl_refresh()
	{
		if (CL_IDX == "CL_IDX")
		{
			ClientEvent("new", "all", CL_FX_SCRIPT, GetEntityIndex(GetOwner()), ELM_COLOR, ELM_TYPE, FREQ_CL_REFRESH);
			CL_IDX = "game.script.last_sent_id";
		}
		else
		{
			ClientEvent("update", "all", CL_IDX, "end_fx");
			ClientEvent("new", "all", CL_FX_SCRIPT, GetEntityIndex(GetOwner()), ELM_COLOR, ELM_TYPE, FREQ_CL_REFRESH);
			CL_IDX = "game.script.last_sent_id";
		}
		NEXT_CL_REFRESH = GetGameTime();
		NEXT_CL_REFRESH += FREQ_CL_REFRESH;
	}

	void OnDamage(int damage) override
	{
		if ((param3).findFirst("slash") >= 0)
		{
			int L_NO_DMG = 1;
		}
		if ((param3).findFirst("blunt") >= 0)
		{
			int L_NO_DMG = 1;
		}
		if ((param3).findFirst("pierce") >= 0)
		{
			int L_NO_DMG = 1;
		}
		if ((param3).findFirst("generic") >= 0)
		{
			int L_NO_DMG = 1;
		}
		if (!(L_NO_DMG)) return;
		SetDamage("dmg");
		ReturnData(0.0);
		if ((IsValidPlayer(param1)))
		{
			SendColoredMessage(param1, "GetEntityName(GetOwner()) is immune to physical attacks!");
		}
	}

	void game_predeath()
	{
		ClientEvent("update", "all", CL_IDX, "owner_death");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		SetModel("null.mdl");
		// svplaysound: svplaysound 2 0 ambience/alien_powernode.wav
		EmitSound(2, 0, "ambience/alien_powernode.wav");
	}

	void do_seal()
	{
		npcatk_suspend_ai();
		npcatk_suspend_movement("charging");
		EmitSound(GetOwner(), 0, "weapons/egon_windup2.wav", 10);
		NPC_NO_ATTACK = 1;
		cl_refresh();
		SEAL_POS = GetEntityOrigin(m_hAttackTarget);
		SEAL_POS = "z";
		ClientEvent("new", "all", "effects/sfx_seal_warning", SEAL_POS, ELM_TYPE, 128, ELEMENT_SEAL_IDX, 2.0);
		ScheduleDelayedEvent(2.0, "do_seal2");
	}

	void do_seal2()
	{
		ClientEvent("new", "all", "effects/sfx_seal_instant", SEAL_POS, ELM_TYPE, 128, ELEMENT_SEAL_IDX);
		string L_DMG_TYPE = ELM_TYPE;
		L_DMG_TYPE += "_effect";
		XDoDamage(/* TODO: $math(vectoradd) */ SEAL_POS, 128, DMG_BASE, 0.0, GetOwner(), GetOwner(), "none", L_DMG_TYPE, "dmgevent:seal");
		npcatk_resume_ai();
		npcatk_resume_movement();
		NPC_NO_ATTACK = 0;
	}

	void seal_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		apply_dot2(GetEntityIndex(param2));
		if ((/* TODO: $inset_string */ $inset_string(ELM_TYPE, "fire", "lightning")))
		{
			string L_TARG_ORG = GetEntityOrigin(param2);
			string L_MY_ORG = SEAL_POS;
			string L_REPEL_YAW = /* TODO: $angles */ $angles(L_MY_ORG, L_TARG_ORG);
			AddVelocity(param2, /* TODO: $relvel */ $relvel(Vector3(0, L_REPEL_YAW, 0), Vector3(0, 600, 600)));
		}
	}

}

}
