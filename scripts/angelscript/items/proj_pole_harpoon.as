#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjPoleHarpoon : CGameScript
{
	int ARROW_BODY_OFS;
	float ARROW_BREAK_CHANCE;
	int ARROW_EXPIRE_DELAY;
	int ARROW_SOLIDIFY_ON_WALL;
	int ARROW_STICK_DURATION;
	string GAME_PVP;
	string ITEM_NAME;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string PROJ_ANIM_IDLE;
	int PROJ_AOE_FALLOFF;
	int PROJ_AOE_RANGE;
	int PROJ_COLLIDE;
	int PROJ_DAMAGE;
	string PROJ_DAMAGESTAT;
	string PROJ_DAMAGE_TYPE;
	int PROJ_MOTIONBLUR;
	int PROJ_STICK_DURATION;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;

	ProjPoleHarpoon()
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "weapons/projectiles.mdl";
		MODEL_BODY_OFS = 58;
		ARROW_BODY_OFS = 58;
		ARROW_STICK_DURATION = 5;
		ARROW_EXPIRE_DELAY = 2;
		SOUND_HITWALL1 = "weapons/xbow_hit1.wav";
		SOUND_HITWALL2 = "weapons/xbow_hit1.wav";
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 1.0;
		ITEM_NAME = "watermana";
		PROJ_DAMAGE_TYPE = "pierce";
		PROJ_DAMAGESTAT = "spellcasting.ice";
		PROJ_ANIM_IDLE = "idle_standard";
		PROJ_MOTIONBLUR = 1;
		PROJ_DAMAGE = 0;
		PROJ_AOE_RANGE = 0;
		PROJ_AOE_FALLOFF = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_COLLIDE = 1;
	}

	void arrow_spawn()
	{
		SetName("Harpoon");
		SetDescription("This was probably meant for a whale");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.8);
		SetGroupable(25);
	}

	void game_tossprojectile()
	{
		GAME_PVP = "game.pvp";
	}

	void game_projectile_hitnpc()
	{
		if ((IsValidPlayer(param1)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		int L_DMG = 175;
		string OWNER_SKILL_RATIO = GetSkillLevel("ent_expowner", "polearms");
		OWNER_SKILL_RATIO *= 0.01;
		L_DMG *= OWNER_SKILL_RATIO;
		string CHARGE_LEVEL = GetEntityProperty("ent_expowner", "scriptvar");
		int PUSH_STR = 800;
		PUSH_STR *= CHARGE_LEVEL;
		LogDebug("game_projectile_hitnpc CHARGE_LEVEL");
		CHARGE_LEVEL *= 3.0;
		CHARGE_LEVEL += 1.0;
		L_DMG *= CHARGE_LEVEL;
		string TARG_ORG = GetEntityOrigin(param1);
		string OWNER_ORG = GetEntityOrigin("ent_expowner");
		float TARG_DIST = Distance(OWNER_ORG, TARG_ORG);
		if (TARG_DIST < 256)
		{
			string DIST_RATIO = TARG_DIST;
			DIST_RATIO /= 256;
			LogDebug("too_close DIST_RATIO dist TARG_DIST");
			L_DMG *= DIST_RATIO;
		}
		XDoDamage(param1, "direct", L_DMG, 1.0, "ent_expowner", GetOwner(), "polearms", "pierce");
		string TARG_ORG = GetEntityOrigin(param1);
		string MY_ORG = GetEntityOrigin("ent_expowner");
		string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		string NEW_YAW = TARG_ANG;
		SetVelocity(param1, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, PUSH_STR, 0)));
	}

}

}
