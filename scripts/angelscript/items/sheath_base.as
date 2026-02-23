#pragma context server

#include "items/pack_base.as"

namespace MS
{

class SheathBase : CGameScript
{
	SheathBase()
	{
		const int IS_CONTAINER = 1;
		const string MODEL_VIEW = "none";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_WEAR = "armor/packs/sheathes_wear.mdl";
	}

	void pack_spawn()
	{
		sheath_spawn();
	}

	void pack_deploy()
	{
		sheath_deploy();
	}

	void game_fall()
	{
		SetModel(MODEL_WORLD);
		SetModelBody(0, 17);
		PlayAnim("once", "package_floor_idle");
		sheath_fall();
	}

	void pack_pickup()
	{
		sheath_pickup();
	}

	void pack_opencontainer()
	{
		sheath_opencontainer();
	}

	void pack_wear()
	{
		sheath_wear();
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
