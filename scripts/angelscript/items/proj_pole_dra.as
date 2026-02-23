#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjPoleDra : CGameScript
{
	string BURN_TARGS;
	int DID_FIREBURST;
	string FIRE_DOT;
	string GAME_PVP;

	ProjPoleDra()
	{
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int MODEL_BODY_OFS = 66;
		const int ARROW_BODY_OFS = 66;
		const int ARROW_STICK_DURATION = 5;
		const int ARROW_EXPIRE_DELAY = 2;
		const string SOUND_HITWALL1 = "weapons/xbow_hit1.wav";
		const string SOUND_HITWALL2 = "weapons/xbow_hit1.wav";
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 1.0;
		const string ITEM_NAME = "watermana";
		const string PROJ_DAMAGE_TYPE = "fire";
		const string PROJ_DAMAGESTAT = "spellcasting.fire";
		const string PROJ_ANIM_IDLE = "idle_icebolt";
		const int PROJ_MOTIONBLUR = 1;
		const int PROJ_DAMAGE = 0;
		const int PROJ_AOE_RANGE = 0;
		const int PROJ_AOE_FALLOFF = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_COLLIDE = 1;
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
