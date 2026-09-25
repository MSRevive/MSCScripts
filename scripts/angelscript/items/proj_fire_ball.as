#pragma context server

#include "items/proj_base.as"

namespace MS
{

class ProjFireBall : CGameScript
{
	string ITEM_NAME;
	string LOCK_BURN_DAMAGE;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string MY_OWNER;
	int PROJ_AOE_FALLOFF;
	int PROJ_AOE_RANGE;
	int PROJ_COLLIDEHITBOX;
	int PROJ_DAMAGE;
	string PROJ_DAMAGESTAT;
	string PROJ_DAMAGE_TYPE;
	int PROJ_SOLIDIFY_ON_WALL;
	int PROJ_STICK_DURATION;
	string SCRIPT_1;
	string SCRIPT_1_ID;
	string SOUND_BURN;
	string SPRITE_BURN;
	string SPRITE_FIRE;

	ProjFireBall()
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "weapons/projectiles.mdl";
		SOUND_BURN = "items/torch1.wav";
		SPRITE_FIRE = "3dmflaora.spr";
		SPRITE_BURN = "fire1_fixed.spr";
		ITEM_NAME = "firemana";
		PROJ_DAMAGE_TYPE = "fire";
		PROJ_DAMAGESTAT = "spellcasting";
		PROJ_DAMAGE = RandomInt(75, 200);
		PROJ_AOE_RANGE = 250;
		PROJ_AOE_FALLOFF = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_SOLIDIFY_ON_WALL = 0;
		PROJ_COLLIDEHITBOX = 64;
		Precache(SPRITE_BURN);
		SCRIPT_1 = "items/proj_fire_dart_cl";
		Precache(SCRIPT_1);
		Precache("rjet1.spr");
		Precache(MODEL_WORLD);
	}

	void projectile_spawn()
	{
		SetName("Fireball");
		SetWeight(500);
		SetSize(10);
		SetValue(5);
		SetGravity(0.7);
		SetMonsterClip(0);
		SetModelBody(0, 0);
		SetHUDSprite("hand", "arrows");
		SetHUDSprite("trade", ITEM_NAME);
		SetHand("any");
		Effect("glow", GetOwner(), Vector3(255, 75, 0), 128, 1, 1);
	}

	void game_tossprojectile()
	{
		SCRIPT_1_ID = "game.script.last_sent_id";
	}

	void projectile_landed()
	{
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 50, 20, DURATION, 256);
		if ((GetEntityProperty("ent_expowner", "scriptvar"))) return;
		Effect("tempent", "trail", "rjet1.spr", /* TODO: $relpos */ $relpos(0, 0, 0), /* TODO: $relpos */ $relpos(0, 0, 10), 10, 2, 5, 10, 20);
	}

	void game_hitnpc()
	{
		MY_OWNER = GetEntityIndex("ent_expowner");
		if (LOCK_BURN_DAMAGE == "LOCK_BURN_DAMAGE")
		{
			string BURN_DAMAGE = GetSkillLevel("ent_expowner", "spellcasting.fire");
			BURN_DAMAGE *= 0.25;
			if (!(IsValidPlayer(MY_OWNER)))
			{
				int BURN_DAMAGE = 10;
			}
		}
		if (LOCK_BURN_DAMAGE != "LOCK_BURN_DAMAGE")
		{
			string BURN_DAMAGE = LOCK_BURN_DAMAGE;
		}
		ApplyEffect(m_hLastStruckByMe, "effects/dot_fire", 5, MY_OWNER, BURN_DAMAGE, "spellcasting.fire");
	}

	void lighten()
	{
		if ((param2).findFirst("PARAM") == 0)
		{
			float PARAM2 = 0.4;
		}
		SetGravity(param2);
		LOCK_BURN_DAMAGE = param1;
	}

}

}
