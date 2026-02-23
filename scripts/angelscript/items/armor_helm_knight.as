#pragma context server

#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmKnight : CGameScript
{
	ArmorHelmKnight()
	{
		const string ARMOR_MODEL = "armor/p_helmets.mdl";
		const int ARMOR_BODY = 2;
		const string ARMOR_TEXT = "You put on a knight's platemail helmet.";
		const string BARMOR_TYPE = "platemail";
		const float BARMOR_PROTECTION = 0.6;
		const float STUN_PROTECTION = 0.75;
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
