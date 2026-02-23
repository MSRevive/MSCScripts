#pragma context server

#include "items/base_item_extras.as"

namespace MS
{

class BaseMiscitem : CGameScript
{
	BaseMiscitem()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_VIEW = "none";
		const int MODEL_BODY_OFS = 16;
		const string ANIM_PREFIX = "package";
		const string PLAYERANIM_AIM = "holditem";
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
