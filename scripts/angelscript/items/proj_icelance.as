#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjIcelance : CGameScript
{
	int ARROW_BODY_OFS;
	float ARROW_BREAK_CHANCE;
	int ARROW_SOLIDIFY_ON_WALL;
	string EFFECT_DURATION;
	string FROST_DMG;
	string ITEM_NAME;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string PROJ_ANIM_IDLE;
	int PROJ_AOE_FALLOFF;
	int PROJ_DAMAGE;
	string PROJ_DAMAGESTAT;
	string PROJ_DAMAGE_TYPE;
	int PROJ_MOTIONBLUR;
	int PROJ_STICK_DURATION;
	string SOUND_BURN;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;

	ProjIcelance()
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "weapons/projectiles.mdl";
		MODEL_BODY_OFS = 38;
		ARROW_BODY_OFS = 38;
		SOUND_HITWALL1 = "weapons/axemetal1.wav";
		SOUND_HITWALL2 = "weapons/axemetal1.wav";
		SOUND_BURN = "magic/ice_powerup.wav";
		ARROW_SOLIDIFY_ON_WALL = 1;
		ARROW_BREAK_CHANCE = 1.0;
		ITEM_NAME = "watermana";
		PROJ_DAMAGE_TYPE = "cold";
		PROJ_DAMAGESTAT = "spellcasting.ice";
		PROJ_ANIM_IDLE = "idle_icelance";
		PROJ_MOTIONBLUR = 0;
		PROJ_DAMAGE = 800;
		PROJ_AOE_FALLOFF = 0;
		PROJ_STICK_DURATION = 0;
	}

	void arrow_spawn()
	{
		SetName("Ice Lance");
		SetDescription("A sharp bolt of ice");
		SetGravity(0);
	}

	void game_tossprojectile()
	{
		SetGravity(0);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		string MY_OWNER = GetEntityIndex("ent_expowner");
		string OWNER_ISPLAYER = IsValidPlayer("ent_expowner");
		string ENEMY_HIT = GetEntityIndex(param2);
		if (!(IsEntityAlive(ENEMY_HIT))) return;
		if (OWNER_ISPLAYER == 1)
		{
			if ("game.pvp" < 1)
			{
			}
			if ((IsValidPlayer(ENEMY_HIT)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetRelationship(MY_OWNER) == "enemy")) return;
		EFFECT_DURATION = GetSkillLevel(MY_OWNER, "spellcasting.ice");
		EFFECT_DURATION *= 0.5;
		if (EFFECT_DURATION < 3)
		{
			EFFECT_DURATION = 3;
		}
		if (!(OWNER_ISPLAYER))
		{
			EFFECT_DURATION = 5;
		}
		if (!(/* TODO: $get_takedmg */ $get_takedmg(ENEMY_HIT, "cold") != 0)) return;
		int RND_EFFECT = RandomInt(1, 3);
		int FROST_DMG = RandomInt(1, EFFECT_DURATION);
		if (!(OWNER_ISPLAYER))
		{
			FROST_DMG = GetEntityProperty("ent_expowner", "scriptvar");
		}
		ApplyEffect(ENEMY_HIT, "effects/dot_cold", EFFECT_DURATION, MY_OWNER, FROST_DMG, "spellcasting.ice");
		if (!(RND_EFFECT == 1)) return;
		ApplyEffect(ENEMY_HIT, "effects/debuff_freeze", Random(5, 7), MY_OWNER, 0);
		if ((IsValidPlayer(ENEMY_HIT))) return;
		if ((GetEntityProperty(ENEMY_HIT, "scriptvar")))
		{
			SendPlayerMessage(GetOwner(), "Your enemy has been encased in ice!");
		}
	}

}

}
