#pragma context server

#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmMongol : CGameScript
{
	ArmorHelmMongol()
	{
		const string ARMOR_MODEL = "armor/p_helmets.mdl";
		const int ARMOR_BODY = 1;
		const string ARMOR_TEXT = "You put on a decorated platemail helmet.";
		const string BARMOR_TYPE = "platemail";
		const float BARMOR_PROTECTION = 0.5;
		const float STUN_PROTECTION = 0.8;
	}

	void OnSpawn() override
	{
		SetName("Decorated Helmet");
		SetDescription("A decorated platemail helmet");
		SetWeight(20);
		SetSize(20);
		SetWearable(1);
		SetValue(250);
		SetHUDSprite("trade", "helm2");
	}

}

}
