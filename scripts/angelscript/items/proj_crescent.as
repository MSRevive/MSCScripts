#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjCrescent : CGameScript
{
	string CL_IDX;
	string CRE_EFFECT_DURATION;
	string CRE_EFFECT_NAME;
	string CRE_EFFECT_RATIO;
	string CRE_EFFECT_SCRIPT;
	string CRE_EFFECT_SKILL;
	string CRE_TYPE;
	int DID_LAND;
	string DMG_AMT;
	string GAME_PVP;
	int IS_ACTIVE;
	string NEXT_ACQUIRE;
	string NEXT_ANGLE_UPDATE;
	string NEXT_DAMAGE;
	string NPCATK_TARGET;
	string OWNER_ISPLAYER;
	string PLR_CRE_HAND;
	string START_ANG;
	string START_POS;
	int SWIRVE_CYCLE;
	string USE_SKILL;

	ProjCrescent()
	{
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int MODEL_BODY_OFS = 0;
		const int ARROW_BODY_OFS = 0;
		const string SOUND_HITWALL1 = "weapons/axemetal1.wav";
		const string SOUND_HITWALL2 = "weapons/axemetal1.wav";
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 1.0;
		const string ITEM_NAME = "watermana";
		const string PROJ_DAMAGE_TYPE = "slash";
		const string PROJ_DAMAGESTAT = "spellcasting.ice";
		const string PROJ_ANIM_IDLE = "spin_vertical_fast";
		const int PROJ_MOTIONBLUR = 0;
		const int PROJ_DAMAGE = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_COLLIDEHITBOX = 0;
		const int PROJ_IGNORENPC = 1;
		const int FWD_SPEED = 400;
		const string SOUND_SPIN = "zombie/claw_miss2.wav";
	}

	void arrow_spawn()
	{
		SetName("Whirling Crescent Blade");
		SetDescription("A sharp bolt of ice");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.0);
		SetGroupable(25);
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 0);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renaderamt", 0);
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if (!(GetGameTime() > NEXT_DAMAGE)) return;
		NEXT_DAMAGE = GetGameTime();
		NEXT_DAMAGE += 0.1;
		XDoDamage(param1, "direct", DMG_AMT, 1.0, "ent_expowner", "ent_expowner", USE_SKILL, CRE_TYPE);
		if (!(IsValidPlayer("ent_expowner"))) return;
		if (!(CRE_TYPE != "slash")) return;
		if ((IsValidPlayer(param1)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((GetEntityProperty(param1, "haseffect"))) return;
		string DOT_AMT = GetEntityProperty("ent_expowner", "cre_effect_skill");
		DOT_AMT *= CRE_EFFECT_RATIO;
		ApplyEffect(param1, CRE_EFFECT_SCRIPT, CRE_EFFECT_DURATION, GetEntityIndex("ent_expowner"), DOT_AMT, "smallarms");
	}

	void game_tossprojectile()
	{
		LogDebug("game_tossprojectile");
		GAME_PVP = "game.pvp";
		CRE_TYPE = GetEntityProperty("ent_expowner", "scriptvar");
		if (CRE_TYPE == "fire")
		{
			CRE_EFFECT_SCRIPT = "effects/dot_fire";
			CRE_EFFECT_SKILL = "skill.spellcasting.fire";
			CRE_EFFECT_RATIO = 0.5;
			CRE_EFFECT_NAME = "DOT_fire";
			CRE_EFFECT_DURATION = 5.0;
		}
		if (CRE_TYPE == "cold")
		{
			CRE_EFFECT_SCRIPT = "effects/dot_cold";
			CRE_EFFECT_SKILL = "skill.spellcasting.ice";
			CRE_EFFECT_RATIO = 0.25;
			CRE_EFFECT_NAME = "DOT_cold";
			CRE_EFFECT_DURATION = 5.0;
		}
		if (CRE_TYPE == "lightning")
		{
			CRE_EFFECT_SCRIPT = "effects/dot_lightning";
			CRE_EFFECT_SKILL = "skill.spellcasting.lightning";
			CRE_EFFECT_RATIO = 0.4;
			CRE_EFFECT_NAME = "DOT_lightning";
			CRE_EFFECT_DURATION = 5.0;
		}
		if (CRE_TYPE == "poison")
		{
			CRE_EFFECT_SCRIPT = "effects/dot_poison";
			CRE_EFFECT_SKILL = "skill.spellcasting.affliction";
			CRE_EFFECT_RATIO = 0.3;
			CRE_EFFECT_NAME = "DOT_poison";
			CRE_EFFECT_DURATION = 10.0;
		}
		// TODO: projectiletouch 1
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renaderamt", 0);
		IS_ACTIVE = 1;
		OWNER_ISPLAYER = IsValidPlayer("ent_expowner");
		if ((OWNER_ISPLAYER))
		{
			DMG_AMT = GetSkillLevel("ent_expowner", "smallarms.power");
			DMG_AMT *= 2.0;
			USE_SKILL = "smallarms";
			START_ANG = GetEntityProperty("ent_expowner", "viewangles");
			PLR_CRE_HAND = GetEntityProperty("ent_expowner", "scriptvar");
		}
		else
		{
			DMG_AMT = GetEntityProperty("ent_expowner", "scriptvar");
			START_ANG = GetEntityAngles("ent_expowner");
			USE_SKILL = "none";
		}
		SWIRVE_CYCLE = 0;
		SetProp(GetOwner(), "velocity", /* TODO: $relvel */ $relvel(START_ANG, Vector3(0, FWD_SPEED, 0)));
		SetProp(GetOwner(), "movedir", START_ANG);
		NEXT_ACQUIRE = GetGameTime();
		NEXT_ACQUIRE += 0.5;
		ScheduleDelayedEvent(0.05, "cl_start");
		ScheduleDelayedEvent(0.1, "projectile_loop");
		ScheduleDelayedEvent(3.0, "end_projectile");
	}

	void cl_start()
	{
		START_POS = GetEntityOrigin(GetOwner());
		ClientEvent("new", "all", "items/proj_crescent_cl", GetEntityIndex(GetOwner()), GetEntityAngles(GetOwner()), GetEntityVelocity(GetOwner()), GetEntityOrigin(GetOwner()));
		CL_IDX = "game.script.last_sent_id";
	}

	void projectile_loop()
	{
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(0.5, "projectile_loop");
		// svplaysound: svplaysound 2 10 SOUND_SPIN 0.8 200
		EmitSound(2, 10, SOUND_SPIN, 0.8, 200);
		if (!(IsEntityAlive(m_hAttackTarget)))
		{
			if (GetGameTime() > NEXT_ACQUIRE)
			{
			}
			NEXT_ACQUIRE = GetGameTime();
			NEXT_ACQUIRE += 2.0;
			CallExternal("ent_expowner", "ext_sphere_token", "enemy", 1024, GetEntityOrigin(GetOwner()));
			string TARG_LIST = GetEntityProperty("ent_expowner", "scriptvar");
			if (TARG_LIST != "none")
			{
			}
			string TARG_LIST = /* TODO: $sort_entlist */ $sort_entlist(TARG_LIST, "range");
			NPCATK_TARGET = GetToken(TARG_LIST, 0, ";");
			string TARG_POS = GetEntityOrigin(m_hAttackTarget);
			string OWNER_POS = GetEntityOrigin("ent_expowner");
			string OWNER_ANG = START_ANG;
			if (!(WithinCone2D(TARG_POS, OWNER_POS, OWNER_ANG)))
			{
				NPCATK_TARGET = "unset";
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if (!(IsValidPlayer(m_hAttackTarget)))
			{
				TARG_HALF_HEIGHT = GetEntityHeight(m_hAttackTarget);
				TARG_HALF_HEIGHT *= 0.5;
			}
			else
			{
				TARG_HALF_HEIGHT = 0;
			}
		}
		if (!(GetGameTime() > NEXT_ANGLE_UPDATE)) return;
		NEXT_ANGLE_UPDATE = GetGameTime();
		NEXT_ANGLE_UPDATE += 0.1;
		if ((IsEntityAlive(m_hAttackTarget)))
		{
			if (RandomInt(1, 2) < 100)
			{
				string TARG_ORG = GetEntityOrigin(m_hAttackTarget);
				TARG_ORG += "z";
				string MY_ORG = GetEntityOrigin(GetOwner());
				string ANG_TO_TARG = /* TODO: $angles3d */ $angles3d(MY_ORG, TARG_ORG);
				ANG_TO_TARG = "x";
				SetProp(GetOwner(), "velocity", /* TODO: $relvel */ $relvel(ANG_TO_TARG, Vector3(0, FWD_SPEED, 0)));
				SetProp(GetOwner(), "movedir", ANG_TO_TARG);
				if (GetEntityRange(m_hAttackTarget) < 64)
				{
					LogDebug("range_check GetEntityRange(m_hAttackTarget)");
					NEXT_ANGLE_UPDATE = GetGameTime();
					NEXT_ANGLE_UPDATE += 0.9;
					ScheduleDelayedEvent(1.0, "return_user");
				}
			}
		}
		ClientEvent("update", "all", CL_IDX, "sv_update_vel", GetEntityAngles(GetOwner()), GetEntityVelocity(GetOwner()), GetEntityOrigin(GetOwner()));
	}

	void return_user()
	{
		NPCATK_TARGET = GetEntityIndex("ent_expowner");
	}

	void cl_update()
	{
		ClientEvent("update", "all", CL_IDX, "sv_update_vel", GetEntityAngles(GetOwner()), GetEntityVelocity(GetOwner()), GetEntityOrigin(GetOwner()));
	}

	void swirve_wander()
	{
		SWIRVE_CYCLE += 1;
		if (SWIRVE_CYCLE == 1)
		{
			int L_SWIRVE = -64;
		}
		if (SWIRVE_CYCLE == 2)
		{
			int L_SWIRVE = 64;
			SWIRVE_CYCLE = 0;
		}
		string MY_ORG = GetEntityOrigin(GetOwner());
		string TARG_ORG = GetEntityOrigin(GetOwner());
		TARG_ORG += /* TODO: $relpos */ $relpos(START_ANG, Vector3(L_SWIRVE, 200, 0));
		string ANG_TO_TARG = /* TODO: $angles3d */ $angles3d(MY_ORG, TARG_ORG);
		ANG_TO_TARG = "x";
		SetProp(GetOwner(), "velocity", /* TODO: $relvel */ $relvel(ANG_TO_TARG, Vector3(0, FWD_SPEED, 0)));
	}

	void game_projectile_landed()
	{
		DID_LAND = 1;
		end_projectile();
	}

	void end_projectile()
	{
		ClientEvent("update", "all", CL_IDX, "end_fx");
		if (!(OWNER_ISPLAYER))
		{
			CallExternal("ent_expowner", "ext_crescent_done");
			string SPR_POS = GetEntityOrigin("ent_expowner");
			string OWNER_ANG = GetEntityAngles("ent_expowner");
			ClientEvent("new", "all", "items/proj_ub_cl", GetEntityOrigin(GetOwner()), SPR_POS);
		}
		else
		{
			string SPR_POS = GetEntityOrigin("ent_expowner");
			string OWNER_YAW = GetEntityProperty("ent_expowner", "angles.yaw");
			if (PLR_CRE_HAND == 1)
			{
				SPR_POS += /* TODO: $relpos */ $relpos(Vector3(0, OWNER_YAW, 0), Vector3(10, 32, 20));
			}
			else
			{
				SPR_POS += /* TODO: $relpos */ $relpos(Vector3(0, OWNER_YAW, 0), Vector3(-10, 32, 20));
			}
			ClientEvent("new", "all", "items/proj_ub_cl", GetEntityOrigin(GetOwner()), SPR_POS);
		}
		if ((DID_LAND)) return;
		DeleteEntity(GetOwner());
	}

}

}
