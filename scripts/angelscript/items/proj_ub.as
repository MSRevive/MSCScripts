#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjUb : CGameScript
{
	int ARROW_BODY_OFS;
	int ARROW_SOLIDIFY_ON_WALL;
	string DMG_AMT;
	int HITWALL_VOL;
	int IS_ACTIVE;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;
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
	string WEAPON_ID;

	ProjUb()
	{
		MODEL_HANDS = "weapons/projectiles.mdl";
		MODEL_WORLD = "weapons/projectiles.mdl";
		ARROW_BODY_OFS = 36;
		PROJ_ANIM_IDLE = "spin_vertical_fast";
		ARROW_SOLIDIFY_ON_WALL = 0;
		HITWALL_VOL = 2;
		PROJ_MOTIONBLUR = 0;
		MODEL_BODY_OFS = 36;
		PROJ_DAMAGE = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_SOLIDIFY_ON_WALL = 0;
		PROJ_DAMAGE_AOE_RANGE = 0;
		PROJ_DAMAGE_AOE_FALLOFF = 1;
		PROJ_DAMAGE_TYPE = "dark";
		PROJ_COLLIDEHITBOX = 1;
		PROJ_IGNORENPC = 1;
		PROJ_ANIM_IDLE = "none";
		SCAN_RANGE = 32;
	}

	void arrow_spawn()
	{
		SetName("Unholy Blade");
		SetDescription("Shadow projectile of the Unholy Blade");
		SetWeight(0);
		SetSize(1);
		SetValue(1);
		SetGravity(0.0001);
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 36);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		// svplaysound: svplaysound 1 10 fans/fan1.wav
		EmitSound(1, 10, "fans/fan1.wav");
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
		if (!(IsValidPlayer("ent_expowner")))
		{
			DMG_AMT = GetEntityProperty("ent_expowner", "scriptvar");
			WEAPON_ID = GetEntityIndex("ent_expowner");
		}
		else
		{
			DMG_AMT = GetSkillLevel("ent_expowner", "spellcasting.affliction");
			DMG_AMT *= 8;
			WEAPON_ID = GetEntityProperty("ent_expowner", "scriptvar");
			LogDebug("game_tossprojectile WEAPON_ID");
			CallExternal(WEAPON_ID, "ext_register_projectile", GetEntityIndex(GetOwner()));
		}
		IS_ACTIVE = 1;
		ScheduleDelayedEvent(0.01, "damage_area");
	}

	void damage_area()
	{
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(0.2, "damage_area");
		XDoDamage(GetEntityOrigin(GetOwner()), SCAN_RANGE, DMG_AMT, 0.1, "ent_expowner", WEAPON_ID, "swordsmanship", "dark");
	}

	void remove_me()
	{
		if ((true))
		{
			if (!(IsValidPlayer("ent_expowner")))
			{
				CallExternal("ent_expowner", "ext_ub_done");
			}
			else
			{
				string SPR_POS = GetEntityOrigin("ent_expowner");
				string OWNER_YAW = GetEntityProperty("ent_expowner", "angles.yaw");
				SPR_POS += /* TODO: $relpos */ $relpos(Vector3(0, OWNER_YAW, 0), Vector3(10, 32, 20));
				ClientEvent("new", "all", "items/proj_ub_cl", GetEntityOrigin(GetOwner()), SPR_POS);
				if (param1 != "remote")
				{
				}
				CallExternal(GetEntityProperty("ent_expowner", "scriptvar"), "ext_projectile_landed");
			}
			IS_ACTIVE = 0;
			// svplaysound: svplaysound 1 0 fans/fan1.wav
			EmitSound(1, 0, "fans/fan1.wav");
			DeleteEntity(GetOwner());
		}
		RemoveScript();
	}

}

}
