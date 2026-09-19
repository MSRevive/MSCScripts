#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemBracelet : CGameScript
{
	string ANIM_PREFIX;
	int MODEL_BODY_OFS;
	string MODEL_HOLD;
	string MODEL_WORLD;

	ItemBracelet()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HOLD = "misc/p_misc.mdl";
		MODEL_BODY_OFS = 28;
		ANIM_PREFIX = "ring";
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
