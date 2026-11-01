#pragma context server

#include "items/base_item_extras.as"

namespace MS
{

class BaseMiscitem : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	string MODEL_WORLD;
	string PLAYERANIM_AIM;

	BaseMiscitem()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_VIEW = "none";
		MODEL_BODY_OFS = 16;
		ANIM_PREFIX = "package";
		PLAYERANIM_AIM = "holditem";
	}

	void OnSpawn() override
	{
		SetAnimExt(PLAYERANIM_AIM);
		SetWorldModel(MODEL_WORLD);
		SetViewModel(MODEL_VIEW);
		SetHUDSprite("trade", "package");
		SetWeight(1);
		SetSize(1);
		miscitem_spawn();
	}

	void OnDeploy() override
	{
		miscitem_deploy();
	}

	void OnPickup(CBaseEntity@ player) override
	{
		SetModel(MODEL_HANDS);
		string L_SUBMODEL = MODEL_BODY_OFS;
		L_SUBMODEL -= "game.item.hand_index";
		SetModelBody(0, L_SUBMODEL);
	}

	void game_fall()
	{
		SetModel(MODEL_WORLD);
		if (MODEL_WORLD == "misc/p_misc.mdl")
		{
			string L_SUBMODEL = MODEL_BODY_OFS;
			L_SUBMODEL += 1;
			SetModelBody(0, L_SUBMODEL);
			string L_ANIM = ANIM_PREFIX;
			L_ANIM += "_floor_idle";
			PlayAnim("once", L_ANIM);
		}
		else
		{
			SetModelBody(0, 0);
		}
	}

	void OnDrop() override
	{
		game_fall();
	}

}

}
