#pragma context server

#include "items/proj_base.as"

namespace MS
{

class ProjFireDart : CGameScript
{
	float BURN_DAMAGE;
	string CL_SCRIPT;
	string CL_SCRIPT_ID;
	string ITEM_NAME;
	string MODEL_HANDS;
	string MODEL_WORLD;
	int PROJ_AOE_FALLOFF;
	int PROJ_AOE_RANGE;
	int PROJ_DAMAGE;
	string PROJ_DAMAGESTAT;
	string PROJ_DAMAGE_TYPE;
	int PROJ_SOLIDIFY_ON_WALL;
	int PROJ_STICK_DURATION;
	string SOUND_BURN;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	string SPRITE_BURN;
	string SPRITE_FIRE;

	ProjFireDart()
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "weapons/projectiles.mdl";
		SOUND_HITWALL1 = "weapons/bow/arrowhit1.wav";
		SOUND_HITWALL2 = "weapons/bow/arrowhit1.wav";
		SOUND_BURN = "items/torch1.wav";
		SPRITE_FIRE = "3dmflaora.spr";
		SPRITE_BURN = "fire1_fixed.spr";
		ITEM_NAME = "firemana";
		PROJ_DAMAGE_TYPE = "fire";
		PROJ_DAMAGESTAT = "spellcasting";
		PROJ_DAMAGE = RandomInt(55, 85);
		PROJ_AOE_RANGE = 75;
		PROJ_AOE_FALLOFF = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_SOLIDIFY_ON_WALL = 0;
		BURN_DAMAGE = Random(0.5, 1.5);
		Precache(SPRITE_BURN);
		CL_SCRIPT = "items/proj_fire_dart_cl";
		Precache(CL_SCRIPT);
	}

	void projectile_spawn()
	{
		SetName("Fireball");
		SetWeight(500);
		SetSize(1);
		SetValue(5);
		SetGravity(0.7);
		SetGroupable(25);
		SetModelBody(0, 0);
		SetHUDSprite("hand", "arrows");
		SetHUDSprite("trade", ITEM_NAME);
		SetHand("any");
		Effect("glow", GetOwner(), Vector3(255, 75, 0), 128, 1, 1);
	}

	void game_tossprojectile()
	{
		CL_SCRIPT_ID = "game.script.last_sent_id";
	}

	void projectile_landed()
	{
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 50, 20, DURATION, 256);
	}

	void game_hitnpc()
	{
		string MY_OWNER = GetEntityIndex("ent_expowner");
		ApplyEffect(m_hLastStruckByMe, "effects/dot_fire", 5, MY_OWNER, BURN_DAMAGE, "spellcasting.fire");
	}

}

}
