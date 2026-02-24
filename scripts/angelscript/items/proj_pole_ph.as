#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjPolePh : CGameScript
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

	ProjPolePh()
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "weapons/projectiles.mdl";
		MODEL_BODY_OFS = 46;
		ARROW_BODY_OFS = 46;
		ARROW_STICK_DURATION = 5;
		ARROW_EXPIRE_DELAY = 2;
		SOUND_HITWALL1 = "weapons/xbow_hit1.wav";
		SOUND_HITWALL2 = "weapons/xbow_hit1.wav";
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 1.0;
		ITEM_NAME = "watermana";
		PROJ_DAMAGE_TYPE = "lightning";
		PROJ_DAMAGESTAT = "spellcasting.ice";
		PROJ_ANIM_IDLE = "idle_icebolt";
		PROJ_MOTIONBLUR = 0;
		PROJ_DAMAGE = 0;
		PROJ_AOE_RANGE = 0;
		PROJ_AOE_FALLOFF = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_COLLIDE = 1;
	}

	void arrow_spawn()
	{
		SetName("Lightning Lance");
		SetDescription("Zappy zappy!");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.8);
		SetGroupable(25);
	}

	void game_tossprojectile()
	{
		GAME_PVP = "game.pvp";
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(255, 255, 0), 128, 1.5);
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
		XDoDamage(param1, "direct", L_DMG, 1.0, "ent_expowner", GetOwner(), "polearms", "lightning");
		if (!(IsEntityAlive(param1))) return;
		if (GetEntityMP("ent_expowner") >= 100)
		{
			if (GetEntityHeight(param1) >= 64)
			{
				int TOO_BIG = 1;
			}
			if (GetEntityWidth(param1) >= 48)
			{
				TOO_BIG += 1;
			}
			if (TOO_BIG == 2)
			{
				SendColoredMessage("ent_expowner", "Force Cage: " + GetEntityName(param1) + " too large for force cage");
			}
			else
			{
				int DO_HOLD = 1;
			}
		}
		if ((DO_HOLD))
		{
			GiveMP("ent_expowner");
			ApplyEffect(param1, "effects/debuff_hold", 10.0);
		}
		else
		{
			int PUSH_STR = 800;
			PUSH_STR *= /* TODO: $get_takedmg */ $get_takedmg(param1, "lightning");
			string TARG_ORG = GetEntityOrigin(param1);
			string MY_ORG = GetEntityOrigin("ent_expowner");
			string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
			string NEW_YAW = TARG_ANG;
			SetVelocity(param1, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, PUSH_STR, 0)));
			ApplyEffect(param1, "effects/dot_lightning", 5.0, GetEntityIndex("ent_expowner"), GetSkillLevel("ent_expowner", "spellcasting.lightning"));
		}
	}

}

}
