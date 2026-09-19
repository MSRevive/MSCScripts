#pragma context server

#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmMongol : CGameScript
{
	int ARMOR_BODY;
	string ARMOR_MODEL;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_TYPE;
	float STUN_PROTECTION;

	ArmorHelmMongol()
	{
		ARMOR_MODEL = "armor/p_helmets.mdl";
		ARMOR_BODY = 1;
		ARMOR_TEXT = "You put on a decorated platemail helmet.";
		BARMOR_TYPE = "platemail";
		BARMOR_PROTECTION = 0.5;
		STUN_PROTECTION = 0.8;
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
