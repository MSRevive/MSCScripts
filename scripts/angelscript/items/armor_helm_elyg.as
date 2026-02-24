#pragma context server

#include "items/base_elemental_resist.as"
#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmElyg : CGameScript
{
	int ARMOR_BODY;
	int ARMOR_BODY_HUMAN_FEMALE;
	string ARMOR_MODEL;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_TYPE;
	string ELM_AMT;
	string ELM_NAME;
	string ELM_TYPE;
	string SP_ATTRIB;
	float STUN_PROTECTION;

	ArmorHelmElyg()
	{
		ARMOR_MODEL = "armor/p_helmets.mdl";
		ARMOR_BODY = 28;
		ARMOR_BODY_HUMAN_FEMALE = 29;
		ARMOR_TEXT = "You equip the Helm of Venom.";
		BARMOR_TYPE = "platemail";
		BARMOR_PROTECTION = 0.6;
		STUN_PROTECTION = 0.5;
		SP_ATTRIB = "skill.spellcasting.affliction.ratio";
		ELM_NAME = "velm1";
		ELM_TYPE = "poison";
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
