#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowSpiral : CGameScript
{
	string CL_GLOW_COLOR;
	string CL_SPRITE_COLOR;
	string CL_SPRITE_FILE;
	string CL_SPRITE_FRAMES;
	string CL_SPRITE_SCALE;
	string DMG_AMT;
	string DMG_TYPE;
	string GAME_PVP;
	int IS_ACTIVE;
	string MY_CL_IDX;
	string USE_SKILL;

	ProjArrowSpiral()
	{
		const string MODEL_HANDS = "weapons/projectiles.mdl";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int ARROW_BODY_OFS = 1;
		const string PROJ_ANIM_IDLE = "idle_iceball";
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const int HITWALL_VOL = 2;
		const int PROJ_MOTIONBLUR = 0;
		const int MODEL_BODY_OFS = 1;
		const int PROJ_DAMAGE = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_SOLIDIFY_ON_WALL = 0;
		const int PROJ_DAMAGE_AOE_RANGE = 0;
		const int PROJ_DAMAGE_AOE_FALLOFF = 1;
		const string PROJ_DAMAGE_TYPE = "cold";
		const int PROJ_COLLIDEHITBOX = 1;
		const int PROJ_IGNORENPC = 1;
		const string PROJ_ANIM_IDLE = "none";
		const int SCAN_RANGE = 96;
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
