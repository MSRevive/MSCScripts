#pragma context server

#include "items/base_elemental_resist.as"
#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmElyg : CGameScript
{
	string ELM_AMT;

	ArmorHelmElyg()
	{
		const string ARMOR_MODEL = "armor/p_helmets.mdl";
		const int ARMOR_BODY = 28;
		const int ARMOR_BODY_HUMAN_FEMALE = 29;
		const string ARMOR_TEXT = "You equip the Helm of Venom.";
		const string BARMOR_TYPE = "platemail";
		const float BARMOR_PROTECTION = 0.6;
		const float STUN_PROTECTION = 0.5;
		const string SP_ATTRIB = "skill.spellcasting.affliction.ratio";
		const string ELM_NAME = "velm1";
		const string ELM_TYPE = "poison";
	}

	void OnSpawn() override
	{
		SetName("Helm of Venom");
		SetDescription("This battered helm protects the wearer from poisons");
		SetWeight(1);
		SetSize(20);
		SetWearable(1);
		SetValue(1000);
		SetHUDSprite("trade", 49);
	}

	void elm_get_resist()
	{
		ELM_AMT = GetEntityProperty(GetOwner(), "sp_attrib");
		ELM_AMT *= 2;
		ELM_AMT *= 100;
		if (ELM_AMT > 25)
		{
			ELM_AMT = 25;
		}
	}

	void elm_activate_effect()
	{
		CallExternal(GetOwner(), "ext_register_element", "velm2", "acid", ELM_AMT);
	}

	void elm_remove_effect()
	{
		CallExternal(GetOwner(), "ext_register_element", "velm2", "remove");
	}

}

}
