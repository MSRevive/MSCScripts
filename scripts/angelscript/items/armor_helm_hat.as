#pragma context server

#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmHat : CGameScript
{
	int ARMOR_BODY;
	string ARMOR_MODEL;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_TYPE;
	float STUN_PROTECTION;

	ArmorHelmHat()
	{
		ARMOR_MODEL = "armor/p_helmets.mdl";
		ARMOR_BODY = 5;
		ARMOR_TEXT = "You put on the funny hat.";
		BARMOR_TYPE = "platemail";
		BARMOR_PROTECTION = 0.0;
		STUN_PROTECTION = 0.99;
	}

	void OnSpawn() override
	{
		SetName("Helmet of Stability");
		SetDescription("This thoroughly padded helmet offers extrodinary stun resistance");
		SetWeight(5);
		SetSize(20);
		SetWearable(1);
		SetValue(1150);
		SetHUDSprite("trade", "helm3");
	}

}

}
