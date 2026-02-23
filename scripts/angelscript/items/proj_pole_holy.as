#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjPoleHoly : CGameScript
{
	string GAME_PVP;

	ProjPoleHoly()
	{
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int MODEL_BODY_OFS = 61;
		const int ARROW_BODY_OFS = 61;
		const int ARROW_STICK_DURATION = 5;
		const int ARROW_EXPIRE_DELAY = 2;
		const string SOUND_HITWALL1 = "weapons/xbow_hit1.wav";
		const string SOUND_HITWALL2 = "weapons/xbow_hit1.wav";
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 1.0;
		const string ITEM_NAME = "watermana";
		const string PROJ_DAMAGE_TYPE = "holy";
		const string PROJ_DAMAGESTAT = "spellcasting.ice";
		const string PROJ_ANIM_IDLE = "idle_icebolt";
		const int PROJ_MOTIONBLUR = 0;
		const int PROJ_DAMAGE = 0;
		const int PROJ_AOE_RANGE = 0;
		const int PROJ_AOE_FALLOFF = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_COLLIDE = 1;
	}

	void arrow_spawn()
	{
		SetName("Holy Lance");
		SetDescription("This holy weapon has made you holie");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.8);
		SetGroupable(25);
	}

	void game_tossprojectile()
	{
		GAME_PVP = "game.pvp";
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(255, 255, 255), 128, 1.5);
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
		if (!(GetRelationship(param1) == "enemy")) return;
		int L_DMG = 800;
		string OWNER_SKILL_RATIO = GetSkillLevel("ent_expowner", "polearms");
		OWNER_SKILL_RATIO *= 0.01;
		L_DMG *= OWNER_SKILL_RATIO;
		int PUSH_STR = 800;
		string TARG_ORG = GetEntityOrigin(param1);
		string MY_ORG = GetEntityOrigin("ent_expowner");
		string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		string NEW_YAW = TARG_ANG;
		SetVelocity(param1, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, PUSH_STR, 0)));
		string HOLY_DMG = GetSkillLevel("ent_expowner", "spellcasting.divination");
		HOLY_DMG *= 5.0;
		CallExternal(param1, "turn_undead", HOLY_DMG, GetEntityIndex("ent_expowner"));
		if (!(IsEntityAlive(param1))) return;
		XDoDamage(param1, "direct", L_DMG, 1.0, "ent_expowner", GetOwner(), "polearms", "holy");
	}

}

}
