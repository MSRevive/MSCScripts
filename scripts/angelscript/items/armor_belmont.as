#pragma context server

#include "items/base_elemental_resist.as"
#include "items/armor_base.as"

namespace MS
{

class ArmorBelmont : CGameScript
{
	int ARMOR_BODY;
	int ARMOR_GROUP;
	string ARMOR_MODEL;
	int ARMOR_STR_REQ;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_PROTECTION_AREA;
	string BARMOR_REPLACE_BODYPARTS;
	string BARMOR_TYPE;
	int BER_ACTIVATE_WHILE_WORN;
	int EFFECT_ACTIVE;
	int NEW_ARMOR_OFS;
	int REG_SPECIAL_EFFECT;

	ArmorBelmont()
	{
		ARMOR_MODEL = "armor/p_armorvest2.mdl";
		ARMOR_GROUP = 4;
		ARMOR_BODY = 0;
		ARMOR_TEXT = "You don the Armor of Bravery.";
		BARMOR_TYPE = "platemail";
		BARMOR_PROTECTION = 0.4;
		BARMOR_PROTECTION_AREA = "chest;arms;legs";
		BARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		REG_SPECIAL_EFFECT = 1;
		BER_ACTIVATE_WHILE_WORN = 1;
		ARMOR_STR_REQ = 40;
		NEW_ARMOR_OFS = 10;
	}

	void OnSpawn() override
	{
		SetName("Armor of Bravery");
		SetDescription("The bloodstains tell tales of brave warriors fallen in battle.");
		SetWeight(120);
		SetSize(60);
		SetWearable(1);
		SetValue(590);
		SetHUDSprite("trade", 150);
	}

	void elm_activate_effect()
	{
		if (!(true)) return;
		if (!(GetEntityProperty(GetOwner(), "is_worn"))) return;
		if ((EFFECT_ACTIVE)) return;
		SendColoredMessage(GetOwner(), "You are now... stylin'...");
		EFFECT_ACTIVE = 1;
	}

	void elm_remove_effect()
	{
		if (!(true)) return;
		EFFECT_ACTIVE = 0;
		SendColoredMessage(GetOwner(), "You feel normal.");
	}

	void ext_activate_items()
	{
		if (!(param1 == GetEntityIndex(GetOwner()))) return;
		EFFECT_ACTIVE = 0;
	}

}

}
