#pragma context server

#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmKnight : CGameScript
{
	int ARMOR_BODY;
	string ARMOR_MODEL;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_TYPE;
	float STUN_PROTECTION;

	ArmorHelmKnight()
	{
		ARMOR_MODEL = "armor/p_helmets.mdl";
		ARMOR_BODY = 2;
		ARMOR_TEXT = "You put on a knight's platemail helmet.";
		BARMOR_TYPE = "platemail";
		BARMOR_PROTECTION = 0.6;
		STUN_PROTECTION = 0.75;
	}

	void OnSpawn() override
	{
		SetName("Knight s Platemail Helmet");
		SetDescription("A knight s platemail helmet");
		SetWeight(40);
		SetSize(30);
		SetWearable(1);
		SetValue(530);
		SetHUDSprite("trade", "helm3");
	}

}

}
