#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjStaffIceBolt : CGameScript
{
	int ARROW_BODY_OFS;
	float ARROW_BREAK_CHANCE;
	int ARROW_SOLIDIFY_ON_WALL;
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

	ProjStaffIceBolt()
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "weapons/projectiles.mdl";
		MODEL_BODY_OFS = 7;
		ARROW_BODY_OFS = 7;
		SOUND_HITWALL1 = "weapons/axemetal1.wav";
		SOUND_HITWALL2 = "weapons/axemetal1.wav";
		SOUND_BURN = "magic/ice_powerup.wav";
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 1.0;
		ITEM_NAME = "watermana";
		PROJ_DAMAGE_TYPE = "cold";
		PROJ_DAMAGESTAT = "spellcasting.ice";
		PROJ_ANIM_IDLE = "idle_icebolt";
		PROJ_MOTIONBLUR = 0;
		PROJ_DAMAGE = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_COLLIDEHITBOX = 0;
	}

	void arrow_spawn()
	{
		SetName("Ice Bolt");
		SetDescription("A sharp bolt of ice");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.0);
		SetGroupable(25);
	}

	void game_projectile_hitnpc()
	{
		string MY_OWNER = GetEntityIndex("ent_expowner");
		string OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		string ENT_HIT = param1;
		if (OWNER_ISPLAYER == 1)
		{
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
		XDoDamage(ENT_HIT, "direct", GetSkillLevel(MY_OWNER, "spellcasting.ice"), 1.0, MY_OWNER, GetOwner(), "spellcasting.ice", "cold");
		string EFFECT_DURATION = GetSkillLevel(MY_OWNER, "spellcasting.ice");
		string DOT_ICE = GetSkillLevel(MY_OWNER, "spellcasting.ice");
		EFFECT_DURATION *= 0.5;
		DOT_ICE *= 0.5;
		EFFECT_DURATION = max(3, min(5, EFFECT_DURATION));
		ApplyEffect(ENT_HIT, "effects/dot_cold", EFFECT_DURATION, MY_OWNER, DOT_ICE, "spellcasting.ice");
	}

}

}
