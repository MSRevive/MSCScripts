#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjKKnife : CGameScript
{
	int ARROW_BODY_OFS;
	string EFFECT_DMG;
	string EFFECT_DUR;
	string EFFECT_SCRIPT;
	int MODEL_BODY_OFS;
	string MY_OWNER;
	string MY_WEAPON;
	string OWNER_ISPLAYER;
	string OWNER_TYPE;
	string SPAWN_ITEM;

	ProjKKnife()
	{
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		ARROW_BODY_OFS = 26;
		MODEL_BODY_OFS = 26;
		const string PROJ_ANIM_IDLE = "idle_standard";
		const int ARROW_EXPIRE_DELAY = 1;
		const string PROJ_DAMAGE = RandomInt(60, 90);
		const int PROJ_STICK_DURATION = 2;
		const int ARROW_SOLIDIFY_ON_WALL = 1;
		const float ARROW_BREAK_CHANCE = 1.0;
		const string SOUND_HITWALL1 = "weapons/dagger/daggermetal1.wav";
		const string SOUND_HITWALL2 = "weapons/dagger/daggermetal2.wav";
		const string PROJ_DAMAGE_TYPE = "pierce";
	}

	void arrow_spawn()
	{
		SetName("Kharaztorant Knife");
		SetDescription("An evil magical knife");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0);
		SetGroupable(25);
	}

	void game_tossprojectile()
	{
		SetGravity(0);
		MY_OWNER = GetEntityIndex("ent_expowner");
		MY_WEAPON = GetActiveItem(MY_OWNER);
		OWNER_TYPE = GetEntityProperty(MY_OWNER, "scriptvar");
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		if ((OWNER_ISPLAYER))
		{
			SPAWN_ITEM = GetEntityProperty(MY_OWNER, "scriptvar");
		}
		if (OWNER_TYPE == "ninja")
		{
			ARROW_BODY_OFS = 26;
		}
		if (OWNER_TYPE == "fire")
		{
			ARROW_BODY_OFS = 27;
			EFFECT_SCRIPT = "effects/dot_fire";
			EFFECT_DUR = 5.0;
			EFFECT_DMG = 30;
		}
		if (OWNER_TYPE == "poison")
		{
			ARROW_BODY_OFS = 28;
			EFFECT_SCRIPT = "effects/dot_poison";
			EFFECT_DUR = 15.0;
			EFFECT_DMG = 8;
		}
		if (OWNER_TYPE == "cold")
		{
			ARROW_BODY_OFS = 29;
			EFFECT_SCRIPT = "effects/dot_cold";
			EFFECT_DUR = 5.0;
			EFFECT_DMG = 10;
		}
		SetModelBody(0, ARROW_BODY_OFS);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if ((OWNER_ISPLAYER))
		{
			CallExternal(MY_OWNER, "knife_return");
		}
		if (!(OWNER_TYPE != "ninja")) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		if (!(true)) return;
		if ((OWNER_ISPLAYER))
		{
			if ((IsValidPlayer(param2)))
			{
			}
			string PVP_SET = "game.pvp";
			if (PVP_SET == 0)
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(EFFECT_SCRIPT != "EFFECT_SCRIPT")) return;
		ApplyEffect(param2, EFFECT_SCRIPT, EFFECT_DUR, MY_OWNER, EFFECT_DMG, "smallarms");
	}

	void hitwall()
	{
		if ((OWNER_ISPLAYER))
		{
			CallExternal(MY_WEAPON, "knife_return");
		}
		// TODO: UNCONVERTED: solidifyprojectile
		DeleteEntity(GetOwner(), true); // fade out
	}

	void game_hitnpc()
	{
		if ((OWNER_ISPLAYER))
		{
			CallExternal(MY_WEAPON, "knife_return");
		}
		DeleteEntity(GetOwner(), true); // fade out
	}

}

}
