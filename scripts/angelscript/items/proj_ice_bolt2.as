#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjIceBolt2 : CGameScript
{
	int ARROW_BODY_OFS;
	float ARROW_BREAK_CHANCE;
	int ARROW_SOLIDIFY_ON_WALL;
	string DOT_FREEZE;
	string EFFECT_DURATION;
	string ITEM_NAME;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string MY_OWNER;
	string OWNER_ISPLAYER;
	string PROJ_ANIM_IDLE;
	int PROJ_AOE_FALLOFF;
	int PROJ_AOE_RANGE;
	int PROJ_COLLIDEHITBOX;
	int PROJ_DAMAGE;
	string PROJ_DAMAGESTAT;
	string PROJ_DAMAGE_TYPE;
	int PROJ_MOTIONBLUR;
	int PROJ_STICK_DURATION;
	string SOUND_BURN;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;

	ProjIceBolt2()
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "weapons/projectiles.mdl";
		MODEL_BODY_OFS = 2;
		ARROW_BODY_OFS = 2;
		SOUND_HITWALL1 = "magic/frost_pulse.wav";
		SOUND_HITWALL2 = "magic/frost_pulse.wav";
		SOUND_BURN = "magic/ice_powerup.wav";
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 1.0;
		ITEM_NAME = "watermana";
		PROJ_DAMAGE_TYPE = "cold";
		PROJ_DAMAGESTAT = "spellcasting.ice";
		PROJ_ANIM_IDLE = "idle_iceball";
		PROJ_MOTIONBLUR = 0;
		PROJ_DAMAGE = 96;
		PROJ_AOE_RANGE = 64;
		PROJ_AOE_FALLOFF = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_COLLIDEHITBOX = 32;
	}

	void arrow_spawn()
	{
		SetName("Greater Ice Bolt");
		SetDescription("A jagged ball of ice");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.0);
		SetGroupable(25);
	}

	void game_dodamage()
	{
		if (!(true)) return;
		if (!(param1)) return;
		MY_OWNER = GetEntityIndex("ent_expowner");
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		string ENT_HIT = GetEntityIndex(param2);
		if (OWNER_ISPLAYER == 1)
		{
			EFFECT_DURATION = GetSkillLevel(MY_OWNER, "spellcasting.ice");
			EFFECT_DURATION *= 0.5;
			DOT_FREEZE = GetSkillLevel(MY_OWNER, "spellcasting.ice");
			DOT_FREEZE *= 0.5;
			if (EFFECT_DURATION < 3)
			{
				EFFECT_DURATION = 3;
			}
			if (!("game.pvp"))
			{
			}
			if ((IsValidPlayer(ENT_HIT)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetRelationship(MY_OWNER) == "enemy")) return;
		if (!(OWNER_ISPLAYER))
		{
			EFFECT_DURATION = GetEntityProperty(MY_OWNER, "scriptvar");
			DOT_FREEZE = GetEntityProperty(MY_OWNER, "scriptvar");
		}
		ApplyEffect(ENT_HIT, "effects/dot_cold", EFFECT_DURATION, MY_OWNER, DOT_FREEZE, "spellcasting.ice");
	}

}

}
