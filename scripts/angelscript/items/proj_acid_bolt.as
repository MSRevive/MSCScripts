#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjAcidBolt : CGameScript
{
	int ARROW_BODY_OFS;
	string ITEM_NAME;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string POISON_SPRITE1;
	string PROJ_ANIM_IDLE;
	float PROJ_AOE_FALLOFF;
	int PROJ_AOE_RANGE;
	int PROJ_COLLIDEHITBOX;
	int PROJ_DAMAGE;
	string PROJ_DAMAGESTAT;
	string PROJ_DAMAGE_TYPE;
	int PROJ_STICK_DURATION;
	string TRAIL_SPRITE;

	ProjAcidBolt()
	{
		POISON_SPRITE1 = "poison.spr";
		TRAIL_SPRITE = "blood.spr";
		MODEL_HANDS = "weapons/projectiles.mdl";
		MODEL_WORLD = "weapons/projectiles.mdl";
		ARROW_BODY_OFS = 6;
		MODEL_BODY_OFS = 6;
		ITEM_NAME = "watermana";
		PROJ_DAMAGE_TYPE = "acid";
		PROJ_DAMAGESTAT = "spellcasting.affliction";
		PROJ_ANIM_IDLE = "idle_icebolt";
		PROJ_DAMAGE = 600;
		PROJ_AOE_RANGE = 40;
		PROJ_AOE_FALLOFF = 0.1;
		PROJ_STICK_DURATION = 0;
		PROJ_COLLIDEHITBOX = 32;
	}

	void projectile_spawn()
	{
		SetName("Acidic Bolt");
		SetWeight(1);
		SetSize(1);
		SetValue(5);
		SetGravity(0.0);
		SetGroupable(25);
		SetModelBody(0, MODEL_BODY_OFS);
		SetHUDSprite("hand", "arrows");
		SetHUDSprite("trade", ITEM_NAME);
		SetHand("any");
	}

	void game_tossprojectile()
	{
		SetGravity(0);
		fly_fx();
	}

	void fly_fx()
	{
		Effect("tempent", "spray", TRAIL_SPRITE, /* TODO: $relpos */ $relpos(0, 0, 0), /* TODO: $relvel */ $relvel(0, -30, 0), 10, 3, 50);
		ScheduleDelayedEvent(0.25, "fly_fx");
	}

	void projectile_landed()
	{
		Effect("tempent", "trail", POISON_SPRITE1, /* TODO: $relpos */ $relpos(0, 0, 0), /* TODO: $relpos */ $relpos(0, 0, 30), 10, 1, 5, 10, 5);
	}

}

}
