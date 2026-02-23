#pragma context server

#include "items/proj_base.as"

namespace MS
{

class ProjFireDart : CGameScript
{
	string CL_SCRIPT_ID;

	ProjFireDart()
	{
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const string SOUND_HITWALL1 = "weapons/bow/arrowhit1.wav";
		const string SOUND_HITWALL2 = "weapons/bow/arrowhit1.wav";
		const string SOUND_BURN = "items/torch1.wav";
		const string SPRITE_FIRE = "3dmflaora.spr";
		const string SPRITE_BURN = "fire1_fixed.spr";
		const string ITEM_NAME = "firemana";
		const string PROJ_DAMAGE_TYPE = "fire";
		const string PROJ_DAMAGESTAT = "spellcasting";
		const string PROJ_DAMAGE = RandomInt(55, 85);
		const int PROJ_AOE_RANGE = 75;
		const int PROJ_AOE_FALLOFF = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_SOLIDIFY_ON_WALL = 0;
		const string BURN_DAMAGE = Random(0.5, 1.5);
		Precache(SPRITE_BURN);
		const string CL_SCRIPT = "items/proj_fire_dart_cl";
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
