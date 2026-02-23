#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjFlameJet : CGameScript
{
	string DMG_AMT;
	string DOT_AMT;
	string GAME_PVP;
	int IS_ACTIVE;
	string MY_CL_IDX;
	string NEXT_SCAN;
	string TARGET_LIST;
	string USE_SKILL;

	ProjFlameJet()
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
		const int SCAN_RANGE = 64;
		const float FREQ_SCAN = 0.5;
	}

	void arrow_spawn()
	{
		SetName("Jet of Flame");
		SetDescription("A streaming jet of flames");
		SetWeight(0);
		SetSize(1);
		SetValue(1);
		SetGravity(0.0001);
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 0);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renaderamt", 0);
		// svplaysound: svplaysound 1 10 monsters/goblin/sps_fogfire.wav
		EmitSound(1, 10, "monsters/goblin/sps_fogfire.wav");
		GAME_PVP = "game.pvp";
	}

	void game_fall()
	{
	}

	void game_projectile_hitnpc()
	{
		if (!(IsEntityAlive(param1))) return;
		if (!(GetRelationship(param1) == "enemy")) return;
		ApplyEffect(param1, "effects/dot_fire", 5.0, GetEntityIndex("ent_expowner"), DOT_AMT);
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
		DMG_AMT = GetEntityProperty("ent_expowner", "scriptvar");
		DOT_AMT = GetEntityProperty("ent_expowner", "scriptvar");
		USE_SKILL = GetEntityProperty("ent_expowner", "scriptvar");
		if (!(IsValidPlayer("ent_expowner")))
		{
			USE_SKILL = "none";
		}
		IS_ACTIVE = 1;
		ClientEvent("new", "all", "items/proj_flame_jet_cl", GetEntityIndex(GetOwner()), "xfireball3.spr");
		MY_CL_IDX = "game.script.last_sent_id";
		ScheduleDelayedEvent(0.01, "damage_area");
	}

	void damage_area()
	{
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "damage_area");
		LogDebug("damage_area DMG_AMT");
		XDoDamage(GetEntityOrigin(GetOwner()), 128, DMG_AMT, 0, "ent_expowner", "ent_expowner", USE_SKILL, "fire");
		if (!(GetGameTime() > NEXT_SCAN)) return;
		NEXT_SCAN = FREQ_SCAN;
		NEXT_SCAN += FREQ_SCAN;
		TARGET_LIST = FindEntitiesInSphere("any", 64);
	}

	void affect_targets()
	{
		string CUR_TARGET = GetToken(TARGET_LIST, i, ";");
		if (!(GetRelationship(CUR_TARGET) == "enemy")) return;
		ApplyEffect(CUR_TARGET, "effects/dot_fire", 5.0, GetEntityIndex("ent_expowner"), DOT_AMT);
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
			EmitSound(GetOwner(), 1, "monsters/goblin/sps_fogfire.wav", 0);
			IS_ACTIVE = 0;
			DeleteEntity(GetOwner());
		}
		RemoveScript();
	}

}

}
