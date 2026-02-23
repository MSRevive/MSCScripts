#pragma context server

#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmGray : CGameScript
{
	ArmorHelmGray()
	{
		const string ARMOR_MODEL = "armor/p_helmets.mdl";
		const int ARMOR_BODY = 5;
		const string ARMOR_TEXT = "You put on the Helm of Stability.";
		const string BARMOR_TYPE = "platemail";
		const float BARMOR_PROTECTION = 0.6;
		const float STUN_PROTECTION = 0.3;
	}

	void OnSpawn() override
	{
		SetName("Helmet of Stability");
		SetDescription("This thoroughly padded helmet offers extraordinary stun resistance");
		SetWeight(5);
		SetSize(20);
		SetWearable(1);
		SetValue(1150);
		SetHUDSprite("trade", 81);
	}

}

}
