#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjMeteor : CGameScript
{
	int ARROW_BODY_OFS;
	float ARROW_BREAK_CHANCE;
	int ARROW_SOLIDIFY_ON_WALL;
	string MODEL_WORLD;
	string PROJ_ANIM_IDLE;
	float PROJ_AOE_FALLOFF;
	int PROJ_AOE_RANGE;
	int PROJ_DAMAGE;
	string PROJ_DAMAGESTAT;
	string PROJ_DAMAGE_TYPE;
	int PROJ_STICK_DURATION;

	ProjMeteor()
	{
		MODEL_WORLD = "weapons/projectiles.mdl";
		ARROW_BODY_OFS = 41;
		PROJ_ANIM_IDLE = "idle_icebolt";
		PROJ_STICK_DURATION = 0;
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 1.0;
		PROJ_DAMAGE_TYPE = "fire";
		PROJ_DAMAGESTAT = "spellcasting.fire";
		PROJ_DAMAGE = RandomInt(400, 500);
		PROJ_AOE_RANGE = 512;
		PROJ_AOE_FALLOFF = 0.4;
	}

	void projectile_spawn()
	{
		SetName("Fireball");
		SetWeight(500);
		SetSize(10);
		SetValue(5);
		SetGravity(0);
		SetMonsterClip(0);
		SetModelBody(0, 0);
		SetHUDSprite("hand", "arrows");
		SetHUDSprite("trade", ITEM_NAME);
		SetHand("any");
		// svplaysound: svplaysound 0 10 weapons/mortar.wav
		EmitSound(0, 10, "weapons/mortar.wav");
	}

	void projectile_landed()
	{
		Effect("screenshake", GetEntityOrigin(GetOwner()), 512, 10, 3.0, 512);
		Effect("tempent", "spray", "bigsmoke.spr", /* TODO: $relpos */ $relpos(0, 0, 0), 0, 4, 0, 0);
		EmitSound(GetOwner(), 0, "weapons/mortarhit.wav", 10);
	}

	void game_hitnpc()
	{
		string MY_OWNER = GetEntityIndex("ent_expowner");
		string BURN_DAMAGE = GetSkillLevel("ent_expowner", "spellcasting.fire");
		BURN_DAMAGE *= 0.25;
		if (!(IsValidPlayer(MY_OWNER)))
		{
			string BURN_DAMAGE = GetEntityProperty(MY_OWNER, "scriptvar");
		}
		ApplyEffect(m_hLastStruckByMe, "effects/dot_fire", 5, MY_OWNER, BURN_DAMAGE, "spellcasting.fire");
	}

}

}
