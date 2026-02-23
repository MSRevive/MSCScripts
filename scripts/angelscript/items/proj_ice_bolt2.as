#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjIceBolt2 : CGameScript
{
	string DOT_FREEZE;
	string EFFECT_DURATION;
	string MY_OWNER;
	string OWNER_ISPLAYER;

	ProjIceBolt2()
	{
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int MODEL_BODY_OFS = 2;
		const int ARROW_BODY_OFS = 2;
		const string SOUND_HITWALL1 = "magic/frost_pulse.wav";
		const string SOUND_HITWALL2 = "magic/frost_pulse.wav";
		const string SOUND_BURN = "magic/ice_powerup.wav";
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 1.0;
		const string ITEM_NAME = "watermana";
		const string PROJ_DAMAGE_TYPE = "cold";
		const string PROJ_DAMAGESTAT = "spellcasting.ice";
		const string PROJ_ANIM_IDLE = "idle_iceball";
		const int PROJ_MOTIONBLUR = 0;
		const int PROJ_DAMAGE = 96;
		const int PROJ_AOE_RANGE = 64;
		const int PROJ_AOE_FALLOFF = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_COLLIDEHITBOX = 32;
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
