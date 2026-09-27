#pragma context server

#include "items/proj_base.as"

namespace MS
{

class ProjHitWall : CGameScript
{
	float DISTANCE;
	string END_POS;
	int HIT_NPC;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string PROJ_ANIM_IDLE;
	int PROJ_AOE_FALLOFF;
	int PROJ_AOE_RANGE;
	int PROJ_COLLIDEHITBOX;
	int PROJ_DAMAGE;
	string PROJ_DAMAGE_TYPE;
	int PROJ_STICK_DURATION;
	string START_POS;

	ProjHitWall()
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "none";
		PROJ_DAMAGE_TYPE = "none";
		PROJ_ANIM_IDLE = "idle";
		PROJ_DAMAGE = 0;
		PROJ_AOE_RANGE = 0;
		PROJ_AOE_FALLOFF = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_COLLIDEHITBOX = 32;
	}

	void projectile_spawn()
	{
		SetName("Stupid Hack");
		SetWeight(0);
		SetSize(32);
		SetValue(0);
		SetGravity(0.0);
		HIT_NPC = 0;
		SetHUDSprite("hand", "arrows");
		SetHUDSprite("trade", ITEM_NAME);
		SetHand("any");
	}

	void game_tossprojectile()
	{
		START_POS = GetEntityOrigin(GetOwner());
	}

	void hit_npc()
	{
		SetAlive(0);
		HIT_NPC = 1;
		DeleteEntity(GetOwner());
	}

	void projectile_landed()
	{
		if ((HIT_NPC)) return;
		END_POS = GetEntityOrigin(GetOwner());
		DISTANCE = Distance(START_POS, END_POS);
		CallExternal(GetEntityIndex("ent_expowner"), "hitwall_test", DISTANCE, HIT_NPC);
	}

	void game_dodamage()
	{
		if (!(IsEntityAlive(param2))) return;
		HIT_NPC = 1;
	}

}

}
