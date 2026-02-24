#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowSpiral : CGameScript
{
	int ARROW_BODY_OFS;
	int ARROW_SOLIDIFY_ON_WALL;
	string CL_GLOW_COLOR;
	string CL_SPRITE_COLOR;
	string CL_SPRITE_FILE;
	string CL_SPRITE_FRAMES;
	string CL_SPRITE_SCALE;
	string DMG_AMT;
	string DMG_TYPE;
	string GAME_PVP;
	int HITWALL_VOL;
	int IS_ACTIVE;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string MY_CL_IDX;
	string PROJ_ANIM_IDLE;
	int PROJ_COLLIDEHITBOX;
	int PROJ_DAMAGE;
	int PROJ_DAMAGE_AOE_FALLOFF;
	int PROJ_DAMAGE_AOE_RANGE;
	string PROJ_DAMAGE_TYPE;
	int PROJ_IGNORENPC;
	int PROJ_MOTIONBLUR;
	int PROJ_SOLIDIFY_ON_WALL;
	int PROJ_STICK_DURATION;
	int SCAN_RANGE;
	string USE_SKILL;

	ProjArrowSpiral()
	{
		MODEL_HANDS = "weapons/projectiles.mdl";
		MODEL_WORLD = "weapons/projectiles.mdl";
		ARROW_BODY_OFS = 1;
		PROJ_ANIM_IDLE = "idle_iceball";
		ARROW_SOLIDIFY_ON_WALL = 0;
		HITWALL_VOL = 2;
		PROJ_MOTIONBLUR = 0;
		MODEL_BODY_OFS = 1;
		PROJ_DAMAGE = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_SOLIDIFY_ON_WALL = 0;
		PROJ_DAMAGE_AOE_RANGE = 0;
		PROJ_DAMAGE_AOE_FALLOFF = 1;
		PROJ_DAMAGE_TYPE = "cold";
		PROJ_COLLIDEHITBOX = 1;
		PROJ_IGNORENPC = 1;
		PROJ_ANIM_IDLE = "none";
		SCAN_RANGE = 96;
	}

	void arrow_spawn()
	{
		SetName("Freezing Sphere");
		SetDescription("A large ball of freezing magiks");
		SetWeight(0);
		SetSize(1);
		SetValue(1);
		SetGravity(0.0001);
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 0);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renaderamt", 0);
		// svplaysound: svplaysound 1 10 ambience/alien_hollow.wav
		EmitSound(1, 10, "ambience/alien_hollow.wav");
		GAME_PVP = "game.pvp";
	}

	void game_fall()
	{
	}

	void game_projectile_hitnpc()
	{
	}

	void game_projectile_landed()
	{
		remove_me();
	}

	void game_projectile_hitwall()
	{
		remove_me();
		remove_me();
	}

	void game_tossprojectile()
	{
		ScheduleDelayedEvent(10.0, "remove_me");
		if (!(true)) return;
		DMG_TYPE = GetEntityProperty("ent_expowner", "scriptvar");
		DMG_AMT = GetEntityProperty("ent_expowner", "scriptvar");
		CL_SPRITE_FILE = GetEntityProperty("ent_expowner", "scriptvar");
		CL_SPRITE_FRAMES = GetEntityProperty("ent_expowner", "scriptvar");
		CL_SPRITE_SCALE = GetEntityProperty("ent_expowner", "scriptvar");
		CL_SPRITE_COLOR = GetEntityProperty("ent_expowner", "scriptvar");
		CL_GLOW_COLOR = GetEntityProperty("ent_expowner", "scriptvar");
		if (!(IsValidPlayer("ent_expowner")))
		{
			USE_SKILL = "none";
		}
		else
		{
			USE_SKILL = GetEntityProperty("ent_expowner", "scriptvar");
		}
		IS_ACTIVE = 1;
		ClientEvent("new", "all", "items/proj_arrow_spiral_cl", GetEntityIndex(GetOwner()), CL_SPRITE_FILE, CL_SPRITE_FRAMES, CL_SPRITE_SCALE, CL_SPRITE_COLOR, CL_GLOW_COLOR);
		MY_CL_IDX = "game.script.last_sent_id";
		ScheduleDelayedEvent(0.01, "damage_area");
	}

	void damage_area()
	{
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "damage_area");
		XDoDamage(GetEntityOrigin(GetOwner()), 128, DMG_AMT, 0, "ent_expowner", "ent_expowner", USE_SKILL, DMG_TYPE, "dmgevent:spiral");
	}

	void remove_me()
	{
		if ((true))
		{
			if (!(IsValidPlayer("ent_expowner")))
			{
				CallExternal("ent_expowner", "ext_spiral_done");
			}
			ClientEvent("update", "all", MY_CL_IDX, "end_fx");
			IS_ACTIVE = 0;
			DeleteEntity(GetOwner());
		}
		RemoveScript();
	}

}

}
