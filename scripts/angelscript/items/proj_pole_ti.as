#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjPoleTi : CGameScript
{
	string GAME_PVP;

	ProjPoleTi()
	{
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int MODEL_BODY_OFS = 60;
		const int ARROW_BODY_OFS = 60;
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
		const string SOUND_HITWALL1 = "debris/glass1.wav";
		const string SOUND_HITWALL2 = "debris/glass2.wav";
	}

	void arrow_spawn()
	{
		SetName("Ice Typhoon");
		SetDescription("Death by popsicle!");
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
		int L_DMG = 300;
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
		XDoDamage(param1, "direct", L_DMG, 1.0, "ent_expowner", GetOwner(), "polearms", "cold");
		string L_DOT = GetSkillLevel("ent_expowner", "spellcasting.ice");
		if (!(L_DOT >= 25)) return;
		string CUR_TARG = param1;
		string MAX_FREEZE_HP = GetEntityMaxHealth("ent_expowner");
		MAX_FREEZE_HP *= 5.0;
		if (GetEntityHealth(CUR_TARG) < MAX_FREEZE_HP)
		{
			int DO_FREEZE = 1;
		}
		if (GetEntityHealth(CUR_TARG) < 3000)
		{
			int DO_FREEZE = 1;
		}
		if (GetEntityMP("ent_expowner") < 10)
		{
			int DO_FREEZE = 0;
		}
		LogDebug("do_freeze DO_FREEZE vs GetEntityHealth(CUR_TARG)");
		if (!(DO_FREEZE))
		{
			ApplyEffect(CUR_TARG, "effects/dot_cold", 5.0, GetEntityIndex("ent_expowner"), L_DOT, "polearms");
		}
		else
		{
			L_DOT *= 0.5;
			GiveMP("ent_expowner");
			ApplyEffect(CUR_TARG, "effects/dot_cold_freeze", Random(6.0, 10.0), GetEntityIndex("ent_expowner"), L_DOT, "spellcasting.ice", MAX_FREEZE_HP);
		}
	}

}

}
