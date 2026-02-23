#pragma context server

#include "items/base_crest.as"

namespace MS
{

class CrestW1 : CGameScript
{
	int IS_RESERVED;

	CrestW1()
	{
		const int MODEL_CREST_OFS = 31;
		const string MODEL_WEAR = "armor/p_gowns.mdl";
	}

	void crest_spawn()
	{
		SetName("Avocado s Wallpaper Crest 2012");
		SetDescription("Reward for MSC Wallpaper Contest 2012");
	}

	void OnDeploy() override
	{
		if ((IS_RESERVED)) return;
		IS_RESERVED = 1;
		array<string> PICKUP_ALLOW_LIST;
		PICKUP_ALLOW_LIST.insertLast(GetEntityIndex(GetOwner()));
	}

	void game_fall()
	{
		if ((IS_RESERVED)) return;
		IS_RESERVED = 1;
		array<string> PICKUP_ALLOW_LIST;
		PICKUP_ALLOW_LIST.insertLast(GetEntityIndex(GetOwner()));
	}

	void game_restricted()
	{
		string OUT_MSG = "This crest is reserved for ";
		string ITEM_RESERVER = /* TODO: $get_array */ $get_array(PICKUP_ALLOW_LIST, 0);
		OUT_MSG += GetEntityName(ITEM_RESERVER);
		SendInfoMsg(param1, "Item Restricted OUT_MSG");
	}

}

}
