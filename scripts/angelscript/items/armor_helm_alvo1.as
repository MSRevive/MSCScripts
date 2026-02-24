#pragma context server

#include "items/base_elemental_resist.as"
#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmAlvo1 : CGameScript
{
	int ARMOR_BODY;
	int ARMOR_BODY_HUMAN_FEMALE;
	string ARMOR_MODEL;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_TYPE;
	float STUN_PROTECTION;

	ArmorHelmAlvo1()
	{
		ARMOR_MODEL = "armor/p_helmets.mdl";
		ARMOR_BODY = 30;
		ARMOR_BODY_HUMAN_FEMALE = 31;
		ARMOR_TEXT = "You equip the Corrodinator.";
		BARMOR_TYPE = "platemail";
		BARMOR_PROTECTION = 0.6;
		STUN_PROTECTION = 0.5;
	}

	void OnSpawn() override
	{
		SetName("Corrodinator");
		SetDescription("Increases duration of your poison and acid effects.");
		SetWeight(1);
		SetSize(20);
		SetWearable(1);
		SetValue(1000);
		SetHUDSprite("trade", 49);
	}

	void elm_activate_effect()
	{
		CallExternal(GetOwner(), "ext_register_corrode", 2.0);
	}

	void elm_remove_effect()
	{
		CallExternal(GetOwner(), "ext_register_corrode", 0);
	}

}

}
