#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjMeteor : CGameScript
{
	ProjMeteor()
	{
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int ARROW_BODY_OFS = 41;
		const string PROJ_ANIM_IDLE = "idle_icebolt";
		const int PROJ_STICK_DURATION = 0;
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 1.0;
		const string PROJ_DAMAGE_TYPE = "fire";
		const string PROJ_DAMAGESTAT = "spellcasting.fire";
		const string PROJ_DAMAGE = RandomInt(400, 500);
		const int PROJ_AOE_RANGE = 512;
		const float PROJ_AOE_FALLOFF = 0.4;
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
