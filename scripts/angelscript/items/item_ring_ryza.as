#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemRingRyza : CGameScript
{
	string NEXT_EFFECT;

	ItemRingRyza()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const int MODEL_BODY_OFS = 28;
		const string ANIM_PREFIX = "ring";
		const int EFFECT_DELAY = 25;
	}

	void game_precache()
	{
		Precache("effects/manaring_portals");
	}

	void miscitem_spawn()
	{
		SetName("Binding Trinket");
		SetDescription("You feel a faint thrum of power from the artifact that once bound Ryza.");
		SetViewModel("none");
		SetWorldModel(MODEL_WORLD);
		SetValue(420);
		SetHUDSprite("trade", 226);
	}

	void OnDeploy() override
	{
		if (GetGameTime() >= NEXT_EFFECT)
		{
			NEXT_EFFECT = /* TODO: $math(add) */ GetGameTime();
		}
	}

	void game_attack1()
	{
		if (GetGameTime() >= NEXT_EFFECT)
		{
			NEXT_EFFECT = /* TODO: $math(add) */ GetGameTime();
			portal_effects();
		}
	}

	void portal_effects()
	{
		string SPAWN_POINT = GetEntityOrigin(GetOwner());
		string MY_ANGLES = GetEntityProperty(GetOwner(), "viewangles");
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(MY_ANGLES);
		SPAWN_POINT += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(0, 128, 0));
		SPAWN_POINT += "z";
		ClientEvent("new", "all", "effects/manaring_portals", SPAWN_POINT);
	}

	void game_removefromowner()
	{
		SetModel(MODEL_HANDS);
	}

}

}
