#pragma context server

#include "items/base_melee.as"

namespace MS
{

class SwordsDynamic : CGameScript
{
	string ANIM_USE;
	int CUR_PROP;
	string MODEL_VIEW;
	string PRESS_DELAY;

	SwordsDynamic()
	{
		MODEL_VIEW = "weapons/1hbigsword_rview.mdl";
		const string MODEL_HANDS = "weapons/p_weapons1.mdl";
		const string MODEL_WORLD = "weapons/p_weapons1.mdl";
		const int MODEL_BODY_OFS = 28;
		const string ANIM_PREFIX = "shortsword";
	}

	void weapon_spawn()
	{
		SetName("Dynamic Sword");
		SetDescription("Special developer tool , does no damage command: . dsword < sub> < anim>");
		SetWeight(30);
		SetSize(5);
		SetValue(15);
		SetHUDSprite("trade", "shortsword");
	}

	void OnDeploy() override
	{
		if (!(true)) return;
		// TODO: setviewmodelprop ent_owner submodel 0
		CUR_PROP = 0;
	}

	void register_normal()
	{
	}

	void ext_sub()
	{
		if (!(true)) return;
		LogMessage("ent_owner setviewmodelprop ent_owner submodel 1 PARAM1");
		// TODO: setviewmodelprop ent_owner submodel PARAM1
		CUR_PROP = param1;
		ANIM_USE = param2;
		// TODO: splayviewanim ent_me ANIM_USE
	}

	void game_attack1()
	{
		if (!(true)) return;
		// TODO: splayviewanim ent_me ANIM_USE
	}

	void game_+attack2()
	{
		if (!(true)) return;
		if (!(GetGameTime() > PRESS_DELAY)) return;
		PRESS_DELAY = GetGameTime();
		PRESS_DELAY += 0.25;
		CUR_PROP += 1;
		// TODO: setviewmodelprop ent_owner submodel CUR_PROP
		LogMessage("ent_owner using CUR_PROP");
	}

}

}
