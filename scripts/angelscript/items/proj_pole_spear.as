#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjPoleSpear : CGameScript
{
	ProjPoleSpear()
	{
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int MODEL_BODY_OFS = 57;
		const int ARROW_BODY_OFS = 57;
		const int ARROW_STICK_DURATION = 5;
		const string SOUND_HITWALL1 = "weapons/xbow_hit1.wav";
		const string SOUND_HITWALL2 = "weapons/xbow_hit1.wav";
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 1.0;
		const string ITEM_NAME = "watermana";
		const string PROJ_DAMAGE_TYPE = "pierce";
		const string PROJ_DAMAGESTAT = "spellcasting.ice";
		const string PROJ_ANIM_IDLE = "idle_icebolt";
		const int PROJ_MOTIONBLUR = 1;
		const string PROJ_ANIM_IDLE = "idle_icebolt";
		const int PROJ_DAMAGE = 1;
		const int PROJ_AOE_RANGE = 0;
		const int PROJ_AOE_FALLOFF = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_COLLIDE = 1;
	}

	void arrow_spawn()
	{
		SetName("Wooden Spear");
		SetDescription("A pointy ended stick that someone threw");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.8);
		SetGroupable(25);
		SetIdleAnim("idle_icebolt");
	}

	void game_projectile_hitnpc()
	{
		int L_DMG = 75;
		string OWNER_SKILL_RATIO = GetSkillLevel("ent_expowner", "polearms");
		OWNER_SKILL_RATIO *= 0.01;
		L_DMG *= OWNER_SKILL_RATIO;
		string CHARGE_LEVEL = GetEntityProperty("ent_expowner", "scriptvar");
		LogDebug("game_projectile_hitnpc CHARGE_LEVEL");
		CHARGE_LEVEL *= 2.0;
		CHARGE_LEVEL += 1.0;
		L_DMG *= CHARGE_LEVEL;
		string TARG_ORG = GetEntityOrigin(param1);
		string OWNER_ORG = GetEntityOrigin("ent_expowner");
		string TARG_DIST = Distance(OWNER_ORG, TARG_ORG);
		if (TARG_DIST < 256)
		{
			string DIST_RATIO = TARG_DIST;
			DIST_RATIO /= 256;
			LogDebug("too_close DIST_RATIO dist TARG_DIST");
			L_DMG *= DIST_RATIO;
		}
		XDoDamage(param1, "direct", L_DMG, 1.0, "ent_expowner", GetOwner(), "polearms", "pierce");
	}

}

}
