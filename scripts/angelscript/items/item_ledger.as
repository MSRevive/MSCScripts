#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemLedger : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HOLD;
	string MODEL_WORLD;

	ItemLedger()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HOLD = "misc/p_misc.mdl";
		MODEL_BODY_OFS = 4;
		ANIM_PREFIX = "oldbook";
	}

	void miscitem_spawn()
	{
		SetName("Ledger");
		SetDescription("A ledger full of transactions and accounts.");
		SetPlayerModel(MODEL_HANDS);
		SetViewModel("none");
		SetWorldModel(MODEL_WORLD);
		SetWeight(5);
		SetSize(5);
		SetValue(0);
		SetHUDSprite("trade", "book");
	}

}

}
