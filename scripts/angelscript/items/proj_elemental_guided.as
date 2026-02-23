#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjElementalGuided : CGameScript
{
	int ACQUIRE_MODE;
	string CLOUD_SPRITE;
	string CL_COLOR;
	string CL_IDX;
	string CL_SCRIPT;
	int DID_LAND;
	string ELEMENT_TYPE;
	float FREQ_UPDATE;
	int FWD_SPEED;
	string GAME_PVP;
	int IS_ACTIVE;
	float MAX_DURATION;
	string NPCATK_TARGET;
	string SOUND_EXPLODE;
	string SOUND_LOOP;
	int SOUND_VOL;
	string TARG_ISPLAYER;

	ProjElementalGuided()
	{
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int PROJ_DAMAGE = 0;
		const int PROJ_AOE_RANGE = 128;
		const int PROJ_AOE_FALLOFF = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_SOLIDIFY_ON_WALL = 0;
		const int PROJ_COLLIDEHITBOX = 1;
		const int PROJ_MOTIONBLUR = 0;
		FWD_SPEED = 200;
		MAX_DURATION = 10.0;
	}

	void arrow_spawn()
	{
		SetName("Elemental Cloud");
		SetDescription("This may explode");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.0);
		SetGroupable(25);
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 0);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
	}

	void game_tossprojectile()
	{
		LogDebug("game_tossprojectile");
		GAME_PVP = "game.pvp";
		ELEMENT_TYPE = GetEntityProperty("ent_expowner", "scriptvar");
		NPCATK_TARGET = GetEntityProperty("ent_expowner", "scriptvar");
		string L_ALT_SPEED = GetEntityProperty("ent_expowner", "scriptvar");
		if (L_ALT_SPEED > 0)
		{
			FWD_SPEED = L_ALT_SPEED;
		}
		string L_ALT_DURATION = GetEntityProperty("ent_expowner", "scriptvar");
		if (L_ALT_DURATION > 0)
		{
			MAX_DURATION = L_ALT_DURATION;
		}
		MAX_DURATION("end_projectile");
		TARG_ISPLAYER = IsValidPlayer(m_hAttackTarget);
		SOUND_VOL = 5;
		CLOUD_SPRITE = "3dmflagry.spr";
		FREQ_UPDATE = 0.5;
		CL_SCRIPT = "items/proj_elemental_cl";
		if (ELEMENT_TYPE == "fire")
		{
			CL_COLOR = Vector3(255, 64, 0);
			SOUND_LOOP = "magic/sps_fogfire.wav";
			SOUND_EXPLODE = "weapons/explode3.wav";
		}
		else
		{
			if (ELEMENT_TYPE == "fire_jet")
			{
				CL_COLOR = Vector3(255, 128, 64);
				SOUND_LOOP = "magic/sps_fogfire.wav";
				SOUND_EXPLODE = "weapons/explode3.wav";
				CLOUD_SPRITE = "xfireball3.spr";
				FREQ_UPDATE = 1.0;
				CL_SCRIPT = "items/proj_flamejet_guided_cl";
			}
			else
			{
				if (ELEMENT_TYPE == "cold")
				{
					CL_COLOR = Vector3(128, 128, 255);
					SOUND_LOOP = "magic/cold_breath.wav";
					SOUND_EXPLODE = "magic/freeze.wav";
				}
				else
				{
					if (ELEMENT_TYPE == "lightning")
					{
						CL_COLOR = Vector3(255, 255, 0);
						SOUND_LOOP = "magic/bolt_loop.wav";
						SOUND_EXPLODE = "magic/lightning_strike2.wav";
						SOUND_VOL = 5;
					}
					else
					{
						if (ELEMENT_TYPE == "poison")
						{
							CL_COLOR = Vector3(0, 255, 0);
							SOUND_LOOP = "magic/flame_loop.wav";
							SOUND_EXPLODE = "ambience/steamburst1.wav";
							SOUND_VOL = 5;
						}
					}
				}
			}
		}
		IS_ACTIVE = 1;
		ACQUIRE_MODE = 1;
		// svplaysound: svplaysound 2 SOUND_VOL SOUND_LOOP
		EmitSound(2, SOUND_VOL, SOUND_LOOP);
		ScheduleDelayedEvent(0.05, "cl_start");
		ScheduleDelayedEvent(0.1, "projectile_loop");
	}

	void cl_start()
	{
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		ClientEvent("new", "all", CL_SCRIPT, GetEntityIndex(GetOwner()), GetEntityAngles(GetOwner()), GetEntityVelocity(GetOwner()), CL_COLOR, MAX_DURATION, CLOUD_SPRITE);
		CL_IDX = "game.script.last_sent_id";
	}

	void projectile_loop()
	{
		if (!(IS_ACTIVE)) return;
		FREQ_UPDATE("projectile_loop");
		if (!(IsEntityAlive(m_hAttackTarget)))
		{
			ACQUIRE_MODE = 0;
		}
		string MY_ORG = GetEntityOrigin(GetOwner());
		if (!(IsEntityAlive(m_hAttackTarget)))
		{
			if (DRIFT_DIR == 0)
			{
				int L_HOFS = -50;
				DRIFT_DIR = 1;
			}
			else
			{
				int L_HOFS = 50;
				DRIFT_DIR = 0;
			}
			string TARG_ORG = MY_ORG;
			string MY_ANG = GetEntityAngles(GetOwner());
			TARG_ORG += /* TODO: $relpos */ $relpos(MY_ANG, Vector3(DRIFT_DIR, FWD_SPEED, 0));
		}
		else
		{
			string TARG_ORG = GetEntityOrigin(m_hAttackTarget);
			if (!(TARG_ISPLAYER))
			{
				TARG_ORG += "z";
			}
		}
		string ANG_TO_TARG = /* TODO: $angles3d */ $angles3d(MY_ORG, TARG_ORG);
		ANG_TO_TARG = "x";
		SetProp(GetOwner(), "velocity", /* TODO: $relvel */ $relvel(ANG_TO_TARG, Vector3(0, FWD_SPEED, 0)));
		SetProp(GetOwner(), "movedir", ANG_TO_TARG);
		ClientEvent("update", "all", CL_IDX, "sv_update_vel", GetEntityAngles(GetOwner()), GetEntityVelocity(GetOwner()), GetEntityOrigin(GetOwner()));
	}

	void game_projectile_landed()
	{
		DID_LAND = 1;
		end_projectile();
	}

	void end_projectile()
	{
		IS_ACTIVE = 0;
		// svplaysound: svplaysound 2 0 SOUND_LOOP
		EmitSound(2, 0, SOUND_LOOP);
		ClientEvent("update", "all", CL_IDX, "proj_explode");
		EmitSound(GetOwner(), 0, SOUND_EXPLODE, 10);
		CallExternal("ent_expowner", "ext_proj_elemental_hit", GetEntityOrigin(GetOwner()), ELEMENT_TYPE);
	}

}

}
