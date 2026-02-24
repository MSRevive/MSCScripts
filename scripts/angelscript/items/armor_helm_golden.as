#pragma context server

#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmGolden : CGameScript
{
	int ARMOR_BODY;
	string ARMOR_MODEL;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_TYPE;
	float STUN_PROTECTION;

	ArmorHelmGolden()
	{
		ARMOR_MODEL = "armor/p_helmets.mdl";
		ARMOR_BODY = 3;
		ARMOR_TEXT = "You put on the golden platemail helmet.";
		BARMOR_TYPE = "platemail";
		BARMOR_PROTECTION = 0.6;
		STUN_PROTECTION = 0.65;
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
