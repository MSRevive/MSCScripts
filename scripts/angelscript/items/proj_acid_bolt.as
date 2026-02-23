#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjAcidBolt : CGameScript
{
	ProjAcidBolt()
	{
		const string POISON_SPRITE1 = "poison.spr";
		const string TRAIL_SPRITE = "blood.spr";
		const string MODEL_HANDS = "weapons/projectiles.mdl";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int ARROW_BODY_OFS = 6;
		const int MODEL_BODY_OFS = 6;
		const string ITEM_NAME = "watermana";
		const string PROJ_DAMAGE_TYPE = "acid";
		const string PROJ_DAMAGESTAT = "spellcasting.affliction";
		const string PROJ_ANIM_IDLE = "idle_icebolt";
		const int PROJ_DAMAGE = 600;
		const int PROJ_AOE_RANGE = 40;
		const float PROJ_AOE_FALLOFF = 0.1;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_COLLIDEHITBOX = 32;
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
