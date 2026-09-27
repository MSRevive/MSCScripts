#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjStaffIcelance : CGameScript
{
	int ARROW_BODY_OFS;
	float ARROW_BREAK_CHANCE;
	int ARROW_SOLIDIFY_ON_WALL;
	string EFFECT_DURATION;
	string ITEM_NAME;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string PROJ_ANIM_IDLE;
	int PROJ_COLLIDEHITBOX;
	int PROJ_DAMAGE;
	string PROJ_DAMAGESTAT;
	string PROJ_DAMAGE_TYPE;
	int PROJ_MOTIONBLUR;
	int PROJ_STICK_DURATION;
	string SOUND_BURN;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;

	ProjStaffIcelance()
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "weapons/projectiles.mdl";
		MODEL_BODY_OFS = 38;
		ARROW_BODY_OFS = 38;
		SOUND_HITWALL1 = "weapons/axemetal1.wav";
		SOUND_HITWALL2 = "weapons/axemetal1.wav";
		SOUND_BURN = "magic/ice_powerup.wav";
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 1.0;
		ITEM_NAME = "watermana";
		PROJ_DAMAGE_TYPE = "cold";
		PROJ_DAMAGESTAT = "spellcasting.ice";
		PROJ_ANIM_IDLE = "idle_icelance";
		PROJ_MOTIONBLUR = 0;
		PROJ_DAMAGE = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_COLLIDEHITBOX = 0;
	}

	void arrow_spawn()
	{
		SetName("Ice Lance");
		SetDescription("A sharp bolt of ice");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.0000001);
		SetGroupable(25);
	}

	void game_tossprojectile()
	{
		SetGravity(0);
	}

	void game_projectile_hitnpc()
	{
		if (!(IsEntityAlive(param1))) return;
		string MY_OWNER = GetEntityIndex("ent_expowner");
		string OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		string ENEMY_HIT = param1;
		if ((OWNER_ISPLAYER))
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
		string DIR_DMG = GetSkillLevel(MY_OWNER, "spellcasting.ice");
		DIR_DMG *= 2;
		XDoDamage(ENEMY_HIT, "direct", DIR_DMG, 1.0, MY_OWNER, GetOwner(), "spellcasting.ice", "cold");
		EFFECT_DURATION = GetSkillLevel(MY_OWNER, "spellcasting.ice");
		EFFECT_DURATION *= 0.25;
		EFFECT_DURATION = max(3, min(5, EFFECT_DURATION));
		int RND_EFFECT = RandomInt(1, 2);
		string FROST_DMG = GetSkillLevel(MY_OWNER, "spellcasting.ice");
		FROST_DMG *= 0.5;
		ApplyEffect(ENEMY_HIT, "effects/dot_cold", EFFECT_DURATION, MY_OWNER, FROST_DMG, "spellcasting.ice");
		if (!(RND_EFFECT == 2)) return;
		ApplyEffect(ENEMY_HIT, "effects/dot_cold_freeze", Random(5, 7), MY_OWNER);
	}

}

}
