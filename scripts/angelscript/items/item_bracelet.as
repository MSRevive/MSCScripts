#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemBracelet : CGameScript
{
	ItemBracelet()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HOLD = "misc/p_misc.mdl";
		const int MODEL_BODY_OFS = 28;
		const string ANIM_PREFIX = "ring";
	}

	void miscitem_spawn()
	{
		SetName("Bracelet of Friendship");
		SetDescription("Inscription says: Thanks for your help, Hugs and kisses from Salandria");
		SetPlayerModel(MODEL_HANDS);
		SetViewModel("none");
		SetWorldModel(MODEL_WORLD);
		SetWeight(3);
		SetSize(3);
		SetValue(10);
	}

}

}
