#pragma context server

#include "items/base_item_extras.as"

namespace MS
{

class PackBase : CGameScript
{
	int BLAH;
	int IS_CONTAINER;
	string TRUE_ACCEPT;

	PackBase()
	{
		IS_CONTAINER = 1;
		BLAH = 0;
	}

	void OnSpawn() override
	{
		SetWorldModel(MODEL_WORLD);
		SetHand("any");
		pack_spawn();
		TRUE_ACCEPT = "";
		if (CONTAINER_ITEM_ACCEPT != "CONTAINER_ITEM_ACCEPT")
		{
			TRUE_ACCEPT = CONTAINER_ITEM_ACCEPT;
		}
		string reg.container.type = CONTAINER_TYPE;
		string reg.container.space = CONTAINER_SPACE;
		string reg.container.canclose = CONTAINER_CANCLOSE;
		string reg.container.lock_str = CONTAINER_LOCK_STRENGTH;
		string reg.container.accept_mask = TRUE_ACCEPT;
		string reg.container.reject_mask = CONTAINER_ITEM_REJECT;
		string reg.container.maxitem = CONTAINER_MAXITEMS;
		// TODO: registercontainer
	}

	void OnDeploy() override
	{
		SetViewModel(MODEL_VIEW);
		pack_deploy();
	}

	void game_fall()
	{
		string L_SUBMODEL = MODEL_BODY_OFS;
		L_SUBMODEL += 1;
		string L_ANIM = ANIM_PREFIX;
		L_ANIM += "_floor_idle";
		SetModelBody(0, L_SUBMODEL);
		PlayAnim("once", L_ANIM);
		pack_fall();
	}

	void OnPickup(CBaseEntity@ player) override
	{
		SetModel(MODEL_HANDS);
		if (MODEL_HANDS == "misc/p_misc.mdl")
		{
			int L_SUBMODEL = 16;
		}
		else
		{
			string L_SUBMODEL = MODEL_BODY_OFS;
		}
		L_SUBMODEL -= "game.item.hand_index";
		SetModelBody(0, L_SUBMODEL);
		PlayViewAnim(ANIM_IDLE);
		pack_pickup();
	}

	void game_playeractivate()
	{
		if (!("game.item.container.open"))
		{
			PlayViewAnim(ANIM_OPEN);
			game_opencontainer();
		}
		else
		{
			PlayViewAnim(ANIM_CLOSE);
		}
		pack_playeractivate();
	}

	void game_opencontainer()
	{
		pack_opencontainer();
	}

	void game_wear()
	{
		SetModel(MODEL_WEAR);
		SetModelBody(0, MODEL_BODY_OFS);
		pack_wear();
	}

	void game_show()
	{
		SetModel(MODEL_WEAR);
		SetModelBody(0, MODEL_BODY_OFS);
	}

	void game_container_addeditem()
	{
		if (!(G_DEVELOPER_MODE)) return;
		if (!(IsOnGround(GetOwner()))) return;
		SendInfoMessageToAll("green " + GetEntityName(GetOwner()) + "additem " + GetEntityName(param1));
	}

	void game_container_gaveitem()
	{
		if (!(G_DEVELOPER_MODE)) return;
		if (!(IsOnGround(GetOwner()))) return;
		SendInfoMessageToAll("green " + GetEntityName(GetOwner()) + "gaveitem " + GetEntityName(param1));
	}

	void game_attempt_unlock()
	{
		if (!(G_DEVELOPER_MODE)) return;
		SendInfoMessageToAll("green " + GetEntityName(GetOwner()) + "openby " + GetEntityName(param1));
	}

	void ext_lock()
	{
		SetItemLockStrength(GetOwner(), 1);
		if (!(G_DEVELOPER_MODE)) return;
		SendInfoMessageToAll("green " + GetEntityName(GetOwner()) + " locked.");
	}

	void ext_unlock()
	{
		SetItemLockStrength(GetOwner(), 0);
		if (!(G_DEVELOPER_MODE)) return;
		SendInfoMessageToAll("green " + GetEntityName(GetOwner()) + " unlocked.");
	}

}

}
