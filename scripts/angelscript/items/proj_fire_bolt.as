#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjFireBolt : CGameScript
{
	ProjFireBolt()
	{
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int MODEL_BODY_OFS = 40;
		const int ARROW_BODY_OFS = 40;
		const string SOUND_EXPLODE = "weapons/explode3.wav";
		const string SOUND_EXPLODE = "weapons/explode3.wav";
		const string SOUND_BURN = "magic/ice_powerup.wav";
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 1.0;
		const string ITEM_NAME = "watermana";
		const string PROJ_DAMAGE_TYPE = "fire";
		const string PROJ_DAMAGESTAT = "spellcasting.ice";
		const string PROJ_ANIM_IDLE = "idle_icebolt";
		const int PROJ_MOTIONBLUR = 0;
		const int PROJ_DAMAGE = 50;
		const int PROJ_AOE_RANGE = 80;
		const int PROJ_AOE_FALLOFF = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_COLLIDEHITBOX = 32;
		const string SOUND_LAUNCH = "weapons/rocketfire1.wav";
		const string SOUND_EXPLODE = "weapons/explode3.wav";
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
