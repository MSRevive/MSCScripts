#pragma context server

#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmPlate : CGameScript
{
	int ARMOR_BODY;
	string ARMOR_MODEL;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_TYPE;
	float STUN_PROTECTION;

	ArmorHelmPlate()
	{
		ARMOR_MODEL = "armor/p_helmets.mdl";
		ARMOR_BODY = 0;
		ARMOR_TEXT = "You put on a platemail helmet.";
		BARMOR_TYPE = "platemail";
		BARMOR_PROTECTION = 0.3;
		STUN_PROTECTION = 0.8;
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
