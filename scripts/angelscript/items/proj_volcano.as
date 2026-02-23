#pragma context server

#include "items/proj_base.as"

namespace MS
{

class ProjVolcano : CGameScript
{
	ProjVolcano()
	{
		const string MODEL_HANDS = "none";
		const string SOUND_HITWALL1 = "none";
		const string SOUND_HITWALL2 = "none";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int PROJ_ANIM_IDLE = 1;
		const int CLFX_ARROW_NOSTICK = 1;
		const int PROJ_STICK_ON_NPC = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_MOTIONBLUR = 0;
		const int PROJ_STICK_ON_WALL_NEW = 0;
		const int PROJ_DAMAGE = 80;
		const string PROJ_DAMAGE_TYPE = "fire";
		const int PROJ_AOE_RANGE = 110;
		const float PROJ_AOE_FALLOFF = 0.01;
		const int CLFX_ARROW = 1;
		const int CLFX_ARROW_UPDATE_RATE = 20;
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
