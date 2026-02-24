#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjPoleDra : CGameScript
{
	int ARROW_BODY_OFS;
	float ARROW_BREAK_CHANCE;
	int ARROW_EXPIRE_DELAY;
	int ARROW_SOLIDIFY_ON_WALL;
	int ARROW_STICK_DURATION;
	string BURN_TARGS;
	int DID_FIREBURST;
	string FIRE_DOT;
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

	ProjPoleDra()
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "weapons/projectiles.mdl";
		MODEL_BODY_OFS = 66;
		ARROW_BODY_OFS = 66;
		ARROW_STICK_DURATION = 5;
		ARROW_EXPIRE_DELAY = 2;
		SOUND_HITWALL1 = "weapons/xbow_hit1.wav";
		SOUND_HITWALL2 = "weapons/xbow_hit1.wav";
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 1.0;
		ITEM_NAME = "watermana";
		PROJ_DAMAGE_TYPE = "fire";
		PROJ_DAMAGESTAT = "spellcasting.fire";
		PROJ_ANIM_IDLE = "idle_icebolt";
		PROJ_MOTIONBLUR = 1;
		PROJ_DAMAGE = 0;
		PROJ_AOE_RANGE = 0;
		PROJ_AOE_FALLOFF = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_COLLIDE = 1;
	}

	void arrow_spawn()
	{
		SetName("Dragon Lance");
		SetDescription("Wait! I'm not a dragon!");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.8);
		SetGroupable(25);
		SetIdleAnim("idle_icebolt");
	}

	void game_projectile_hitnpc()
	{
		if ((IsValidPlayer(param1)))
		{
			if (!("game.pvp"))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		int L_DMG = 300;
		string OWNER_SKILL_RATIO = GetSkillLevel("ent_expowner", "polearms");
		OWNER_SKILL_RATIO *= 0.01;
		L_DMG *= OWNER_SKILL_RATIO;
		XDoDamage(param1, "direct", L_DMG, 1.0, "ent_expowner", GetOwner(), "polearms", "fire");
		string L_DOT = GetSkillLevel("ent_expowner", "spellcasting.fire");
		if (!(L_DOT >= 15)) return;
		if (L_DOT >= 20)
		{
			do_fire_burst(GetEntityOrigin(param1));
		}
		LOT_DOT *= 0.5;
		ApplyEffect(param1, "effects/dot_fire", 5.0, GetEntityIndex("ent_expowner"), L_DOT, "polearms");
	}

	void hitwall()
	{
		if (GetSkillLevel("ent_expowner", "spellcasting.fire") >= 20)
		{
			do_fire_burst(GetEntityOrigin(GetOwner()));
		}
	}

	void do_fire_burst()
	{
		if ((DID_FIREBURST)) return;
		DID_FIREBURST = 1;
		string PROJ_POS = param1;
		string OWNER_POS = GetEntityOrigin("ent_expowner");
		LogDebug("do_fire_burst Distance(PROJ_POS, OWNER_POS)");
		if (!(Distance(PROJ_POS, OWNER_POS) > 128)) return;
		string GROUND_HEIGHT = /* TODO: $get_ground_height */ $get_ground_height(PROJ_POS);
		string Z_DIFF = (PROJ_POS).z;
		Z_DIFF -= GROUND_HEIGHT;
		if (Z_DIFF > 50)
		{
			int EXIT_SUB = 1;
		}
		if (Z_DIFF < -50)
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		PROJ_POS = "z";
		ClientEvent("new", "all", "effects/sfx_fire_burst", PROJ_POS, 128, 1, Vector3(255, 0, 0));
		PROJ_POS += "z";
		BURN_TARGS = FindEntitiesInSphere("any", 128);
		if (!(BURN_TARGS != "none")) return;
		GAME_PVP = "game.pvp";
		FIRE_DOT = GetSkillLevel("ent_expowner", "spellcasting.fire");
		FIRE_DOT *= 0.5;
		for (int i = 0; i < GetTokenCount(BURN_TARGS, ";"); i++)
		{
			fire_burst_affect_targets();
		}
	}

	void fire_burst_affect_targets()
	{
		string CUR_TARG = GetToken(BURN_TARGS, i, ";");
		if (!(GetRelationship(CUR_TARG) == "enemy")) return;
		if ((IsValidPlayer(CUR_TARG)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex("ent_expowner"), FIRE_DOT, "polearms");
	}

}

}
