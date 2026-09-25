#pragma context server

#include "items/proj_base.as"

namespace MS
{

class ProjVolcano : CGameScript
{
	int CLFX_ARROW;
	int CLFX_ARROW_NOSTICK;
	int CLFX_ARROW_UPDATE_RATE;
	string MODEL_HANDS;
	string MODEL_WORLD;
	int PROJ_ANIM_IDLE;
	float PROJ_AOE_FALLOFF;
	int PROJ_AOE_RANGE;
	int PROJ_DAMAGE;
	string PROJ_DAMAGE_TYPE;
	int PROJ_MOTIONBLUR;
	int PROJ_STICK_DURATION;
	int PROJ_STICK_ON_NPC;
	int PROJ_STICK_ON_WALL_NEW;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;

	ProjVolcano()
	{
		MODEL_HANDS = "none";
		SOUND_HITWALL1 = "none";
		SOUND_HITWALL2 = "none";
		MODEL_WORLD = "weapons/projectiles.mdl";
		PROJ_ANIM_IDLE = 1;
		CLFX_ARROW_NOSTICK = 1;
		PROJ_STICK_ON_NPC = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_MOTIONBLUR = 0;
		PROJ_STICK_ON_WALL_NEW = 0;
		PROJ_DAMAGE = 80;
		PROJ_DAMAGE_TYPE = "fire";
		PROJ_AOE_RANGE = 110;
		PROJ_AOE_FALLOFF = 0.01;
		CLFX_ARROW = 1;
		CLFX_ARROW_UPDATE_RATE = 20;
	}

	void projectile_spawn()
	{
		SetName("Volcanic fireball");
		SetGravity(Random(0.6, 1));
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		string L_TARGET = param2;
		string L_OWNER = GetEntityIndex("ent_expowner");
		if ((IsValidPlayer(L_OWNER)))
		{
			string L_DMG_FIRE = GetSkillLevel(L_OWNER, "spellcasting.fire");
			L_DMG_FIRE *= 0.5;
			ApplyEffect(L_TARGET, "effects/dot_fire", 5, L_OWNER, L_DMG_FIRE, "spellcasting.fire");
		}
	}

	void update_clfx_projectile()
	{
		ext_scale(1.3);
	}

}

}
