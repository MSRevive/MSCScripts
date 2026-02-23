#pragma context server

#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmDark : CGameScript
{
	ArmorHelmDark()
	{
		const string ARMOR_MODEL = "armor/p_helmets.mdl";
		const int ARMOR_BODY = 4;
		const string ARMOR_TEXT = "You put on a dark platemail helmet.";
		const string BARMOR_TYPE = "platemail";
		const float BARMOR_PROTECTION = 0.6;
		const float STUN_PROTECTION = 0.7;
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
