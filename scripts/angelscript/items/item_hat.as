#pragma context server

#include "items/armor_base_helmet.as"

namespace MS
{

class ItemHat : CGameScript
{
	int ARMOR_BODY;
	string ARMOR_MODEL;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_TYPE;
	int STUN_PROTECTION;

	ItemHat()
	{
		ARMOR_MODEL = "armor/p_helmets.mdl";
		ARMOR_BODY = 11;
		ARMOR_TEXT = "You put on the funny hat.";
		BARMOR_TYPE = "platemail";
		BARMOR_PROTECTION = 0.0;
		STUN_PROTECTION = 1;
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
