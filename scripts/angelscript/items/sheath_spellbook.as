#pragma context server

#include "items/sheath_base.as"

namespace MS
{

class SheathSpellbook : CGameScript
{
	SheathSpellbook()
	{
		const string CONTAINER_TYPE = "sheath";
		const int CONTAINER_SPACE = 200;
		const int CONTAINER_MAXITEMS = 40;
		const int CONTAINER_CANCLOSE = 0;
		const int CONTAINER_LOCK_STRENGTH = 0;
		const string CONTAINER_ITEM_ACCEPT = "scroll2";
		const string CONTAINER_ITEM_REJECT = "item_tk_";
		const string ANIM_PREFIX = "evilbook";
		const int MODEL_BODY_OFS = 6;
	}

	void sheath_spawn()
	{
		SetName("Spellbook");
		SetDescription("A book of shadows , designed to hold spell scrolls.");
		SetWeight(1);
		SetSize(60);
		SetValue(40);
		SetWearable(1);
		SetHUDSprite("trade", "ebook");
	}

	void game_fall()
	{
		SetModel("misc/p_misc.mdl");
		string L_SUBMODEL = MODEL_BODY_OFS;
		L_SUBMODEL += 2;
		SetModelBody(0, L_SUBMODEL);
		string L_ANIM = ANIM_PREFIX;
		L_ANIM += "_floor_idle";
		PlayAnim("once", L_ANIM);
	}

	void OnDeploy() override
	{
		SetViewModel(MODEL_VIEW_BOOK);
		SetModel(MODEL_HANDS);
		string L_SUBMODEL = MODEL_BODY_OFS;
		L_SUBMODEL += "game.item.hand_index";
		SetModelBody(0, L_SUBMODEL);
	}

	void sheath_wear()
	{
		SetModel("none");
		SendPlayerMessage("You", "affix a spellbook to your belt.");
	}

}

}
