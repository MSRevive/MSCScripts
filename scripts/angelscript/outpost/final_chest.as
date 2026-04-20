#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class FinalChest : CGameScript
{
	void OnSpawn() override
	{
		string SUPER_ID = FindEntityByName("outpost_super");
		if (!((SUPER_ID !is null)))
		{
			DeleteEntity(GetOwner());
			return;
		}
		tc_add_artifact("scroll_lightning_chain", 15);
		tc_add_artifact("scroll2_lightning_chain", 15);
		tc_add_artifact("mana_forget", 15);
	}

	void chest_additems()
	{
		add_gold(RandomInt(200, 1000));
		AddStoreItem(STORENAME, "mana_demon_blood", 1, 0);
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
		AddStoreItem(STORENAME, "health_spotion", 1, 0);
		AddStoreItem(STORENAME, "item_log", 1, 0);
		AddStoreItem(STORENAME, "proj_arrow_silvertipped", 30, 0, 0, 30);
		AddStoreItem(STORENAME, "proj_arrow_jagged", 30, 0, 0, 30);
		AddStoreItem(STORENAME, "proj_arrow_fire", 60, 0, 0, 30);
		AddStoreItem(STORENAME, "proj_arrow_poison", 30, 0, 0, 30);
		AddStoreItem(STORENAME, "proj_arrow_frost", 60, 0, 0, 30);
		AddStoreItem(STORENAME, "proj_arrow_holy", 30, 0, 0, 30);
		if (RandomInt(1, 2) == 1)
		{
			AddStoreItem(STORENAME, "proj_arrow_gholy", 30, 0, 0, 30);
		}
		AddStoreItem(STORENAME, "proj_bolt_fire", 50, 0, 0, 50);
		AddStoreItem(STORENAME, "proj_bolt_iron", 100, 0, 0, 50);
		AddStoreItem(STORENAME, "proj_bolt_silver", 25, 0, 0, 25);
	}

}

}
