#pragma context server

#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmGolden : CGameScript
{
	ArmorHelmGolden()
	{
		const string ARMOR_MODEL = "armor/p_helmets.mdl";
		const int ARMOR_BODY = 3;
		const string ARMOR_TEXT = "You put on the golden platemail helmet.";
		const string BARMOR_TYPE = "platemail";
		const float BARMOR_PROTECTION = 0.6;
		const float STUN_PROTECTION = 0.65;
	}

	void OnSpawn() override
	{
		SetName("Golden Platemail Helmet");
		SetDescription("A golden platemail helmet");
		SetWeight(20);
		SetSize(40);
		SetWearable(1);
		SetValue(2500);
		SetHUDSprite("trade", 84);
	}

}

}
