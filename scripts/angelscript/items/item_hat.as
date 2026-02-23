#pragma context server

#include "items/armor_base_helmet.as"

namespace MS
{

class ItemHat : CGameScript
{
	ItemHat()
	{
		const string ARMOR_MODEL = "armor/p_helmets.mdl";
		const int ARMOR_BODY = 11;
		const string ARMOR_TEXT = "You put on the funny hat.";
		const string BARMOR_TYPE = "platemail";
		const float BARMOR_PROTECTION = 0.0;
		const int STUN_PROTECTION = 1;
	}

	void OnSpawn() override
	{
		SetName("Funny Looking Hat");
		SetDescription("A funny looking hat. Who d wear this thing anyways?");
		SetWeight(1);
		SetSize(1);
		SetWearable(1);
		SetValue(1);
		SetHUDSprite("trade", 90);
	}

}

}
