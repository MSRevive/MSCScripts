#pragma context server

#include "items/base_item_extras.as"

namespace MS
{

class BaseSheath : CGameScript
{
	BaseSheath()
	{
		const int IS_CONTAINER = 1;
		const string MODEL_VIEW = "none";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_WEAR = "armor/packs/sheathes_wear.mdl";
	}

	void OnSpawn() override
	{
		SetWorldModel(MODEL_WORLD);
		SetHand("any");
		sheath_spawn();
		// TODO: registercontainer
	}

	void OnDeploy() override
	{
		SetViewModel(MODEL_VIEW);
		sheath_deploy();
	}

	void game_fall()
	{
		SetModel(MODEL_WORLD);
		SetModelBody(0, 17);
		PlayAnim("once", "package_floor_idle");
		sheath_fall();
	}

	void OnPickup(CBaseEntity@ player) override
	{
		SetModel(MODEL_HANDS);
		int L_SUBMODEL = 16;
		L_SUBMODEL -= "game.item.hand_index";
		SetModelBody(0, L_SUBMODEL);
		sheath_pickup();
	}

	void game_opencontainer()
	{
		sheath_opencontainer();
	}

	void game_wear()
	{
		SetModel(MODEL_WEAR);
		SetModelBody(0, MODEL_BODY_OFS);
		sheath_wear();
	}

	void game_show()
	{
		SetModel(MODEL_WEAR);
		SetModelBody(0, MODEL_BODY_OFS);
	}

	void game_container_addeditem()
	{
		set_body();
	}

	void game_container_removeditem()
	{
		set_body();
	}

	void set_body()
	{
		string temp = MODEL_BODY_OFS;
		if ("game.item.container.items" > 0)
		{
			temp -= 1;
			SetModelBody(0, temp);
		}
		else
		{
			SetModelBody(0, MODEL_BODY_OFS);
		}
	}

}

}
