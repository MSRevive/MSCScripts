#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemNecroNote : CGameScript
{
	string MODEL_HANDS;
	string MODEL_VIEW;
	string MODEL_WORLD;

	ItemNecroNote()
	{
		MODEL_WORLD = "garbagegibs.mdl";
		MODEL_HANDS = "garbagegibs.mdl";
		MODEL_VIEW = "viewmodels/v_2hblunts.mdl";
	}

	void miscitem_spawn()
	{
		SetName("Letter from Venevus");
		SetDescription("Take this key and meet me in my lair , if you dare.");
		SetViewModel(MODEL_VIEW);
		SetHUDSprite("trade", "letter");
		SetHand("both");
	}

	void OnDeploy() override
	{
		SetViewModel(MODEL_VIEW);
		PlayAnim("once", 22);
		ScheduleDelayedEvent(0.1, "setup_viewmodel");
	}

	void setup_viewmodel()
	{
		// TODO: setviewmodelprop ent_me submodel 0 9
		// TODO: splayviewanim ent_me 22
	}

}

}
