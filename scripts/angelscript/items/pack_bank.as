#pragma context server

namespace MS
{

class PackBank : CGameScript
{
	string TRUE_ACCEPT;

	PackBank()
	{
		const string MODEL_VIEW = "none";
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_WORLD = "armor/packs/p_packs.mdl";
		const string MODEL_WEAR = "armor/packs/p_packs.mdl";
		const string BANK_NAME = "Edana";
		const string CONTAINER_TYPE = "generic";
		const int CONTAINER_SPACE = 200;
		const int CONTAINER_MAXITEMS = 32;
		const string CONTAINER_ITEM_REJECT = "sheath;pack;bolt;arrow;health;mana_mpotion";
		const int MODEL_BODY_OFS = 6;
		const string ANIM_PREFIX = "none";
	}

	void pack_spawn()
	{
		SetName("BANK_NAME Bank Signet");
		SetDescription("This ticket gives access to your Edana bank account.");
		SetWeight(0);
		SetSize(0);
		SetValue(5000);
		SetWearable(1);
		SetHUDSprite("trade", "ring");
	}

	void pack_deploy()
	{
		SetViewModel("none");
	}

	void pack_wear()
	{
		SendPlayerMessage("You", "put on your BANK_NAME bank signet ring.");
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
		if (GetMapName() == "edana")
		{
			int CONTAINER_LOCK_STRENGTH = 0;
			int CONTAINER_CANCLOSE = 0;
		}
		if (GetMapName() != "edana")
		{
			int CONTAINER_LOCK_STRENGTH = 10000;
			int CONTAINER_CANCLOSE = 1;
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

	void game_container_addeditem()
	{
		SendPlayerMessage("Added", "PARAM1 to BANK_NAME bank");
		string IN_ITEM_WEIGHT = GetEntityProperty(param1, "weight");
		SetWeight(/* TODO: $neg */ $neg(IN_ITEM_WEIGHT));
	}

	void game_container_removeditem()
	{
		SendPlayerMessage("Removed", "PARAM1 from BANK_NAME bank");
		string OUT_ITEM_WEIGHT = GetEntityProperty(param1, "weight");
		SetWeight(OUT_ITEM_WEIGHT);
	}

}

}
