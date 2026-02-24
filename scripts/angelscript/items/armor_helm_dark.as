#pragma context server

#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmDark : CGameScript
{
	int ARMOR_BODY;
	string ARMOR_MODEL;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_TYPE;
	float STUN_PROTECTION;

	ArmorHelmDark()
	{
		ARMOR_MODEL = "armor/p_helmets.mdl";
		ARMOR_BODY = 4;
		ARMOR_TEXT = "You put on a dark platemail helmet.";
		BARMOR_TYPE = "platemail";
		BARMOR_PROTECTION = 0.6;
		STUN_PROTECTION = 0.7;
	}

	void OnSpawn() override
	{
		SetName("Dark Platemail Helmet");
		SetDescription("A dark platemail helmet");
		SetWeight(5);
		SetSize(20);
		SetWearable(1);
		SetValue(1150);
		SetHUDSprite("trade", 85);
	}

}

}
