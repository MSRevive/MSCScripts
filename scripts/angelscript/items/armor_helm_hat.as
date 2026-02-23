#pragma context server

#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmHat : CGameScript
{
	ArmorHelmHat()
	{
		const string ARMOR_MODEL = "armor/p_helmets.mdl";
		const int ARMOR_BODY = 5;
		const string ARMOR_TEXT = "You put on the funny hat.";
		const string BARMOR_TYPE = "platemail";
		const float BARMOR_PROTECTION = 0.0;
		const float STUN_PROTECTION = 0.99;
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
