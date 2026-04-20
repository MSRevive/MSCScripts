#pragma context server

#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmBronze : CGameScript
{
	int ARMOR_BODY;
	string ARMOR_MODEL;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_TYPE;
	float STUN_PROTECTION;

	ArmorHelmBronze()
	{
		ARMOR_MODEL = "armor/p_helmets.mdl";
		ARMOR_BODY = 9;
		ARMOR_TEXT = "You put on a bronze helmet.";
		BARMOR_TYPE = "platemail";
		BARMOR_PROTECTION = 0.25;
		STUN_PROTECTION = 0.85;
	}

	void OnSpawn() override
	{
		SetName("Bronze Helmet");
		SetDescription("A light helmet made of padding and a thin layer of bronze");
		SetWeight(5);
		SetSize(15);
		SetValue(30);
		SetHUDSprite("trade", 87);
	}

}

}
