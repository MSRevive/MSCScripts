#pragma context server

#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmPlate : CGameScript
{
	ArmorHelmPlate()
	{
		const string ARMOR_MODEL = "armor/p_helmets.mdl";
		const int ARMOR_BODY = 0;
		const string ARMOR_TEXT = "You put on a platemail helmet.";
		const string BARMOR_TYPE = "platemail";
		const float BARMOR_PROTECTION = 0.3;
		const float STUN_PROTECTION = 0.8;
	}

	void OnSpawn() override
	{
		SetName("Platemail Helmet");
		SetDescription("A platemail helmet");
		SetWeight(15);
		SetSize(15);
		SetValue(100);
		SetHUDSprite("trade", "helm1");
	}

}

}
