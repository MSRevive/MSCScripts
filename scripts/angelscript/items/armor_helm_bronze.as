#pragma context server

#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmBronze : CGameScript
{
	ArmorHelmBronze()
	{
		const string ARMOR_MODEL = "armor/p_helmets.mdl";
		const int ARMOR_BODY = 9;
		const string ARMOR_TEXT = "You put on a bronze helmet.";
		const string BARMOR_TYPE = "platemail";
		const float BARMOR_PROTECTION = 0.25;
		const float STUN_PROTECTION = 0.85;
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
