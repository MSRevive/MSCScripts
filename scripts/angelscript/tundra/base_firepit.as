#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class BaseFirepit : CGameScript
{
	string TORCH_LIGHT_SCRIPT;

	BaseFirepit()
	{
		TORCH_LIGHT_SCRIPT = "items/item_torch_light";
		Precache(TORCH_LIGHT_SCRIPT);
	}

	void OnSpawn() override
	{
		SetHealth(1);
		SetWidth(40);
		SetHeight(64);
		SetName("fire pit");
		SetRoam(false);
		SetInvincible(2);
		SetModel("misc/item_log.mdl");
	}

	void give_torch()
	{
		ReceiveOffer("accept");
		ClientEvent("persist", "all", TORCH_LIGHT_SCRIPT, GetEntityIndex(GetOwner()), 1);
		gave_torch();
	}

	void game_menu_getoptions()
	{
		if ((ItemExists(param1, "item_torch")))
		{
			string reg.mitem.title = "Light with torch";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_torch";
			string reg.mitem.callback = "give_torch";
		}
	}

}

}
