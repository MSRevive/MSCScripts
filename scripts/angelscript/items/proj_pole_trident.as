#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjPoleTrident : CGameScript
{
	string GAME_PVP;

	ProjPoleTrident()
	{
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int MODEL_BODY_OFS = 59;
		const int ARROW_BODY_OFS = 59;
		const int ARROW_STICK_DURATION = 5;
		const int ARROW_EXPIRE_DELAY = 2;
		const string SOUND_HITWALL1 = "weapons/xbow_hit1.wav";
		const string SOUND_HITWALL2 = "weapons/xbow_hit1.wav";
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 1.0;
		const string ITEM_NAME = "watermana";
		const string PROJ_DAMAGE_TYPE = "pierce";
		const string PROJ_DAMAGESTAT = "spellcasting.ice";
		const string PROJ_ANIM_IDLE = "idle_icebolt";
		const int PROJ_MOTIONBLUR = 1;
		const int PROJ_DAMAGE = 1;
		const int PROJ_AOE_RANGE = 0;
		const int PROJ_AOE_FALLOFF = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_COLLIDE = 1;
	}

	void arrow_spawn()
	{
		SetName("Trident");
		SetDescription("Three prongs for your chest");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.8);
		SetGroupable(25);
		SetIdleAnim("idle_icebolt");
	}

	void game_tossprojectile()
	{
		GAME_PVP = "game.pvp";
	}

	void game_projectile_hitnpc()
	{
		int L_DMG = 175;
		string OWNER_SKILL_RATIO = GetSkillLevel("ent_expowner", "polearms");
		OWNER_SKILL_RATIO *= 0.01;
		L_DMG *= OWNER_SKILL_RATIO;
		string CHARGE_LEVEL = GetEntityProperty("ent_expowner", "scriptvar");
		int PUSH_STR = 800;
		PUSH_STR *= CHARGE_LEVEL;
		LogDebug("game_projectile_hitnpc CHARGE_LEVEL");
		CHARGE_LEVEL *= 1.5;
		CHARGE_LEVEL += 1.0;
		L_DMG *= CHARGE_LEVEL;
		XDoDamage(param1, "direct", L_DMG, 1.0, "ent_expowner", GetOwner(), "polearms", "pierce");
	}

}

}
