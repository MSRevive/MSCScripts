#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjFireBolt : CGameScript
{
	int ARROW_BODY_OFS;
	float ARROW_BREAK_CHANCE;
	int ARROW_SOLIDIFY_ON_WALL;
	string ITEM_NAME;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;
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
	string SOUND_EXPLODE;
	string SOUND_LAUNCH;

	ProjFireBolt()
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "weapons/projectiles.mdl";
		MODEL_BODY_OFS = 40;
		ARROW_BODY_OFS = 40;
		SOUND_EXPLODE = "weapons/explode3.wav";
		SOUND_EXPLODE = "weapons/explode3.wav";
		SOUND_BURN = "magic/ice_powerup.wav";
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 1.0;
		ITEM_NAME = "watermana";
		PROJ_DAMAGE_TYPE = "fire";
		PROJ_DAMAGESTAT = "spellcasting.ice";
		PROJ_ANIM_IDLE = "idle_icebolt";
		PROJ_MOTIONBLUR = 0;
		PROJ_DAMAGE = 50;
		PROJ_AOE_RANGE = 80;
		PROJ_AOE_FALLOFF = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_COLLIDEHITBOX = 32;
		SOUND_LAUNCH = "weapons/rocketfire1.wav";
		SOUND_EXPLODE = "weapons/explode3.wav";
	}

	void arrow_spawn()
	{
		SetName("Fire Bolt");
		SetDescription("A bolt of fire");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.0);
		SetGroupable(25);
		EmitSound(GetOwner(), 0, SOUND_LAUNCH, 10);
	}

	void game_dodamage()
	{
		string MY_OWNER = GetEntityIndex("ent_expowner");
		string OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		string ENT_HIT = GetEntityIndex(param2);
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
		if (GetEntityHealth(ENT_HIT) < 1000)
		{
			AddVelocity(ENT_HIT, /* TODO: $relvel */ $relvel(-10, 400, 30));
		}
		EmitSound(GetOwner(), 0, SOUND_EXPLODE, 10);
	}

}

}
