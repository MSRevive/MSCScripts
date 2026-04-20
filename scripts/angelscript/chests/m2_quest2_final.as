#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class M2Quest2Final : CGameScript
{
	int TOLD_SYPH;

	void chest_additems()
	{
		AddStoreItem(STORENAME, "swords_spiderblade", 1, 0);
		AddStoreItem(STORENAME, "mana_prot_spiders", 1, 0);
		add_noob_item();
		add_noob_item();
		add_good_item();
		add_good_item();
		add_great_item();
		if ("game.playersnb" > 1)
		{
			add_great_item();
		}
		add_gold(200);
		AddStoreItem(STORENAME, "proj_arrow_blunt", 15, 0, 0, 15);
	}

	void OnUse(CBaseEntity@ activator, CBaseEntity@ caller, int useType) override
	{
		if ((TOLD_SYPH)) return;
		TOLD_SYPH = 1;
		CallExternal(FindEntityByName("sylphiel"), "ext_saw_chest");
	}

}

}
