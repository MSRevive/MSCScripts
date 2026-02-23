#pragma context server

#include "items/base_elemental_resist.as"
#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmAlvo1 : CGameScript
{
	ArmorHelmAlvo1()
	{
		const string ARMOR_MODEL = "armor/p_helmets.mdl";
		const int ARMOR_BODY = 30;
		const int ARMOR_BODY_HUMAN_FEMALE = 31;
		const string ARMOR_TEXT = "You equip the Corrodinator.";
		const string BARMOR_TYPE = "platemail";
		const float BARMOR_PROTECTION = 0.6;
		const float STUN_PROTECTION = 0.5;
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
