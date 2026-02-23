#pragma context server

#include "items/base_elemental_resist.as"
#include "items/armor_base.as"

namespace MS
{

class ArmorBelmont : CGameScript
{
	int EFFECT_ACTIVE;

	ArmorBelmont()
	{
		const string ARMOR_MODEL = "armor/p_armorvest2.mdl";
		const int ARMOR_GROUP = 4;
		const int ARMOR_BODY = 0;
		const string ARMOR_TEXT = "You don the Armor of Bravery.";
		const string BARMOR_TYPE = "platemail";
		const float BARMOR_PROTECTION = 0.4;
		const string BARMOR_PROTECTION_AREA = "chest;arms;legs";
		const string BARMOR_REPLACE_BODYPARTS = BARMOR_PROTECTION_AREA;
		const int REG_SPECIAL_EFFECT = 1;
		const int BER_ACTIVATE_WHILE_WORN = 1;
		const int ARMOR_STR_REQ = 40;
		const int NEW_ARMOR_OFS = 10;
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
